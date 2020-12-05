
# $1: string (highlight syntax)
color() {
 local text=$1;
 text=${text//\*/$white}
 text=${text//\#/$gray}
 text=${text//\!/$yellow}
 text=${text//\@/$blue}
 text=${text//\+/$green}
 text=${text//\§/$red}
 echo ${text//\./$base}
}

# $1: string (text to split)
# $2: char (delimiter syntax to determine split position)
# $3: integer (index of what array position to return)
split() {
 echo "$1" | cut -d $2 -f$3;
}

# $1: string (text to trim)
trim() {
 if [ $1 != "" ]; then
  echo $1 | xargs;
 fi
}

# $1: string (text to convert to uppercase)
toUpper() {
 echo "$1" | tr '[:lower:]' '[:upper:]';
}

# $1: string (text to convert to lowercase)
toLower() {
 echo "$1" | tr '[:upper:]' '[:lower:]'
}

# $1: string (text to convert the first letter to uppercase)
capitalize() {
 local string=$1;
 echo $(tr '[:lower:]' '[:upper:]' <<< ${string:0:1})${string:1};
}

# $1: integer (amount of things)
pluralize() {
 if [ $1 -eq 1 ]; then
  echo "";
 else
  echo "s";
 fi
}

# $1: string (text to extract number from)
parseInt() {
 local string=$1;
 echo "${string//[^0-9]/}";
}

