node section{
    has name:str;
}

edge road{
    has distance:int;
}

walker VIP{
    has name:str;
    has count: int=1;

    can take_photo with entry{
        print(f"You took {self.count} photos");
        print("Photo",here);
    }

    can Visit with entry{
        print("Visit",here);
    }

        # while destination not in current{
        #     current = [here-->];
        #     print(here);        
        #     }
    }


walker Normal{
    has name:str;
    has count: int=1;
}

with entry{
    # VIP = section(name="VIP Entry");
    # Normal = section(name="Normal Entry");
    Common = section(name="Common");
    Museum = section(name="Museum");

    A_canteen = section(name="Canteen");
    B_canteen = section(name="Canteen");
    C_canteen = section(name="Canteen");
    S_canteen = section(name="Canteen");

    Animals = section(name="Animals");
    Lion = section(name="Lion");
    Elephant = section(name="Elephant");
    Cheetah = section(name="Cheetah");
    Buffalo = section(name="Buffalo");

    Birds = section(name="Birds");
    Parrot = section(name="Parrot");
    Hummingbirds = section(name="Hummingbirds");

    Snake = section(name="Snake");

    # root +:road(distance=0):+> VIP;
    # root +:road(distance=0):+> Normal;
    root +:road(distance=0):+> Common;
    # VIP +:road(distance=0):+> Common;
    # Normal +:road(distance=0):+> Common;

    Common +:road(distance=10):+> Animals;
    Common +:road(distance=20):+> Birds;
    Common +:road(distance=30):+> Snake;
    Common +:road(distance=30):+> Museum;

    Common +:road(distance=10):+> C_canteen;
    Animals +:road(distance=10):+> A_canteen;
    Birds +:road(distance=10):+> B_canteen;
    Snake +:road(distance=10):+> S_canteen;

    Animals +:road(distance=10):+> Lion;
    Animals +:road(distance=10):+> Elephant;
    Animals +:road(distance=10):+> Cheetah;
    Animals +:road(distance=10):+> Buffalo;

    Birds +:road(distance=10):+> Parrot;
    Birds +:road(distance=10):+> Hummingbirds;

    User1 = VIP("User1");
    User2= Normal("Sipho");
    root spawn User1;
    root spawn User2;
    print(User1);
    print(User2);
}

# can photo(name:str,count:int)->int{

# }

