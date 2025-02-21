#!/bin/bash

echo '1 for print 100'
echo '2 for print 200'
echo '3 for print 300'
echo '4 for print 400'

read -p 'Enter your choice: ' choice

case $choice in
    1)
        echo '100'
        ;;
    2)
        echo '200'
        ;;
    3)
        echo '300'
        ;;
    4)
        echo '400'
        ;;
    *)
        echo 'Invalid choice'
        ;;
esac
