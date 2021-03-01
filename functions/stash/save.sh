# save changes in a named and indexed stash
stash-save() {
 if ! $(oneArguments $@); then
  invalid;
  echo false;
  return;
 fi
 
 # abort script if working branch has unhandled changes
 if ! $(isZero $(changes)); then
  prompt $construction $WIP;
  echo false;
  return;
 fi

 # store total count of changes
 local changes=$(changes);

 # save changes in a named stash and assign index
 if ! $(run "git stash save -u $1"); then
  echo false;
  return;
 fi

 successfully "Stashed **$changes.. file$(pluralize $changes)";
 echo true;
}