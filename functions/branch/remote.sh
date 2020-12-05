branch-origins() {
 if $(calledWithNoArguments $@); then
  git branch -r -vv | cut -c 3- | awk '$3 !~/\[/ { print $1 }';
  echo true;
 else
  invalid;
  echo false;
 fi
}