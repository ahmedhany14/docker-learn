#!/bin/bash

command="htop"

if [ command -v $command &> /dev/null ]
then
    echo "htop is installed"
else
    echo "htop is not installed"
    sudo apt update && sudo apt install htop
fi

htop


# check man test for more options in if condition