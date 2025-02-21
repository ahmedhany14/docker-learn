
# exit code idea is to know the status of the last command executed
# and if not successful, then take some action, like install a package or print an error message etc.

package="htop"

sudo apt update && sudo apt install $package

# Note: $? is a special variable that holds the exit code of the last command executed
# 0 means success, any other number means failure

if [ $? -eq 0 ]
then
    echo "The installation of $package was successful"
    echo "The new command is available now in: $(which $package)"   
else
    echo "$package is not installed"
fi


package2=any_package

sudo apt update && sudo apt install $package2

if [ $? -eq 0 ]
then
    echo "The installation of $package2 was successful"
    echo "The new command is available now in: $(which $package2)"   
else
    echo "$package2 is not installed"
fi