#!/bin/bash

# Скрипт для экспорта установленных расширений VS Code в файл code-extensions.txt

EXTENSIONS_FILE="code-extensions.txt"

# Проверяем, установлен ли VS Code
if ! command -v code &> /dev/null; then
    echo "VS Code не установлен или не найден в PATH"
    exit 1
fi

echo "Экспорт установленных расширений VS Code..."

# Получаем список установленных расширений и сохраняем в файл
code --list-extensions > "$EXTENSIONS_FILE"

# Проверяем, успешен ли экспорт
if [ $? -eq 0 ]; then
    echo "✓ Успешно экспортировано расширений в $EXTENSIONS_FILE"
    echo "Найдено $(wc -l < "$EXTENSIONS_FILE") расширений"
else
    echo "✗ Ошибка при экспорте расширений"
    exit 1
fi

echo "Экспорт расширений завершен!"