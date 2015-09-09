#!/bin/tcsh

foreach file($argv)
    set b=`grep -a  "AvgEventCPU" $file/step0*xml | awk '{print $3}'   | sed 's/Value="//g' | sed 's/"\/>//g' | head -c 7`
    echo $b
end
