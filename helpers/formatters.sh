
# $1: string (highlight syntax)
format() {
 local text=$1;
 text=${text//\*\*/$white}
 text=${text//\#\#/$gray}
 text=${text//\!\!/$yellow}
 text=${text//\?\?/$blue}
 text=${text//\+\+/$green}
 text=${text//\-\-/$red}
 echo ${text//\.\./$base}
}

# $1: string (text to split)
# $2: char (delimiter syntax to determine split position)
# $3: integer (index of what array position to return)
split() {
 echo "$1" | cut -d $2 -f$3;
}

# returns the passed value trimmed from trailing whitespace
trim() {
 if [ $1 != "" ]; then
  echo $1 | xargs;
 fi
}

# returns the passed value in all uppercase
toUpper() {
 echo "$1" | tr '[:lower:]' '[:upper:]';
}

# returns the passed value in all lowercase
toLower() {
 echo "$1" | tr '[:upper:]' '[:lower:]'
}

# returns the passed value with the first character capitalized
capitalize() {
 local string=$1;
 echo $(tr '[:lower:]' '[:upper:]' <<< ${string:0:1})${string:1};
}

# returns an "s" if the passed value does not equal one
pluralize() {
 if [ $1 -eq 1 ]; then
  echo "";
 else
  echo "s";
 fi
}

# returns a number extracted from the passed value
parseInt() {
 local string=$1;
 echo "${string//[^0-9]/}";
}

