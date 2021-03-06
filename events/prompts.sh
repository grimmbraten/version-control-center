spacer() {
 echo "";
}

# $1: string (message)
mention() {
 if [ ! -z $1 ]; then
  echo -e "$1" >&2;
 fi
}

# $1: string (message)
error() {
 if [ ! -z $1 ]; then
  echo -e "$construction $1 encountered an error" >&2;
 fi
}

# $1: string (message)
invalid() {
 if [ ! -z $1 ]; then
  echo -e "$telescope Could not find command" >&2;
 fi
}

protected() {
 if [ ! -z $1 ]; then
  echo "$construction Branch $(format "*$1.") is protected" >&2;
 fi
}

successfully() {
 prompt $tada "$1";
}

error() {
 prompt $construction "$1"; 
}

# $1: string  (unicode icon)
# $2: string  (message)
prompt() {
 if [[ ! -z $1 && ! -z $2 ]]; then
  echo "$1 $(format "$2")" >&2;
 fi
}