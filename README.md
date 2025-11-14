# Server Development Environment

Полная конфигурация сервера для разработки с VS Code Remote SSH.

## Что установлено

### Системные инструменты
- **Docker** 28.2.2 + docker-compose
- **Git** 2.43.0
- **Node.js** 20.19.5 + npm 10.8.2
- **Python** 3.12.3
- **Tokei** 12.1.2 (подсчет строк кода)
- Базовые утилиты: htop, tmux, neovim, ripgrep, fd-find, bat

### Python библиотеки
- **Data Science**: pandas, numpy, matplotlib, seaborn, plotly, scipy, scikit-image
- **Изображения**: pillow, opencv-python
- **Jupyter**: jupyterlab, ipython
- **Web**: httpx, beautifulsoup4, selenium, playwright
- **Документы**: PyPDF2, python-docx, openpyxl, xlsxwriter, markdown, python-pptx
- **Утилиты**: pytesseract, pdf2image, colorthief, colorama, rich

### Обработка документов
- Tesseract OCR (русский + английский)
- Poppler (pdftotext)
- ImageMagick
- LibreOffice
- Chromium Browser
- Оптимизация изображений: jpegoptim, optipng, pngquant, webp

### Playwright
- Браузеры: Chromium 141, Firefox 142
- Системные зависимости настроены

### Node.js глобальные пакеты
- tldr, prettier, eslint, typescript
- nodemon, pm2
- live-server, browser-sync

### Структура проектов
```
~/projects/
  ├── tendercraft/
  ├── crypto/
  ├── ai-tools/
  ├── scripts/
  └── frontend-resources/
      ├── css/
      ├── templates/
      └── components/

~/documents/
  ├── generated/
  ├── templates/
  └── exports/
```

## Быстрая установка

```bash
# Клонировать репозиторий
git clone <repo-url> ~/server-config
cd ~/server-config

# Запустить установку
chmod +x install.sh
./install.sh

# Проверить установку
python3 check.py
```

## Установка по шагам

### 1. Обновление системы
```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Базовые инструменты
```bash
sudo apt install -y build-essential curl wget git \
    python3-pip python3-venv nodejs npm \
    docker.io docker-compose htop tmux neovim \
    ripgrep fd-find bat zip unzip jq
```

### 3. Docker
```bash
sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker
```

### 4. Python библиотеки
```bash
pip3 install --user --upgrade pip --break-system-packages
pip3 install --user -r requirements.txt --break-system-packages
```

### 5. Системные пакеты для документов
```bash
sudo apt install -y \
    tesseract-ocr tesseract-ocr-rus tesseract-ocr-eng \
    poppler-utils imagemagick libreoffice \
    chromium-browser chromium-driver \
    jpegoptim optipng pngquant webp
```

### 6. Playwright браузеры
```bash
export PATH="$HOME/.local/bin:$PATH"
playwright install chromium firefox
playwright install-deps
```

### 7. Node.js инструменты
```bash
sudo npm install -g tldr prettier eslint typescript \
    nodemon pm2 live-server browser-sync
```

### 8. Tokei
```bash
cd /tmp
wget https://github.com/XAMPPRocky/tokei/releases/download/v12.1.2/tokei-x86_64-unknown-linux-musl.tar.gz
tar -xzf tokei-x86_64-unknown-linux-musl.tar.gz
sudo mv tokei /usr/local/bin/
rm tokei-x86_64-unknown-linux-musl.tar.gz
cd ~
```

### 9. Структура директорий
```bash
mkdir -p ~/projects/{tendercraft,crypto,ai-tools,scripts}
mkdir -p ~/projects/frontend-resources/{css,templates,components}
mkdir -p ~/documents/{generated,templates,exports}
mkdir -p ~/.config
```

### 10. PATH
```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## Подключение VS Code Remote SSH

### На локальной машине:

1. Установить VS Code
2. Установить расширение **Remote - SSH** от Microsoft
3. Нажать `Ctrl+Shift+P` → "Remote-SSH: Add New SSH Host"
4. Ввести: `ssh user@server-ip`

### Настройка SSH ключей (опционально):
```bash
# На локальной машине
ssh-keygen -t ed25519 -C "your-email@example.com"
ssh-copy-id user@server-ip
```

## Проверка установки

```bash
python3 check.py
```

Скрипт проверит:
- Все Python библиотеки
- Системные утилиты
- Docker, Git, Node.js, npm, Tokei
- Tesseract, pdftotext, chromium-browser

## Структура репозитория

```
server-config/
  ├── README.md           # Эта инструкция
  ├── install.sh          # Скрипт автоустановки
  ├── requirements.txt    # Python зависимости
  ├── package.json        # Node.js зависимости
  └── check.py           # Скрипт проверки
```

## Важные замечания

1. **Docker**: После установки нужно перелогиниться или выполнить `newgrp docker`
2. **PATH**: ~/.local/bin автоматически добавляется в PATH
3. **Python**: Используется флаг `--break-system-packages` для установки в user space
4. **Node.js**: Установлен из репозитория nodesource (версия 20.x)

## Дополнительные команды

### Проверка версий
```bash
docker --version
git --version
node --version
npm --version
python3 --version
tokei --version
```

### Проверка Docker
```bash
docker ps
docker run hello-world
```

### Подсчет строк кода
```bash
tokei ~/projects
```

### Запуск JupyterLab
```bash
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser
```

## Лицензия

MIT

## Автор

Сгенерировано с помощью Claude Code
