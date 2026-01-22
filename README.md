# dotfiles

## Предварительные требования

Перед использованием этих dotfiles убедитесь, что у вас установлены:

- [GNU Stow](https://www.gnu.org/software/stow/)
- Git для клонирования репозитория
- Mise
- dotnet
- hadolint

## Установка

1. Клонируйте этот репозиторий в вашу домашнюю директорию:

```bash
cd ~
git clone https://github.com/prbrq/dotfiles.git
```

1. Перейдите в директорию dotfiles:

```bash
cd ~/dotfiles
```

1. Используйте Stow для создания симлинков нужных вам конфигураций:

```bash
stow .
```

Stow создаст символические ссылки из файлов в этом репозитории в вашу домашнюю директорию.

## VS Code Extensions

В репозитории есть два скрипта для управления расширениями VS Code:

- `install_vscode_extensions.sh` - устанавливает все расширения из файла `code-extensions.txt`
- `export_vscode_extensions.sh` - экспортирует список установленных расширений в файл `code-extensions.txt`
