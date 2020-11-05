stash() {
 git stash list;
}

stash-save() {
 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gsts <title>";
  echo false;
  return;
 fi
 
 if ! $(hasChanges); then
  prompt $telescopeIcon "Branch does not have any changes";
  echo false;
  return;
 fi

 if ! $(run "git stash save -u $1"); then
  echo false;
  return;
 fi
 
 local changes=$(changeCount);

 prompt $tadaIcon "Successfully stashed [$changes] file$(plural $changes)";
 echo true;
}

stash-drop() {
 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gstd <stash>";
  echo false;
  return;
 fi
 
 local index;
 local stash;

 if ! $(isNaN $1); then
  index=$1;
  stash="stash@{$1}";
 else
  stash=$1;
  index=$(getNumberFromString $1);
 fi

 local count=$(stashCount);

 if [ $index -gt $(($count - 1)) ]; then
  prompt $telescopeIcon "[$stash] does not exist";
  return;
 fi

 if ! $(run "git stash drop $stash"); then
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully dropped [$stash]";
 echo true;
}

stash-apply() {
 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gsta <stash>";
  echo false;
  return;
 fi
 
 local index;
 local stash;

 if $(hasUnstagedChanges); then
  prompt $constructionIcon "Branch has work in progress";
  echo false;
  return;
 fi

 if ! $(isNaN $1); then
  index=$1;
  stash="stash@{$1}";
 else
  stash=$1;
  index=$(getNumberFromString $1);
 fi

 local count=$(stashCount);

 if [ $index -gt $(($count - 1)) ]; then
  prompt $telescopeIcon "[$stash] does not exist";
  return;
 fi

 if ! $(run "git stash apply $stash"); then
  echo false;
  return;
 fi

 local changes=$(changeCount);
 prompt $tadaIcon "Successfully applied [$changes] stashed file$(plural $changes)";
 echo true;
}