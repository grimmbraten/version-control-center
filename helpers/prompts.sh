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
  echo -e "$boomIcon $1 encountered an error" >&2;
 fi
}

# $1: string (message)
invalid() {
 if [ ! -z $1 ]; then
  echo -e "$constructionIcon Invalid usage, please follow the expected format $gray($1)$base" >&2;
 fi
}

# $1: string  (unicode icon)
# $2: string  (message)
prompt() {
 if [[ ! -z $1 && ! -z $2 ]]; then
  echo "$1 $(applyColors "$2")" >&2;
 fi
}