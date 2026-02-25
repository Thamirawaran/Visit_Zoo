# 🦁 Visit Zoo Game

[![Jaclang](https://img.shields.io/badge/Jaclang-0.7.24-blue.svg)](https://github.com/Jaseci-Labs/jaclang)
[![Pygame](https://img.shields.io/badge/Pygame-2.1.0-green.svg)](https://www.pygame.org/)
[![MoviePy](https://img.shields.io/badge/MoviePy-1.0.3-orange.svg)](https://zulko.github.io/moviepy/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> 🎮 An immersive interactive zoo exploration game built with Jaclang, featuring dynamic state management and multimedia experiences.

## ✨ Features

### 🗺️ **Interactive Zoo Exploration**
- Navigate through beautifully designed zoo sections
- Each area features unique animals: 🦁 Lions, 🐘 Elephants, 🦜 Parrots, and 🐦 Hummingbirds
- Dynamic pathfinding and state-based navigation system

### 🎬 **Rich Multimedia Experience**
- **HD Images**: High-quality visuals for each zoo section
- **Video Content**: Immersive 3-second video clips for every animal encounter
- **Audio**: Background music and interactive sound effects

### 🎯 **Smart State Management**
- 🟢 **Accessible** - Ready to explore
- 🔴 **Restricted** - Prerequisites required
- 🚪 **Exit** - Previously visited areas

### 🏗️ **Modern Architecture**
- Object-oriented design with Jaclang
- Modular code structure for easy maintenance
- Real-time event handling and smooth gameplay

## 🎮 How to Play

### 🚀 Getting Started
1. **Start** at the zoo entrance
2. **Click** on green sections to explore new areas
3. **Watch** videos and enjoy the animal experiences
4. **Navigate** strategically between different zoo sections

### 🕹️ Controls
| Control | Action |
|---------|--------|
| 🖱️ **Mouse Click** | Interact with zoo sections |
| 🟢 **Green Button** | Enter available section |
| 🔴 **Red Button** | Section currently restricted |
| 🚪 **Exit Button** | Return to previous area |

### 📍 Zoo Map
```
🏛️ Zoo Entry
├── 🐾 Animals Section
│   ├── 🦁 Lion Exhibit
│   └── 🐘 Elephant Habitat
└── 🐦 Birds Section
    ├── 🦜 Parrot Aviary
    └── 🐦 Hummingbird Garden
```

## 🛠️ Setup & Installation

### 📋 Prerequisites
- 🐍 **Python 3.8+**
- 🎯 **Jaclang** - Advanced programming language for AI and graph computing
- 🎮 **Pygame** - Cross-platform gaming library
- 🎬 **MoviePy** - Video processing toolkit

### ⚡ Quick Install

```bash
# Clone the repository
git clone https://github.com/Thamirawaran/Visit_Zoo.git
cd Visit_Zoo

# Install dependencies
pip install -r requirements.txt

# Launch the game
cd src
jac run main.jac
```

### 🐳 Docker Setup (Optional)
```bash
docker build -t visit-zoo .
docker run -it --rm visit-zoo
```

## 🏗️ Project Structure

```
Visit_Zoo/
├── 📁 src/
│   ├── 🎯 main.jac          # Core game engine & event loop
│   ├── 🎨 gui.jac           # UI components & rendering
│   └── 🗺️ model.jac        # Zoo structure & navigation logic
├── 📁 assets/
│   ├── 🖼️ images/          # Section visuals & UI elements
│   ├── 🎬 videos/          # Animal encounter clips
│   └── 🎵 music/           # Background audio & sound effects
├── 📋 requirements.txt      # Python dependencies
├── 📄 LICENSE              # MIT License
└── 📖 README.md            # This file
```

## 🔧 Technical Details

### 🎯 Built With Jaclang
- **Graph-based Architecture**: Leverages Jaclang's native graph processing
- **Walker Pattern**: Efficient navigation through zoo sections
- **Type Safety**: Strong typing for better code reliability

### 🎮 Game Engine Features
- **60 FPS** smooth gameplay
- **Responsive UI** with dynamic resizing
- **Memory-efficient** media loading
- **Cross-platform** compatibility

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. 🍴 **Fork** the repository
2. 🌟 **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. 💾 **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. 📤 **Push** to the branch (`git push origin feature/amazing-feature`)
5. 🔄 **Open** a Pull Request

### 🐛 Bug Reports
Found a bug? Please open an issue with:
- Detailed description
- Steps to reproduce
- Expected vs actual behavior
- System information

## 📝 Changelog

### v1.0.0 (Latest)
- ✨ Initial release
- 🎮 Full zoo exploration gameplay
- 🎬 Multimedia integration
- 🎯 Jaclang-powered architecture

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- 🎯 **Jaclang Team** - For the amazing programming language
- 🎮 **Pygame Community** - For the robust gaming framework
- 🎬 **MoviePy Contributors** - For video processing capabilities
- 🦁 **Zoo Communities** - For inspiration and educational content

---

<div align="center">

**⭐ If you enjoyed this project, Please give it a star! ⭐**

Made with ❤️ by [Thamirawaran Sathiyalogeswaran](https://github.com/Thamirawaran)

[🐛 Report Bug](https://github.com/Thamirawaran/Visit_Zoo/issues) • [✨ Request Feature](https://github.com/Thamirawaran/Visit_Zoo/issues) • [💬 Ask Question](https://github.com/Thamirawaran/Visit_Zoo/discussions)

</div>
