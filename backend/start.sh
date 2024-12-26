#!/bin/bash

GREEN="\033[32m"
RESET="\033[0m"

# Определяем директорию текущего скрипта
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Проверяем наличие папки vcpkg
if [ ! -d "$SCRIPT_DIR/vcpkg" ]; then
  echo -e "${GREEN}Installing vcpkg...${RESET}"
  git clone https://github.com/microsoft/vcpkg.git --depth=1 "$SCRIPT_DIR/vcpkg" || { echo "Failed to clone vcpkg."; exit 1; }
  cd "$SCRIPT_DIR/vcpkg" && ./bootstrap-vcpkg.sh || { echo "Failed to bootstrap vcpkg."; exit 1; }
fi

# Устанавливаем пакеты через vcpkg
echo -e "${GREEN}Installing packages...${RESET}"
"$SCRIPT_DIR/vcpkg/vcpkg" install || { echo "Failed to install packages."; exit 1; }
echo -e "${GREEN}Packages installed successfully.${RESET}"

# Компиляция проекта
echo -e "${GREEN}Building project...${RESET}"
cd "$SCRIPT_DIR"
cmake -S . -B build || { echo "CMake configuration failed."; exit 1; }
cd build && cmake --build . || { echo "Build failed."; exit 1; }
echo -e "${GREEN}Build completed successfully.${RESET}"

# Запуск приложения
 echo -e "${GREEN}Running app...${RESET}"
"$SCRIPT_DIR/build/orlando" || { echo "Failed to run app."; exit 1; }