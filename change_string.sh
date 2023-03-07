#!/bin/sh
#Usage: ./change_string.sh oldstring newstring
#This script changes string which in the file with extension .c .h .s .ch .conf
#You have to include the extension you want to change.
if [ "$#" -ne 2 ]
then
  echo "All Change Oldstring to Newstring recursively"
  echo "usage:ach Oldstring Newstring"
  exit
fi
if [ -f ./vim.scr ]
then
  echo "vim.scr already exists!"
  rm -rf ./vim.scr
  echo "vim.scr removed!"
  exit 1
else
  touch ./vim.scr
  echo ":%s,\<$1\>,$2,g">> vim.scr
  echo ":wq">> vim.scr
  find ./ \( -name '*.c' -o -name '*.h' -o -name '*.s' -o -name '*.ch' -o -name '*.conf' \) -print > allfiles
  temp1=`cat allfiles`
  for files in `echo $temp1`
  do
       grep -l "\<$1\>" $files /dev/null | sed 's/.*/vim & -s vim.scr/' >> tmpfiles
  done
  if [ -s tmpfiles ]
  then
       sh tmpfiles
  else
       echo "ach:No file to chage"
  fi
  rm -rf ./vim.scr
  rm -rf ./tmpfiles
  rm -rf ./allfiles
fi
