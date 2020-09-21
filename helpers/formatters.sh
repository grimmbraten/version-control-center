applyColors() {
 local text=$1;
 text=${text//\[/"\033[1;37m"}
 text=${text//\_/"\033[1;30m"}
 echo ${text//\]/"\033[0m"}
}

plural() {
 if [ $1 -eq 1 ]; then
  echo "";
 else
  echo "s";
 fi
}



trim() {
 if [ $1 != "" ]; then
  echo $1 | xargs;
 fi
}

getNumberFromString() {
 local string=$1;
 echo "${string//[^0-9]/}";
}