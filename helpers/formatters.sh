
# apply prompt formatting to passed string
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

# return specific part of a string
split() {
 echo "$1" | cut -d $2 -f$3;
}

# return string without trailing whitespace
trim() {
 if [ $1 != "" ]; then
  echo $1 | xargs;
 fi
}

# return passed string in all uppercase
toUpper() {
 echo "$1" | tr '[:lower:]' '[:upper:]';
}

# return passed string in all lowercase
toLower() {
 echo "$1" | tr '[:upper:]' '[:lower:]'
}

# return passed string with first character capitalized
capitalize() {
 local string=$1;
 echo $(tr '[:lower:]' '[:upper:]' <<< ${string:0:1})${string:1};
}

# return "s" if passed number does not equal one
pluralize() {
 if [ $1 -eq 1 ]; then
  echo "";
 else
  echo "s";
 fi
}

# return number extracted from passed string
parseInt() {
 local string=$1;
 echo "${string//[^0-9]/}";
}
