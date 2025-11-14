#!/bin/bash

set -e  # Exit on error

echo "=== Установка окружения для VS Code Remote ==="
echo ""

# Цвета для вывода
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_step() {
    echo -e "${BLUE}>>> $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# 1. Обновление системы
print_step "1. Обновление системы"
sudo apt update && sudo apt upgrade -y
print_success "Система обновлена"

# 2. Установка базовых инструментов
print_step "2. Установка базовых инструментов разработки"
sudo apt install -y \
    build-essential curl wget git \
    python3-pip python3-venv \
    nodejs npm \
    docker.io docker-compose \
    htop tmux neovim ripgrep fd-find bat zip unzip \
    jq
print_success "Базовые инструменты установлены"

# 3. Настройка Docker
print_step "3. Настройка Docker"
sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker
print_success "Docker настроен"

# 4. Установка Python библиотек
print_step "4. Установка Python библиотек"
pip3 install --user --upgrade pip --break-system-packages
pip3 install --user -r requirements.txt --break-system-packages
print_success "Python библиотеки установлены"

# 5. Установка системных пакетов для документов
print_step "5. Установка пакетов для обработки документов"
sudo apt install -y \
    tesseract-ocr tesseract-ocr-rus tesseract-ocr-eng \
    poppler-utils imagemagick libreoffice \
    chromium-browser chromium-driver \
    jpegoptim optipng pngquant webp
print_success "Пакеты для документов установлены"

# 6. Установка Playwright браузеров
print_step "6. Установка Playwright браузеров"
export PATH="$HOME/.local/bin:$PATH"
playwright install chromium firefox
playwright install-deps
print_success "Playwright браузеры установлены"

# 7. Установка Node.js инструментов
print_step "7. Установка глобальных npm пакетов"
sudo npm install -g \
    tldr prettier eslint typescript \
    nodemon pm2 live-server browser-sync
print_success "npm пакеты установлены"

# 8. Установка Tokei
print_step "8. Установка Tokei"
cd /tmp
wget https://github.com/XAMPPRocky/tokei/releases/download/v12.1.2/tokei-x86_64-unknown-linux-musl.tar.gz
tar -xzf tokei-x86_64-unknown-linux-musl.tar.gz
sudo mv tokei /usr/local/bin/
rm tokei-x86_64-unknown-linux-musl.tar.gz
cd ~
print_success "Tokei установлен"

# 9. Создание структуры директорий
print_step "9. Создание структуры проектов"
mkdir -p ~/projects/{tendercraft,crypto,ai-tools,scripts}
mkdir -p ~/projects/frontend-resources/{css,templates,components}
mkdir -p ~/documents/{generated,templates,exports}
mkdir -p ~/.config
print_success "Структура директорий создана"

# 10. Добавление PATH в .bashrc
print_step "10. Настройка PATH"
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    print_success "PATH обновлен в .bashrc"
else
    print_success "PATH уже настроен"
fi

echo ""
echo "=== Установка завершена! ==="
echo ""
echo "Запустите проверку: python3 check.py"
echo ""
echo "Для применения изменений Docker перелогинься или выполни:"
echo "  newgrp docker"
