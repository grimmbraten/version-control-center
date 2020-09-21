stashes() {
 git stash list;
}

save() {
 if [ -z $1 ]; then
  missing "What title would you like to have for the stash?";
 elif [ ! -z $2 ]; then
  invalid "gsts <title>";
 else
  $(runSaveRequest $1 true);
 fi
}

runSaveRequest() {
 local title=$1;
 local output=$2;

 if ! $(hasChanges); then
  prompt $dissapointed "Branch contains [no] changes to stash" $output;
  echo false;
  return;
 fi

 if ! $(run "git stash save -u $title"); then
  echo false;
  return;
 fi
 
 local changes=$(changeCount);

 prompt $tada "Successfully stashed [$changes] change$(plural $changes) without any issues]" $output;
 echo true;
}

apply() {
 if [ -z $1 ]; then
  #TODO: Make these missing calls into question
  missing "Which stash would you like to apply?";
 elif [ ! -z $2 ]; then
  invalid "gsta <stash index>";
 else
  $(runApplyRequest $1 true);
 fi
}

runApplyRequest() {
 local stash;
 local index=$1;
 local output=$2;

 if $(hasUnstagedChanges); then
  prompt $construction "Branch contains changes, please [stash] or [bundle] them before checking out" $output;
  echo false;
  return;
 fi

 if ! $(isNaN $index); then
  stash="stash@{$index}";
 else
  stash=$index;
  index=$(getNumberFromString $stash);
 fi

 local count=$(stashCount);

 if [ $index -gt $(($count - 1)) ]; then
  prompt $dissapointed "That stash does not exist" $output;
  return;
 fi

 if ! $(run "git stash apply $stash"); then
  echo false;
  return;
 fi

 local total=$(changeCount);

 prompt $tada "Successfully applied [$changes] stashed change$(plural $changes) without any issues" $output;
 echo true;
}

drop() {
 if [ -z $1 ]; then
  missing "Which stash would you like to drop?";
 elif [ ! -z $2 ]; then
  invalid "gstd <stash index>";
 else
  $(runDropRequest $1 true);
 fi
}

runDropRequest() {
 local stash;
 local index=$1;
 local output=$2;

 if ! $(isNaN $index); then
  stash="stash@{$index}";
 else
  stash=$index;
  index=$(getNumberFromString $stash);
 fi

 local count=$(stashCount);

 if [ $index -gt $(($count - 1)) ]; then
  prompt $dissapointed "That stashed does not exist" $output;
  return;
 fi

 if ! $(run "git stash drop $stash"); then
  echo false;
  return;
 fi

 prompt $tada "Successfully dropped [$stash] without any issues" $output;
 echo true;
}