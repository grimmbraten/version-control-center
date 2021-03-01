# commit staged changed
commit() { 
 if ! $(threeArguments $@); then
  invalid;
  echo false;
  return;
 fi

 # TODO: add global prompt for this use-case
 # prompt the user that the master branch is always protected
 if [ $(working-branch) = master ]; then
  protected "master";
  echo false;
  return;
 fi
 
 # store total count of staged files
 local staged=$(staged);

 # abort script if no staged files were found
 if $(isZero $staged); then
  prompt $telescope "No package ready to be sealed";
  echo false;
  return;
 fi
 
 if  $(isEmpty $2); then
  # apply title to commit
  if ! $(run "git commit -m \"$1\""); then
   echo false;
   return;
  fi
 else
  # apply title and description to commit
  if ! $(run "git commit -m \"$1\" -m \"$(capitalize $2)\""); then
   echo false;
   return;
  fi
 fi
 
 # check if there are any unstaged or unhandled changes left
 if [ $(changes) -gt 0 ]; then
  # prompt status list
  $(status-list true);
 fi

 successfully "Sealed package with **$staged.. file$(pluralize $staged)";
 prompt $package "*$(branch-hash)";
 prompt $package "$(trim "$(split $1 ":" 2)")";
 #TODO change this icon

 if ! $(isEmpty $2); then
  prompt $package "$2";
 fi

 echo true;
}

# commit all changes
commit-all() {
 if ! $(threeArguments $@); then
  invalid;
  echo false;
  return;
 fi
 
 # unstage if stage succeeded but commit failed
 if ( $(stage .) && ! $(commit $1 "$2") ); then
  $(unstage "");
 fi
}