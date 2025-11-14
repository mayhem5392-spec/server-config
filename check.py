#!/usr/bin/env python3
import sys
print("=== Проверка установленных компонентов ===\n")

# Python библиотеки
libs = ['pandas', 'numpy', 'matplotlib', 'pillow', 'cv2', 'selenium', 'playwright', 'PyPDF2', 'docx', 'openpyxl']
print("Python библиотеки:")
for lib in libs:
    try:
        if lib == 'cv2':
            import cv2
        elif lib == 'docx':
            import docx
        elif lib == 'pillow':
            from PIL import Image
        else:
            __import__(lib)
        print(f"  ✅ {lib}")
    except ImportError:
        print(f"  ❌ {lib}")

# Системные утилиты
import subprocess
tools = ['docker', 'git', 'node', 'npm', 'tokei', 'tesseract', 'pdftotext', 'chromium-browser']
print("\nСистемные утилиты:")
for tool in tools:
    result = subprocess.run(['which', tool], capture_output=True, text=True)
    if result.returncode == 0:
        print(f"  ✅ {tool}")
    else:
        print(f"  ❌ {tool}")

print("\n✨ Установка завершена! Перелогинься для применения Docker прав.")
