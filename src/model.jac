#import from zoo_1_gui, video_show;
node Section{
    has name:str,
    position:tuple,
    video_path:str = "",
    image_path:str ="",
    des:str ="";
    
    # can show with entry{
    #     Video_show();
    # }
}

edge Road{
    has distance:int =0;
}

obj Zoo{
    can create_zoo(Entry:Any){
        Entry = Section("Entry",(50,50));
        Animal = Section("Animal",(50,50));
        Bird = Section("Bird",(50,50));
        Lion = Section("Lion",(50,50));
        Elephant = Section("Elephant",(50,50));
        Parrot = Section("Parrot",(50,50));
        Humming = Section("Humming",(50,50));

        Road_0 = Road(5);
        Road_1 = Road(10);
        Road_2 = Road(10);
        Road_3 = Road(15);
        Road_4 = Road(10);
        Road_5 = Road(15);

        root ++> Entry;
        Entry +:Road_0:+> Animal;
        Entry +:Road_1:+> Bird;
        Animal +:Road_2:+> Lion;
        Animal +:Road_3:+> Elephant;
        Bird +:Road_4:+> Parrot;
        Bird +:Road_5:+> Humming;
    }
}

walker Visitor{
    has name:str;
    can Present with entry{
        self.current = here;
        print(self.current);
        # visit [-->];
        # Next = [-->];
        # print(Next);
    }

    can Visit(){
        #self.current = here;
        while [self.current -->]{
            for i in [self.current-->]{
                print(i.name);
                self.current = eval(i.name);
            }
            
        }
    }
}


with entry{
    
    zoo= Zoo().create_zoo(Entry);
    # zoo.create_zoo();
    Thami = Visitor("Thami");
    root spawn Thami;
    Thami.Visit();
    
}
