#!/bin/bash
set -e

echo "🧠 Setting up SinerGia Development Environment..."

# Update system
echo "📦 Updating system packages..."
sudo apt-get update -qq

# Install required packages for PyGame and OpenCV
echo "🎮 Installing PyGame dependencies..."
sudo apt-get install -y -qq \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsdl2-ttf-dev \
    libfreetype6-dev \
    libportmidi-dev \
    libjpeg-dev \
    python3-dev \
    xvfb

# Install Python dependencies
echo "🐍 Installing Python packages..."
pip install --upgrade pip setuptools wheel
pip install -r requirements.txt

# Install development dependencies
echo "🔧 Installing development tools..."
pip install \
    black \
    flake8 \
    isort \
    pytest \
    pytest-cov \
    mypy \
    ruff

# Setup git hooks
echo "🎣 Setting up git hooks..."
if [ -d .git ]; then
    cat > .git/hooks/pre-commit << 'HOOK'
#!/bin/bash
# Run linting before commit
echo "🔍 Running linters..."
black --check .
flake8 .
echo "✅ Linting passed!"
HOOK
    chmod +x .git/hooks/pre-commit
fi

# Create necessary directories
echo "📁 Creating project directories..."
mkdir -p logs
mkdir -p data
mkdir -p models
mkdir -p assets/screenshots

# Setup virtual display for PyGame in headless mode
echo "🖥️ Setting up virtual display..."
export DISPLAY=:99
Xvfb :99 -screen 0 1024x768x24 > /dev/null 2>&1 &

# Welcome message
cat << "WELCOME"

╔══════════════════════════════════════════════════════════╗
║                                                          ║
║      🧠 SinerGia Development Environment Ready! 🚀       ║
║                                                          ║
║  Quick Start:                                            ║
║  • python hardware_simulator/main.py  - Run simulator   ║
║  • pytest                             - Run tests        ║
║  • black .                            - Format code      ║
║                                                          ║
║  Documentation: docs/                                    ║
║  Issues: github.com/Artkill24/sinergia/issues           ║
║                                                          ║
╚══════════════════════════════════════════════════════════╝

WELCOME

echo "✨ Setup complete! Happy coding!"
