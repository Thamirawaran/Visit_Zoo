# src/main.py

import pygame
import sys
from gui import GUI
from model import Section
from users import HistoryManager

def main():
    # Initialize Pygame
    pygame.init()

    # Screen dimensions
    WIDTH, HEIGHT = 800, 600
    screen = pygame.display.set_mode((WIDTH, HEIGHT))
    pygame.display.set_caption("Zoo Management Game")

    # Clock to control frame rate
    clock = pygame.time.Clock()
    FPS = 60

    # Initialize History Manager
    history_manager = HistoryManager()

    # Initialize GUI
    gui = GUI(screen, history_manager)

    # Define Sections with positions
    sections = [
        Section(name='Common', position=(400, 300), image_path='common.png', enabled=True),
        Section(name='Animals', position=(300, 200), image_path='animals.png'),
        Section(name='Birds', position=(500, 200), image_path='birds.png'),
        Section(name='Fish', position=(300, 400), image_path='fish.png'),
        Section(name='Museum', position=(500, 400), image_path='museum.png'),
        # Subsections
        Section(name='Lion', position=(200, 100), image_path='lion.png'),
        Section(name='Elephant', position=(100, 150), image_path='elephant.png'),
        Section(name='Parrot', position=(600, 100), image_path='parrot.png'),
        Section(name='Humming', position=(700, 150), image_path='humming.png'),
        Section(name='Dolphin', position=(200, 500), image_path='dolphin.png'),
        Section(name='Gold', position=(100, 450), image_path='gold.png'),
    ]

    # Define connections
    connections = {
        'Common': ['Animals', 'Birds', 'Fish', 'Museum'],
        'Animals': ['Lion', 'Elephant'],
        'Birds': ['Parrot', 'Humming'],
        'Fish': ['Dolphin', 'Gold'],
        'Museum': [],
        # Subsections have no further connections
    }

    # Link sections
    section_dict = {section.name: section for section in sections}
    for parent, children in connections.items():
        parent_section = section_dict[parent]
        for child in children:
            child_section = section_dict[child]
            parent_section.connected_sections.append(child_section)

    # Add sections to GUI
    for section in sections:
        gui.add_section(section, parent=section_dict.get(section.name, None))

    # Main game loop
    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False

            elif event.type == pygame.MOUSEBUTTONDOWN:
                if event.button == 1:  # Left click
                    gui.handle_click(event.pos)

        # Render GUI
        gui.render()

        # Cap the frame rate
        clock.tick(FPS)

    # Quit Pygame
    pygame.quit()
    sys.exit()

if __name__ == "__main__":
    main()
