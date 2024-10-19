# Zoo Management Game
Welcome to the Zoo Management Game, an interactive zoo exploration and management game built using Pygame and MoviePy. In this game, players can explore various sections of a zoo, each featuring animals, birds, and different attractions. The game includes image displays, video playback, and interactive buttons that guide the player through different areas of the zoo.

## Features
- **Interactive Zoo Sections:** Explore sections like Animals, Birds, Lion, Parrot, and more. Each section comes with its own unique content, including images and short video clips.
- **State-Based Interaction:** Navigate through the zoo based on the current availability of sections. Sections can be either accessible, restricted, or marked for exit, providing a dynamic experience.
- **Media Integration:** Enjoy media-rich content as each section of the zoo plays a short video.
- **Object-Oriented Design:** The game uses a modular structure with clear separation of logic, including classes for buttons, sections, and navigation.
- **Real-Time Exploration:** The player uses mouse clicks to interact with the zoo, making decisions based on the accessibility of sections. Explore in real time and enjoy seamless transitions between sections.

## How to Play
Start at the entry point of the zoo.
Click on available sections (marked in green) to explore new areas.
Watch videos or view images as you enter each section.
Navigate between sections by exiting previously visited areas and opening new ones.
If a section is restricted (marked in red), you won’t be able to enter until certain conditions are met.

## Controls
- **Mouse:** Use your mouse to click on sections of the zoo and interact with buttons.
- **Exit:** After visiting a section, click the exit button to return to the previous area.
- **Navigation:** Follow the state indicators (green, red, or exit) to guide your exploration.

## Setup
### Prerequisites
- Python 3.x
- Pygame
- MoviePy

## Installation
Clone the repository:
```
git clone https://github.com/Thamirawaran/Visit_zoo.git
cd Visit_zoo
```

## Install the required dependencies:
```
pip install -r requirements.txt
```

## Run the game:
```
jac run main.jac
```

## Game Structure
The project follows a modular approach:
- **main.jac:** Core game logic including Pygame event loop and display management.
- **gui.jac:** Handles the GUI-related functionalities such as button rendering and screen updates.
- **model.jac:** Defines the zoo structure, including sections, paths, and the visitor’s behavior.
<!-- user.py: Manages player interactions and navigation between sections. -->
<!-- utils.py: Includes utility functions for loading media, managing events, etc. -->

## Media
- Images: Displayed when entering certain sections.
- Videos: Short clips play when a player explores a new area (e.g., viewing Lions or Elephants).

## License
This project is licensed under the MIT License. See the LICENSE file for more details.
