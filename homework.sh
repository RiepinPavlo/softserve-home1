#! /bin/bash

root_check() {
if [ $UID == 0 ];
then
  isRoot=1
else
  isRoot=0
fi
}

root_check

directory_check() {
if [ -d "$1" ];
then
 valid_directory=1
else
 valid_directory=0
fi
}


directory_check $1

user_exists() {
local check=$(grep $1 /etc/passwd)
if [ -n "$check" ]
then
 valid_user=1
else
 valid_user=0
fi
}
user_exists $2

run(){
if [[ isRoot -eq 1 && valid_directory -eq 1  && valid_user -eq 1 ]];
then
 `chown	$2 -R $1`
 echo "OK!"
 list=$(ls -l | grep $1)
 echo $list
else
 echo "Something wrong! "
 echo -e "isRoot: $isRoot \nValid user:$valid_user\nValid directory $valid_directory"
fi
}

run $1 $2
