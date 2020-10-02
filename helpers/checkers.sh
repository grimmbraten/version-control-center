# $1: any (value to be checked)
isNaN() {
 if ! [[ "$1" =~ ^[0-9]+$ ]]; then
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
getTargetType() {
 if $(isFile $1); then
  echo "file";
 else
  echo "folder";
 fi
}

# $1: string (value to be checked)
# $2: string (path to text file)
existsInFile() {
 if grep -Fxq "$1" $2; then
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