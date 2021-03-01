# apply stash by passed index/name
stash-apply() {
 if ! $(oneArguments $@); then
  invalid;
  echo false;
  return;
 fi
 
 local index=$1;
 local stash="stash@{$1}";

 # abort script if working branch has unhandled changes
 if ! $(isZero $(changes)); then
  prompt $construction $WIP;
  echo false;
  return;
 fi
 
 # check if index is a number
 if ! $(isNaN $index); then
  index=$(parseInt $1);
  stash=$1;
 fi

 # store total count of local stashes
 local stashes=$(stashes);

 # check that passed index is within the scope of total count of local stashes
 if [ $index -gt $(($stashes - 1)) ]; then
  prompt $telescope "**$stash.. does not exist";
  return;
 fi

 # apply changes from selected local stash
 if ! $(run "git stash apply $stash"); then
  echo false;
  return;
 fi

 # store total count of changes
 local changes=$(changes);

 successfully "Applied **$changes.. stashed file$(pluralize $changes)";
 echo true;
}