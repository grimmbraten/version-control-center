# list all remote branches
branch-origins() {
 if $(noArguments $@); then
  git branch -r -vv | cut -c 3- | awk '$3 !~/\[/ { print $1 }';
  echo true;
 else
  invalid;
  echo false;
 fi
}