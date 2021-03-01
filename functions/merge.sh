# merge passed branch with working branch
merge() {
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

 if ( ! $(local-branch-exists $1) && ! $(remote-branch-exists $1) ); then
  prompt $telescope $BDNE;
  echo false;
  return
 fi

 # TODO This function is deprecated, look over again
 if [ $(local-behind-branch $1) -eq 0 ]; then
  successfully "Already **up to date.. with $target ##($(branch-hash $target)..";
  echo false;
  return;
 fi

 # merge passed branch into working branch
 if ! $(run "git merge $1"); then
  echo false;
  return;
 fi
 
 successfully "Merged ##($(branch-hash $1))..";
 echo true;
}