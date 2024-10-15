# src/model.py

from dataclasses import dataclass, field
from typing import List, Optional

@dataclass
class Section:
    name: str
    position: tuple  # (x, y) coordinates on the screen
    image_path: str  # Path to the section image
    enabled: bool = False  # Indicates if the section is clickable
    connected_sections: List['Section'] = field(default_factory=list)  # Sections connected to this one
