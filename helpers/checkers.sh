isNaN() {
 if ! [[ "$1" =~ ^[0-9]+$ ]]; then
  echo true;
 else
  echo false;
 fi
}

isFile() {
 if [[ $1 = *.* ]]; then
  echo true;
 else
  echo false;
 fi
}