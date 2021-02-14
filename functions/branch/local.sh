branch() {
 if $(isCalledWithNoArguments $@); then
  git branch -v | cut -c 3- | awk '$3 !~/\[/ { print $1 }';
  echo true;
 else
  invalid;
  echo false;
 fi
}