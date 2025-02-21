#!/bin/bash


# Variables are used to store data that can be used later in the script.
# Variables are defined by assigning a value to a name.

myname="ahmed hany"
myage=25

echo "My name is $myname and I am $myage years old."

file_dir=$(pwd)

echo "The current working directory is: $file_dir"

files_in_dir=$(ls)

echo "The files in the current directory are: "
echo $files_in_dir

date_now=$(date)
echo "The current date and time is: $date_now"