#!/bin/bash

# Скрипт для установки расширений VS Code из файла code-extensions.txt

EXTENSIONS_FILE="code-extensions.txt"

# Проверяем, установлен ли VS Code
if ! command -v code &> /dev/null; then
    echo "VS Code не установлен или не найден в PATH"
    exit 1
fi

# Проверяем, существует ли файл с расширениями
if [ ! -f "$EXTENSIONS_FILE" ]; then
    echo "Файл с расширениями $EXTENSIONS_FILE не найден"
    exit 1
fi

echo "Установка расширений VS Code..."

# Читаем файл построчно и устанавливаем каждое расширение
while IFS= read -r extension || [ -n "$extension" ]; do
    # Пропускаем пустые строки и комментарии
    if [[ -n "$extension" && ! "$extension" =~ ^[[:space:]]*# ]]; then
        echo "Установка $extension..."
        code --install-extension "$extension" >/dev/null 2>&1

        # Проверяем, успешна ли установка
        if [ $? -eq 0 ]; then
            echo "✓ Успешно установлено $extension"
        else
            echo "✗ Ошибка при установке $extension"
        fi
    fi
done < "$EXTENSIONS_FILE"

echo "Установка расширений завершена!"
