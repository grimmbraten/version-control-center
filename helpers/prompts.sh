spacer() {
 echo "";
}

error() {
 if [ ! -z $1 ]; then
  echo -e "$boom $1 encountered an error" >&2;
 fi
}

invalid() {
 if [ ! -z $1 ]; then
  echo -e "$construction Invalid usage, please follow the expected format $gray($1)$base" >&2;
 fi
}

missing() {
 if [ ! -z $1 ] && [ -z $2 ]; then
  echo -e "$holup $1" >&2;
 fi
}


prompt() {
 if [ ! -z $1 ] && [ ! -z $2 ] && [ ! -z $3 ] && $3; then
  echo "$1 $(applyColors "$2")" >&2;
 fi
}