
num=200


if [ $num -eq 100 ]
then
    echo "num is 100"
elif [ $num -eq 200 ]
then
    echo "num is 200"
else
    echo "num is not 100 or 200"
fi

echo "---------------------------------------------"

file='test.txt'

if [ -f test.txt ]
then
    echo "file exists"
else
    echo "file does not exist"
fi