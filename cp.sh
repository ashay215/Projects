
#!/bin/bash
filename='ranges.dat'
filelines=`cat $filename`
echo Start
for line in $filelines ; do
   # echo $line
    goto1='/home/rcf-57/astro0/data/avgspc2880.wtnonavgcorrall.'
    goto2='dpirlnewrr.hpcc'
    gotofinal=$goto1$line$goto2
    #echo $gotofinal
    cd $gotofinal
    pwd
    ./cp000file.sh
    echo 'ran cp000file for' $line
done
