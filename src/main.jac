import:jac from model {Visitor}
import:py pygame,sys,time;
import:py from moviepy.editor {VideoFileClip}
import:jac from gui {button, add_section, click}

with entry{
    Starter = Visitor("Thami");
    root spawn Starter;
    Root = Starter.Here();

    bg = pygame.image.load('assets\\images\\bg.png');
    pygame.<>init();
    screen = pygame.display.set_mode((800, 600),pygame.RESIZABLE);
    pygame.display.set_caption("Visit Zoo");
    clock = pygame.time.Clock();
    FPS = 60;
    pygame.mixer.music.load('assets\\music\\background.mp3');
    pygame.mixer.music.play(-1);
    click_sound = pygame.mixer.Sound('assets\\music\\click.wav');
    while True{
        screen.blit(bg, (0, 0));
        for event in pygame.event.get(){
            if event.type == pygame.QUIT{
                pygame.quit();
                sys.exit();
            }
            button(Root,screen);
            if event.type == pygame.MOUSEBUTTONDOWN{
                mouse_pos = pygame.mouse.get_pos();
                click(Root,mouse_pos,screen,click_sound);
            }
        }
        add_section(Root,screen);
        button(Root,screen);
        pygame.display.update();
        clock.tick(FPS);
    }
}