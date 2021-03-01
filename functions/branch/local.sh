# list all local branches
branch() {
 if $(noArguments $@); then
  git branch -v | cut -c 3- | awk '$3 !~/\[/ { print $1 }';
  echo true;
 else
  invalid;
  echo false;
 fi
}