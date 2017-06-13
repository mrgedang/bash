#!/bin/zsh
# ~GG~ John The Ripper runner
# 28/03/2017

JTR_HOME=/Users/zam/Tools/john-1.8.0-jumbo-1/run
WORDLIST_DIR=/Users/zam/Tools/john-1.8.0-jumbo-1/wordlist/simple
WORDLIST_FILES=($(cd ${WORDLIST_DIR};ls -Sr *.txt));
WORDLIST_COUNT=${#WORDLIST_FILES[@]}
TARGET_DIR=${PWD}
function usage(){
  echo "=============================================";
  echo "            John The Ripper Runner           ";
  echo "=============================================";
  echo "Usage: $0 <mode> file_with_hash.txt [options]";
  echo "Ex: $0 password.txt --format=Raw-MD5 --single";
  echo "Mode: show, restore, single, wordlist, manual";
  echo ".............................................";
}

function show(){
  ${JTR_HOME}/john --show $1
}

function restore(){
  ${JTR_HOME}/john --restore=$1 $2
}

function single(){
  ${JTR_HOME}/john --session=$1 --single $1 $2
}

function wordlist(){
  for (( i = 1; i <= ${WORDLIST_COUNT} ;i++ ))
  do
    echo "Cracking [$1] with wordlist file ["${WORDLIST_FILES[$i]}"]"
    if [ -f "$1" ]
    then
      ${JTR_HOME}/john --rules=Gedang $1 --wordlist=${WORDLIST_DIR}/${WORDLIST_FILES[$i]} --session=$1-${WORDLIST_FILES[$i]} $2
    else
      echo "Please give me a real file."
    fi
  done
}

function manual(){
  ${JTR_HOME}/john $1 $2 $3 $4 
}

case "$1" in
'show')
show $2
;;
'restore')
restore $2
;;
'single')
single $2 $3
;;
'wordlist')
wordlist $2 $3
;;
'manual')
manual $2 $3 $4 $5
;;
*)
usage
esac 
