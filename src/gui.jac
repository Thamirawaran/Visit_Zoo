import:py pygame ;
import from model, Section ;
import from users, HistoryManager;
import from utils, load_image, load_sound, load_font ;
import:py os ;
import:py time ;

obj Button {
    can init(name: Any, image: Any, position: Any, callback: Any=None) {

        self.name = name;    
        self.image = image;    
        self.rect = self.image.get_rect(center=position);    
        self.callback = callback;    
        self.enabled = False;
    }
    
    can draw(surface: Any, font: Any) {

        """Draws the button on the given surface.""" ;    
        if self.enabled {

            pygame.draw.ellipse(surface, (144, 238, 144), self.rect) ;
        } else {

            pygame.draw.ellipse(surface, (169, 169, 169), self.rect) ;
        }
        

        image_rect = self.image.get_rect(center=self.rect.center);    

        surface.blit(self.image, image_rect.topleft) ;
    }
    
    can is_clicked(pos: Any) {

        """Checks if the button is clicked based on the mouse position.""" ;    
        return self.enabled and self.rect.collidepoint(pos) ;
    }
}

obj GUI {
    can init(screen: pygame.Surface, history_manager: HistoryManager) {
        self.screen = screen;    
        self.history_manager = history_manager;    
        self.sections = [];
        self.buttons = [];
        self.lines = [];
        self.current_photo = None;    
        self.photo_start_time = None;    
        self.photo_display = False;    
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
            'placeholder': load_image('placeholder.png')
        };    
        self.font = load_font('arial.ttf', 20);    
        self.large_font = load_font('arial.ttf', 30);    
        self.click_sound = load_sound('click.wav');    
        pygame.mixer.music.load(
            os.path.join('assets', 'sounds', 'background.mp3')
        ) ;    
        pygame.mixer.music.play(-1) ;    
        self.initialize_buttons() ;
    }
    
    can initialize_buttons() {
        """Initializes all section buttons and control buttons.""" ;
        self.stop_button = Button('Stop',self.images['stop'],(450, 550), callback=self.stop_game);    
        self.stop_button.enabled = True;    
        self.back_button = Button('Back',self.images['back'],(600, 550),callback=self.go_back);    
        self.back_button.enabled = False;    
        self.buttons.append(self.stop_button) ;    
        self.buttons.append(self.back_button) ;
    }
    
    can add_section(section: Section, parent: Section=None) {
        """Adds a section and creates its button. Also draws lines if there's a parent.""" ;    
        self.sections.append(section) ;    
        button = Button(section.name, self.images.get( section.name.lower(), self.images['common']), section.position);
        button.enabled = section.enabled;    
        self.buttons.append(button) ;    
        if parent {
            self.lines.append((parent.position, section.position)) ;
        }
    }
    
    can draw_hierarchy() {
        """Draws lines connecting sections to represent hierarchy.""" ;    
        for line in self.lines {
            (start_pos, end_pos) = line;    
            pygame.draw.line(self.screen, (0, 0, 0), start_pos, end_pos, 2);
        }
    }
    
    can draw_buttons() {
        """Draws all buttons on the screen.""" ;    
        for button in self.buttons {
            button.draw(self.screen, self.font) ;
        }
    }
    
    can handle_click(pos: Any) {
        """Handles mouse click events.""" ;    
        if self.photo_display {
            return ;
        }

        
        for button in self.buttons {
            if button.is_clicked(pos) {
                self.click_sound.play() ;    
                if button.callback {
                    button.callback() ;
                } else {
                    self.handle_section_button_click(button.name) ;
                }
                disengage;
            }
        }
    }
    
    can handle_section_button_click(section_name: Any) {
        """Handles clicks on section buttons.""";
        section = next((s  for s in self.sections if s.name == section_name),None);    
        if not section {
            return ;
        }
        current_enabled = [btn.name for btn in self.buttons if btn.enabled
            and btn.name not in ['Stop', 'Back']];    
        self.history_manager.push(current_enabled) ;    
        self.current_photo = self.images.get(section.name.lower(),self.images['placeholder']);    
        self.photo_start_time = time.time();    
        self.photo_display = True;  

        for btn in self.buttons {
            if btn.name == section.name {
                btn.enabled = False;    
                disengage;
            }
        }

        for connected in section.connected_sections {
            for btn in self.buttons {
                if btn.name == connected.name {
                    btn.enabled = True;    
                    disengage;
                }
            }
        }
        self.back_button.enabled = True;
    }
    
    can stop_game() {
        """Stops the game.""" ;    
        pygame.quit() ;    
        sys.exit() ;
    }
    
    can go_back() {
        """Navigates back to the previous state.""" ;    
        previous_enabled = self.history_manager.pop();    
        if previous_enabled {
            for btn in self.buttons {
                if btn.name not in ['Stop', 'Back'] {
                    btn.enabled = False;
                }
            }
            for btn in self.buttons {
                if btn.name in previous_enabled {
                    btn.enabled = True;
                }
            }
            if not self.history_manager.has_history() {
                self.back_button.enabled = False;
            }
        }
    }
    
    can render_photo() {
        """Renders the photo and handles the 10-second display.""" ;    
        if self.photo_display and self.current_photo {
            overlay = pygame.Surface(self.screen.get_size(), pygame.SRCALPHA);    
            overlay.fill((0, 0, 0, 180)) ;    
            self.screen.blit(overlay, (0, 0)) ;    
            photo_rect = self.current_photo.get_rect(center=(400, 300));    
            self.screen.blit(self.current_photo, photo_rect.topleft) ;    
            if (time.time() - self.photo_start_time) > 4 {
                self.photo_display = False;    
                self.current_photo = None;
            }
        }
    }
    
    can render() {
        """Renders all GUI elements on the screen.""" ;    
        bg = pygame.image.load('assets\\images\\bg.png');    
        self.screen.fill((34, 139, 34)) ;    
        self.screen.blit(bg, (0, 0)) ;    
        self.draw_hierarchy() ;    
        self.draw_buttons() ;    
        self.stop_button.draw(self.screen, self.font) ;    
        self.back_button.draw(self.screen, self.font) ;    
        if self.photo_display {
            self.render_photo() ;
        }
        pygame.display.flip() ;
    }
}

