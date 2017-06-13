#!/bin/bash
arruser=(paijo paino parno dan kawannya)
for (( i = 0; i < 14 ;i++ ))
do
	#echo ${arruser[$i]}
	if [ `ps f -N -u root|grep -v grep|grep -c ${arruser[$i]}` -gt "1" ]; then
		for x in `ps f -N -u root | grep -v grep | grep ${arruser[$i]} | awk '{print $1}'`; do kill -9 $x; done
	fi
done
