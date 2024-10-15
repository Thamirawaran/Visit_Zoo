# src/gui.py

import pygame
from model import Section
from users import HistoryManager
from utils import load_image, load_sound, load_font
import os
import time

class Button:
    def __init__(self, name, image, position, callback=None):
        self.name = name
        self.image = image
        self.rect = self.image.get_rect(center=position)
        self.callback = callback
        self.enabled = False

    def draw(self, surface, font):
        """Draws the button on the given surface."""
        if self.enabled:
            pygame.draw.ellipse(surface, (144, 238, 144), self.rect)  # Light green fill
        else:
            pygame.draw.ellipse(surface, (169, 169, 169), self.rect)  # Grey fill for disabled

        # Blit the image
        image_rect = self.image.get_rect(center=self.rect.center)
        surface.blit(self.image, image_rect.topleft)

        # # Render the text
        # text_surf = font.render(self.name, True, (139, 69, 19))  # Brown color
        # text_rect = text_surf.get_rect(center=self.rect.center)
        # surface.blit(text_surf, text_rect.topleft)

    def is_clicked(self, pos):
        """Checks if the button is clicked based on the mouse position."""
        return self.enabled and self.rect.collidepoint(pos)

class GUI:
    def __init__(self, screen: pygame.Surface, history_manager: HistoryManager):
        self.screen = screen
        self.history_manager = history_manager
        self.sections = []
        self.buttons = []
        self.lines = []  # Lines connecting sections
        self.current_photo = None
        self.photo_start_time = None
        self.photo_display = False

        # Load assets
        self.images = {
            'common': load_image('common.png'),
            'animals': load_image('animals.png'),
            'birds': load_image('birds.png'),
            'fish': load_image('fish.png'),
            'museum': load_image('museum.png'),
            'lion': load_image('lion.png'),
            'elephant': load_image('elephant.png'),
            'parrot': load_image('parrot.png'),
            'humming': load_image('humming.png'),
            'dolphin': load_image('dolphin.png'),
            'gold': load_image('gold.png'),
            'stop': load_image('stop.png'),
            'back': load_image('back.png'),
            'placeholder': load_image('placeholder.png'),  # Placeholder for photos
        }

        self.font = load_font('arial.ttf', 20)
        self.large_font = load_font('arial.ttf', 30)

        # Load sounds
        self.click_sound = load_sound('click.wav')
        pygame.mixer.music.load(os.path.join('assets', 'sounds', 'background.mp3'))
        pygame.mixer.music.play(-1)  # Loop indefinitely

        # Initialize buttons
        self.initialize_buttons()

    def initialize_buttons(self):
        """Initializes all section buttons and control buttons."""
        # Initialize control buttons: Stop and Back
        self.stop_button = Button('', self.images['stop'], (450, 550), callback=self.stop_game)
        self.stop_button.enabled = True  # Always enabled

        self.back_button = Button('', self.images['back'], (600, 550), callback=self.go_back)
        self.back_button.enabled = False  # Initially disabled

        self.buttons.append(self.stop_button)
        self.buttons.append(self.back_button)

    def add_section(self, section: Section, parent: Section = None):
        """Adds a section and creates its button. Also draws lines if there's a parent."""
        self.sections.append(section)
        button = Button(section.name, self.images.get(section.name.lower(), self.images['common']), section.position)
        button.enabled = section.enabled
        self.buttons.append(button)

        if parent:
            # Draw a line from parent to this section
            self.lines.append((parent.position, section.position))

    def draw_hierarchy(self):
        """Draws lines connecting sections to represent hierarchy."""
        for line in self.lines:
            start_pos, end_pos = line
            pygame.draw.line(self.screen, (0, 0, 0), start_pos, end_pos, 2)  # Black lines

    def draw_buttons(self):
        """Draws all buttons on the screen."""
        for button in self.buttons:
            button.draw(self.screen, self.font)

    def handle_click(self, pos):
        """Handles mouse click events."""
        if self.photo_display:
            # Ignore clicks while showing photo
            return

        for button in self.buttons:
            if button.is_clicked(pos):
                self.click_sound.play()
                if button.callback:
                    button.callback()
                else:
                    # Handle section button click
                    self.handle_section_button_click(button.name)
                break

    def handle_section_button_click(self, section_name):
        """Handles clicks on section buttons."""
        # Find the section object
        section = next((s for s in self.sections if s.name == section_name), None)
        if not section:
            return

        # Push current state to history
        current_enabled = [btn.name for btn in self.buttons if btn.enabled and btn.name not in ['Stop', 'Back']]
        self.history_manager.push(current_enabled)

        # Show photo
        self.current_photo = self.images.get(section.name.lower(), self.images['placeholder'])
        self.photo_start_time = time.time()
        self.photo_display = True

        # Disable the clicked section
        for btn in self.buttons:
            if btn.name == section.name:
                btn.enabled = False
                break

        # Enable connected sections
        for connected in section.connected_sections:
            for btn in self.buttons:
                if btn.name == connected.name:
                    btn.enabled = True
                    break

        # Enable Back button
        self.back_button.enabled = True

    def stop_game(self):
        """Stops the game."""
        pygame.quit()
        sys.exit()

    def go_back(self):
        """Navigates back to the previous state."""
        previous_enabled = self.history_manager.pop()
        if previous_enabled:
            # Disable all section buttons first
            for btn in self.buttons:
                if btn.name not in ['Stop', 'Back']:
                    btn.enabled = False

            # Enable buttons based on previous state
            for btn in self.buttons:
                if btn.name in previous_enabled:
                    btn.enabled = True

            # Disable Back button if no more history
            if not self.history_manager.has_history():
                self.back_button.enabled = False

    def render_photo(self):
        """Renders the photo and handles the 10-second display."""
        if self.photo_display and self.current_photo:
            # Draw a semi-transparent overlay
            overlay = pygame.Surface(self.screen.get_size(), pygame.SRCALPHA)
            overlay.fill((0, 0, 0, 180))  # Semi-transparent black
            self.screen.blit(overlay, (0, 0))

            # Draw the photo at the center
            photo_rect = self.current_photo.get_rect(center=(400, 300))
            self.screen.blit(self.current_photo, photo_rect.topleft)

            # Check if 10 seconds have passed
            if time.time() - self.photo_start_time > 4:
                self.photo_display = False
                self.current_photo = None

    def render(self):
        """Renders all GUI elements on the screen."""
        bg = pygame.image.load("assets\\images\\bg.png")
        self.screen.fill((34, 139, 34))  # Forest green background
        self.screen.blit(bg,(0,0))
        # Draw hierarchy lines
        self.draw_hierarchy()

        # Draw buttons
        self.draw_buttons()

        # Render Stop and Back buttons on top
        self.stop_button.draw(self.screen, self.font)
        self.back_button.draw(self.screen, self.font)

        # Render photo if needed
        if self.photo_display:
            self.render_photo()

        # Update the display
        pygame.display.flip()
