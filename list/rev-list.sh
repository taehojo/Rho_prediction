#! /bin/bash


filename="./neg-plus-25-10"
while read -r a b 
do
        d=$(expr 4639675 - $a + 1)      
        echo -e $d'\t'-      
done < "$filename" 
