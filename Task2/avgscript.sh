#memory start
 > /var/www/html/memory.html #empty the file befor adding data
echo "" >> /var/www/html/memory.html 
echo "<!DOCTYPE html>
<html>
<head>
<style>
table, th, td {
  border: 1px solid black;
}
</style>
</head>
<body>
<table style='width:100%'>
  <tr>
    <th>time</th>
    <th>free</th>
    <th>used</th>
  </tr>" >> /var/www/html/memory.html #making my html table
sum1=0
sum2=0
count=0
for file in /var/www/html/data/memory/* #looping over all memory stat files(created by first task) 
do
count=$((count + 1))    
IFS=' '
read -a vars < $file #sliceing file based on spaces
a=${vars[0]}
sum1=$((sum1 + a)) # sum the data of all files
b=${vars[1]}
sum2=$((sum2 + b))

filename=$(basename $file) #dont need the full path just file name

echo "<tr> 
    <td>$filename</td>
    <td>$a</td>
    <td>$b</td>
  </tr>" >> /var/www/html/memory.html #adding data to html table
done

 > /var/www/html/data/memoryavg #empty average file
avg1=$((sum1 / count))
avg2=$((sum2 / count))

echo "$avg1  $avg2" >> /var/www/html/data/memoryavg #write data to average file
sed -i "1 i\avg: free: $avg1 , used: $avg2 " /var/www/html/memory.html #write data to html file
echo "</table>
</body>
</html>
" >> /var/www/html/memory.html
#memory end


#cpu section start
 > /var/www/html/cpu.html
echo "" >> /var/www/html/cpu.html
echo "<!DOCTYPE html>
<html>
<head>
<style>
table, th, td {
  border: 1px solid black;
}
</style>
</head>
<body>
<table style='width:100%'>
  <tr>
    <th>time</th>
    <th>utilization</th>
  </tr>" >> /var/www/html/cpu.html





sum1=0
sum2=0
count=0
for file in /var/www/html/data/cpu/*
do
count=$((count + 1))    
IFS='.'
read -a vars < $file
a=${vars[0]}
sum1=$((sum1 + a))

filename=$(basename $file)

echo "<tr>
    <td>$filename</td>
    <td>$a</td>
  </tr>" >> /var/www/html/cpu.html

done

 > /var/www/html/data/cpuavg
avg1=$((sum1 / count))


echo "$avg1" >> /var/www/html/data/cpuavg
sed -i "1 i\avg: utlization: $avg1" /var/www/html/cpu.html
echo "</table>
</body>
</html>
" >> /var/www/html/cpu.html
#cpu end

#disk start

> /var/www/html/disk.html
echo "" >> /var/www/html/disk.html
echo "<!DOCTYPE html>
<html>
<head>
<style>
table, th, td {
  border: 1px solid black;
}
</style>
</head>
<body>
<table style='width:100%'>
  <tr>
    <th>time</th>
    <th>free</th>
    <th>used</th>
  </tr>" >> /var/www/html/disk.html

sum1=0
sum2=0
count=0
for file in /var/www/html/data/disk/*
do
count=$((count + 1))    
IFS=' '
read -a vars < $file
a=${vars[0]}
sum1=$((sum1 + a))
b=${vars[1]}
sum2=$((sum2 + b))


filename=$(basename $file)

echo "<tr>
    <td>$filename</td>
    <td>$a</td>
    <td>$b</td>
  </tr>" >> /var/www/html/disk.html
done

 > /var/www/html/data/diskavg
avg1=$((sum1 / count))
avg2=$((sum2 / count))

echo "$avg1  $avg2" >> /var/www/html/data/diskavg
sed -i "1 i\avg: free: $avg1 , used: $avg2 " /var/www/html/disk.html
echo "</table>
</body>
</html>
" >> /var/www/html/disk.html
#disk end
