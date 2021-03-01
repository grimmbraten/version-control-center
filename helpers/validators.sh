# return true if passed value is equal to zero
isZero() {
 if [ $1 -eq 0 ]; then
  echo true;
 else
  echo false;
 fi
}

# return true if passed value is not a number
isNaN() {
 if ! [[ "$1" =~ ^[0-9]+$ ]]; then
  echo true;
 else
  echo false;
 fi
}

# return true if first passed string contains second passed string
contains() {
 if [[ $1 == *"$2"* ]]; then
  echo true;
 else
  echo false;
 fi
}

# return true if passed string is empty
isEmpty() {
 if [ -z $1 ]; then
  echo true;
 else
  echo false;
 fi
}

# return true if passed string contains a full stop
isFile() {
 if [[ $1 = *.* ]]; then
  echo true;
 else
  echo false;
 fi
}

# return "file" if passed string contains a full stop, otherwise return "folder"
targetType() {
 if $(isFile $1); then
  echo "file";
 else
  echo "folder";
 fi
}

# return true if first passed number is greater than the second passed number
greaterThan() {
 if [ $1 -gt $2 ]; then
  echo true;
 else
  echo false;
 fi
}

# return true if first passed number is less than second passed number
lessThan() {
 if [ $1 -lt $2 ]; then
  echo true;
 else
  echo false;
 fi
}


# return true if no arguments are passed
noArguments() {
 if $(isEmpty $1); then
  echo true;
 else
  echo false;
 fi
}

# return true if one argument is passed
oneArguments() {
 if ( ! $(isEmpty $1) && $(isEmpty $2) ); then
  echo true;
 else
  echo false;
 fi
}

# return true if two arguments are passed
twoArguments() {
 if ( ! $(isEmpty $1) && ! $(isEmpty $2) && $(isEmpty $3) ); then
  echo true;
 else
  echo false;
 fi
}

# return true if three arguments are passed
threeArguments() {
 if ( ! $(isEmpty $1) && ! $(isEmpty $3) ); then
  echo false;
 else
  echo true;
 fi
}