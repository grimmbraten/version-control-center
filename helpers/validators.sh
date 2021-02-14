# returns true if the passed value is isZero
isZero() {
 if [ $1 -eq 0 ]; then
  echo true;
 else
  echo false;
 fi
}

# returns true if the passed value is not a number
isNaN() {
 if ! [[ "$1" =~ ^[0-9]+$ ]]; then
  echo true;
 else
  echo false;
 fi
}

# returns true if the first passed value contains the second passed value
contains() {
 if [[ $1 == *"$2"* ]]; then
  echo true;
 else
  echo false;
 fi
}

# returns true if the passed value is empty
isEmpty() {
 if [ -z $1 ]; then
  echo true;
 else
  echo false;
 fi
}

# returns true if the passed value contains a full stop
isFile() {
 if [[ $1 = *.* ]]; then
  echo true;
 else
  echo false;
 fi
}

# returns "file" if the passed value contains a full stop, otherwise it returns "folder"
targetType() {
 if $(isFile $1); then
  echo "file";
 else
  echo "folder";
 fi
}

# returns true if the first passed value is greater than the second passed value
greaterThan() {
 if [ $1 -gt $2 ]; then
  echo true;
 else
  echo false;
 fi
}

# returns true if the first passed value is less than the second passed value
lessThan() {
 if [ $1 -lt $2 ]; then
  echo true;
 else
  echo false;
 fi
}


# returns true if no values are passed to the function
isCalledWithNoArguments() {
 if $(isEmpty $1); then
  echo true;
 else
  echo false;
 fi
}

# returns true if strictly one value is passed to the function
isCalledWithOneArgument() {
 if ( ! $(isEmpty $1) && $(isEmpty $2) ); then
  echo true;
 else
  echo false;
 fi
}

# returns true if strictly two values are passed to the function
isCalledWithTwoArguments() {
 if ( ! $(isEmpty $1) && ! $(isEmpty $2) && $(isEmpty $3) ); then
  echo true;
 else
  echo false;
 fi
}

# returns true if one or two values are passed to the function
isCalledWithOneOrTwoArguments() {
 if ( ! $(isEmpty $1) && ! $(isEmpty $3) ); then
  echo false;
 else
  echo true;
 fi
}