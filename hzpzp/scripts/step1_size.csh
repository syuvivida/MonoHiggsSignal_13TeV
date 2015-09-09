#!/bin/tcsh

foreach file($argv)
 set a=`grep "Timing-tstoragefile-write-totalMegabytes" $file/step1*xml | awk '{print $3}'   | sed 's/Value="//g' | sed 's/"\/>//g'`
 set b=`echo "1000*$a/30" | bc -ql | head -c 9`
 echo $b    
end
