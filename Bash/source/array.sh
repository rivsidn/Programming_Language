#! /bin/bash


declare -a arr

arr=(var0 var1 var2 var3)

echo ${arr[0]}
echo ${arr[1]}
echo ${arr[2]}
echo ${arr[3]}

arr+=var4

echo ${arr[0]}

