#!/bin/bash

# memory
IFS='|'  
while read -r lines # reading free to get memory stats line by line
do
	if [[ "$count" == 1 ]] # checking if the line is the line thats has memory stats
then

IFS='  '
read -a vars <<< $lines # sliceing the the memory stats line based on spaces between each reading
freed=${vars[3]}
used=${vars[2]}
name=`date "+%F-%T"` # getting the time stamp and storing it in name variable

touch /var/www/html/data/memory/$name #making the file that will store the memory stats
echo "$freed   $used" >> /var/www/html/data/memory/$name #store the memory stats in the file

fi
count=$((count + 1)) 
done < <(free)
# cpu
cpu=`awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) ; }' <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat)` #getting the cpu utilization reading
touch /var/www/html/data/cpu/$name #storing reading
echo "$cpu" >> /var/www/html/data/cpu/$name



#disk
usum=0
fsum=0
count=0
IFS='|'
while read -r lines #reading df to get all partiton stats then callculate sum of their stats
do
	if [[ "$count" > 0 ]]
then


IFS=' '
read -a vars <<< $lines


a=${vars[2]}

b=${vars[3]}
usum=$((usum + a))
fsum=$((fsum + b))


fi
count=$((count + 1))
done < <(df)
touch /var/www/html/data/disk/$name
echo "$fsum   $usum" >> /var/www/html/data/disk/$name