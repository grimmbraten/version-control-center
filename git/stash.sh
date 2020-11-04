stashes() {
 spacer;

 git stash list;

 spacer;
}

save() {
 spacer;

 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gsts <title>";
 else
  $(runSaveRequest $1 true);
 fi
 
 spacer;
}

apply() {
 spacer;

 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gsta <stash>";
 else
  $(runApplyRequest $1 true);
 fi

 spacer;
}

drop() {
 spacer;

 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gstd <stash>";
 else
  $(runDropRequest $1 true);
 fi

 spacer;
}

# $1: string  (title for stash)
# $2: boolean (verbose)
runSaveRequest() {
 if ! $(hasChanges); then
  prompt $telescopeIcon "Branch does not have any changes" $2;
  echo false;
  return;
 fi

 if ! $(run "git stash save -u $1"); then
  echo false;
  return;
 fi
 
 local changes=$(changeCount);

 prompt $tadaIcon "Successfully stashed [$changes] file$(plural $changes)" $2;
 echo true;
}

# $1: integer (stash index number)
# $2: boolean (verbose)
runApplyRequest() {
 local index;
 local stash;

 if $(hasUnstagedChanges); then
  prompt $constructionIcon "Branch has work in progress" $2;
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
  prompt $telescopeIcon "[$stash] does not exist" $2;
  return;
 fi

 if ! $(run "git stash apply $stash"); then
  echo false;
  return;
 fi

 local changes=$(changeCount);
 prompt $tadaIcon "Successfully applied [$changes] stashed file$(plural $changes)" $2;
 echo true;
}

# $1: integer (stash index number)
# $2: boolean (verbose)
runDropRequest() {
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
  prompt $telescopeIcon "[$stash] does not exist" $2;
  return;
 fi

 if ! $(run "git stash drop $stash"); then
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully dropped [$stash]" $2;
 echo true;
}