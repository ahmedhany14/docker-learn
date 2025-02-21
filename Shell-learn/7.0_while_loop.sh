
i=10

while [ $i -ge 0 ]
do 
    echo "$i seconds left"
    i=$(($i-1))
#    sleep 1
done



while [ -f test.txt ]
do
    echo "at $(date) the file test.txt exists"
    sleep 1
done

echo "file test.txt does not exist anymore at $(date)"
# Note: the above script will keep checking if the file test.txt exists every second and will print the message if it exists.