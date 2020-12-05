# $1: any (value to be checked)
zero() {
 if [ $1 -eq 0 ]; then
  echo true;
 else
  echo false;
 fi
}

# $1: any (value to be checked)
isNaN() {
 if ! [[ "$1" =~ ^[0-9]+$ ]]; then
  echo true;
 else
  echo false;
 fi
}

# $1: string (value to search in)
# $2: string (value to search for)
contains() {
 if [[ $1 == *"$2"* ]]; then
  echo true;
 else
  echo false;
 fi
}

# $1: string (value to be checked if empty or not)
empty() {
 if [ -z $1 ]; then
  echo true;
 else
  echo false;
 fi
}

# $1: string (value to be checked)
isFile() {
 if [[ $1 = *.* ]]; then
  echo true;
 else
  echo false;
 fi
}

# $1: string (value to be checked)
targetType() {
 if $(isFile $1); then
  echo "file";
 else
  echo "folder";
 fi
}

greaterThan() {
 if [ $1 -gt $2 ]; then
  echo true;
 else
  echo false;
 fi
}

lessThan() {
 if [ $1 -lt $2 ]; then
  echo true;
 else
  echo false;
 fi
}

# Argument checkers

isCalledWithNoArguments() {
 if $(empty $1); then
  echo true;
 else
  echo false;
 fi
}

isCalledWithOneArgument() {
 if ( ! $(empty $1) && $(empty $2) ); then
  echo true;
 else
  echo false;
 fi
}

isCalledWithTwoArguments() {
 if ( ! $(empty $1) && ! $(empty $2) && $(empty $3) ); then
  echo true;
 else
  echo false;
 fi
}

isCalledWithOneOrTwoArguments() {
 if ( ! $(empty $1) && ! $(empty $3) ); then
  echo false;
 else
  echo true;
 fi
}