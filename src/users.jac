import:py from typing, List ;

class HistoryManager {
    has history:: List[List[str]];
    can init() {
        self.history = [];
    }

    
    can push(current_enabled: List[str]) {
        """Push the current state to history.""" ;    
        self.history.append(current_enabled.copy()) ;
    }
    
    can pop() -> List[str] {

        """Pop the last state from history.""" ;    
        if self.history {

            return self.history.pop() ;
        }
        
        return [] ;
    }
    
    can has_history() -> bool {

        """Check if there is any history to go back to.""" ;    
        return len(self.history) > 0 ;
    }
}

