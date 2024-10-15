# src/users.py

from typing import List

class HistoryManager:
    def __init__(self):
        self.history: List[List[str]] = []  # Stack to keep track of enabled sections

    def push(self, current_enabled: List[str]):
        """Push the current state to history."""
        self.history.append(current_enabled.copy())

    def pop(self) -> List[str]:
        """Pop the last state from history."""
        if self.history:
            return self.history.pop()
        return []

    def has_history(self) -> bool:
        """Check if there is any history to go back to."""
        return len(self.history) > 0
