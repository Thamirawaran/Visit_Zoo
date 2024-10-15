import:py pygame ;
import:py os ;
import:py from typing, Optional ;

can load_image(name: str, colorkey: Optional[<>tuple]=None) -> pygame.Surface {

    """Load an image from the assets/images directory.""" ;    
    fullname = os.path.join('assets', 'images', name);    
    try  {

        image = pygame.image.load(fullname);
    } except pygame.error as e {

        print(f"{'Cannot load image: '}{name}") ;    
        raise SystemExit(e) ;
    }
    

    image = image.convert_alpha();    
    if colorkey is not None {

        image.set_colorkey(colorkey) ;
    }
    

    return image ;
}

can load_sound(name: str) -> pygame.mixer.Sound {

    """Load a sound from the assets/sounds directory.""" ;    
    fullname = os.path.join('assets', 'sounds', name);    
    try  {

        sound = pygame.mixer.Sound(fullname);
    } except pygame.error as e {

        print(f"{'Cannot load sound: '}{name}") ;    
        raise SystemExit(e) ;
    }
    

    return sound ;
}

can load_font(name: str, size: int) -> pygame.font.Font {

    """Load a font from the assets/fonts directory.""" ;    
    fullname = os.path.join('assets', 'fonts', name);    
    try  {

        font = pygame.font.Font(fullname, size);
    } except pygame.error as e {

        print(f"{'Cannot load font: '}{name}") ;    
        raise SystemExit(e) ;
    }
    

    return font ;
}

