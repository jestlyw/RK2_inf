#!/bin/bash

echo "Введите путь к директории:"
read DIRECTORY

echo "Введите расширение файлов:"
read EXTENSION

if [ -z "$DIRECTORY" ] || [ -z "$EXTENSION" ]; then
    echo "Пожалуйста, укажите и директорию, и расширение файлов."
    return
fi

if [ ! -d "$DIRECTORY" ]; then
    echo "Директория не найдена."
    return
fi

FILES=$(find "$DIRECTORY" -type f -name "*.$EXTENSION")

if [ -z "$FILES" ]; then
    echo "Файлы с расширением $EXTENSION не найдены."
else
    echo "Найденные файлы:"
    echo "$FILES"
fi
