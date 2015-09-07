#!/bin/tcsh

foreach file($argv)
 set a=`grep "Timing-tstoragefile-write-totalMegabytes" $file/step0*xml | awk '{print $3}'   | sed 's/Value="//g' | sed 's/"\/>//g'`
 set b=`echo "1000*$a/30" | bc -ql | head -c 5`
 echo $b    
end
