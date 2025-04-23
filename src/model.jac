node Section{
    has name:str;
    has loc:tuple;
    has img_path:str;
    has vid_path:str;
    has state:str = "REnter";
}

edge Road{
    has dis:int;
}

with entry{
    Entry = Section("Zoo Entry",(320,70),'assets\\images\\entry.png','assets\\videos\\entry.mp4',"GEnter");
    Animal = Section("Animals",(150,200),'assets\\images\\animals.png','assets\\videos\\animals.mp4');
    Bird = Section("Birds",(500,200),'assets\\images\\birds.png','assets\\videos\\birds.mp4');
    Lion = Section("Lion",(50,400),'assets\\images\\lion.png','assets\\videos\\lion.mp4');
    Elephant = Section("Elephant",(250,400),'assets\\images\\elephant.png','assets\\videos\\elephant.mp4');
    Parrot = Section("Parrot",(400,400),'assets\\images\\parrot.png','assets\\videos\\parrot.mp4');
    Humming = Section("Humming Bird",(600,400),'assets\\images\\humming.png','assets\\videos\\humming.mp4');

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

walker Visitor{
    has name:str;
    has path:list = [];
    has all_child:list=[];

    can Start with entry{
        self.current = here;
    }

    can Here()->Any{
        return self.current;
    }

    can Visit(name:str,current:Any)->list{
        #Base case
        if (str(current) != "Root()") and (str(current.name) == name){
            return [current];
        }

        #Recursive case
        for i in [current-->]{
            path = self.Visit(name,i);
            if path{
                return [current] + path;
            }
        }
        return None;
    }

    can get_child(current:Any)->list{
        return [current-->];
    }

    can get_parent(current:Any)->list{
        return [current<--];
    }

    can get_all_child(current:any)->list{
        self.all_child = [current];  # Start with the current node
        if [current-->]{
            for child in [current-->]{
                self.all_child += self.get_all_child(child);  # Recursively collect all children and flatten the list
            }
        }
        return self.all_child;
    }
}

    # can get_all_child(current:any)->list{
    #     #self.all_child = [];
    #     if [current-->]{
    #         for i in [current-->]{
    #             self.all_child.append(self.get_all_child(i));
    #         }
    #         # self.all_child = [self.get_all_child(i) for i in [current-->]];
    #         # print(self.all_child);
    #         # return [current] + self.all_child;
    #     }
    #     else{
    #         self.all_child.append(current);
    #         # return [current];
    #     }
    #     return self.all_child;
    # }
