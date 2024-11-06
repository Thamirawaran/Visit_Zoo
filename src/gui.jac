import from model {Visitor}
import:py pygame,sys,time;
import:py from moviepy.editor {VideoFileClip}
import:py subprocess;
with entry{
    Starter = Visitor("Thami");
    root spawn Starter;
    Root = Starter.Here();

    can en_section(current:any){
        parent = Starter.get_parent(current);
        sibling = Starter.get_child(parent);
        for i in sibling{
            i.state = "REnter";
        }
        child = Starter.get_child(current);
        for i in child{
            i.state = "GEnter";
        }
        path= Starter.Visit(current.name,Root);
        for i in path[1:]{
            i.state = "Exit";
        }
    }

    can exit_section(current:any){
        parent = Starter.get_parent(current);
        sibling = Starter.get_child(parent);
        for i in sibling{
            i.state = "GEnter";
        }
        child = Starter.get_all_child(current);
        for i in child{
            i.state = "REnter";
        }
        current.state = "GEnter";
    }

    can draw_section(screen:any, current:any){
        (x,y)= current.loc;
        image = pygame.image.load(current.img_path);
        screen.blit(image, (x, y));
    }

    can draw_line(screen:any,current:any){
        child = Starter.get_child(current);
        for i in child{
            (x1, y1) = i.loc;
            (x2, y2) = current.loc;
            pygame.draw.line(screen, (0, 0, 0), (x1+80, y1+50), (x2+80, y2+100), 5);
            draw_line(screen,i);
        }
    }

    can draw_button(screen:any,current:any){
        (x,y)= current.loc;
        x = x+40;
        y = y+85;
        red_img = pygame.image.load('assets\\images\\red.png');
        green_img = pygame.image.load('assets\\images\\green.png');
        exit_img = pygame.image.load('assets\\images\\exit.png');
        if current.state == "GEnter"{
            screen.blit(green_img, (x, y));
        }
        elif current.state == "REnter"{
            screen.blit(red_img, (x, y));
        }
        elif current.state == "Exit"{
            screen.blit(exit_img, (x, y));
        }
        
    }

    can msg(text:any,screen:any){ #screen:any,
        font = pygame.font.SysFont(None, 50);
        text_surface = font.render(text, True, (0,0,255));
        screen.blit(text_surface, (300,250));
    }

    can button(current:any,screen:any){
        if not(Starter.get_child(current)){
            return draw_button(screen, current); 
        }
        draw_button(screen, current) if str(current)!= "Root()" else None;
        for i in Starter.get_child(current){
            button(i,screen);
        }   
    }

    can show(current:any){
        clip = VideoFileClip(current.vid_path).subclip(0, 3);
        clip.preview();
        en_section(current);
    }

    can clicked(current:any,screen:any,click_sound:any){
        click_sound.play();
        if current.state=="GEnter"{
            show(current);
        }
        elif current.state == "REnter"{
            msg("You cannot enter now",screen);
        }
        elif current.state =="Exit"{
            exit_section(current);
        }
    }

    can click(current:any,mouse_pos:tuple,screen:any,click_sound:any){
        (x,y)= current.loc if str(current)!='Root()' else (1000,1000);
        rect = pygame.Rect(x+20,y+80,80,80);
        if not(Starter.get_child(current)){
            return clicked(current,screen,click_sound) if rect.collidepoint(mouse_pos) else None;
        }
        clicked(current,screen,click_sound) if rect.collidepoint(mouse_pos) else None;
        for i in Starter.get_child(current){
            click(i,mouse_pos,screen,click_sound);
        }
    }

    can add_section(current:any,screen:any){
        if not(Starter.get_child(current)){
            draw_section(screen, current);
            draw_line(screen,current);
            return None;
        }
        draw_line(screen, current) if str(current)!= "Root()" else None;
        draw_section(screen, current) if str(current)!= "Root()" else None;
        for i in Starter.get_child(current){
            add_section(i,screen);
        }
    }
}
