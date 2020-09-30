# $1: highlight syntax
applyColors() {
 local text=$1;
 text=${text//\[/"\033[1;37m"}
 text=${text//\_/"\033[1;30m"}
 echo ${text//\]/"\033[0m"}
}

# $1: amount
plural() {
 if [ $1 -eq 1 ]; then
  echo "";
 else
  echo "s";
 fi
}

# $1: string
trim() {
 if [ $1 != "" ]; then
  echo $1 | xargs;
 fi
}

# $1: string
toUpper() {
 echo "$1" | tr '[:lower:]' '[:upper:]';
}

# $1: string
toLower() {
 echo "$1" | tr '[:upper:]' '[:lower:]'
}

# $1: string
capitalize() {
 local string=$1;
 echo $(tr '[:lower:]' '[:upper:]' <<< ${string:0:1})${string:1};
}

# $1: string, $2: delimiter, $3: return index
split() {
 echo "$1" | cut -d $2 -f$3;
}

# $1: string
getNumberFromString() {
 local string=$1;
 echo "${string//[^0-9]/}";
}