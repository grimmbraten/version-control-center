#TODO: Allow user to checkout branch by passing a search query
#TODO: Allow user to checkout branch by passing a jira ticket id

# checkout passed branch from local or remote origin
checkout() {
 local hash;
 
 # check that function was called with strictly one argument
 if ! $(oneArguments $@); then
  invalid;
  echo false;
  return;
 fi

 # check if current branch has any unhandled changes
 if $(has-changes); then
  $(stash-save $(working-branch));  
 fi

 # locate where passed branch exists
 if $(local-branch-exists $1); then
  hash=$(branch-hash $1);

  # checkout branch found on local machine
  if ! $(run "git checkout $1"); then
   echo false;
   return;
  fi
 elif $(remote-branch-exists $1); then
  hash=$(branch-hash origin/$1);

 # checkout and create a local branch for the branch found on remote origin
  if ! $(run "git checkout -b $1 origin/$1"); then
   echo false;
   return;
  fi
 else
  prompt $telescope $BDNE;
  echo false;
  return
 fi

 # check if any automatic stashes exists for the checked out branch
 local index=$(find-stash-by-name $1);

 # apply and drop potentially found stash for branch
 if [ ! -z $index ]; then
  if $(stash-apply $index); then
   $(stash-drop $index);
  fi
 fi

 prompt $(plant-icon $(locale-ahead-of-master $breed)) "Planted $(plant-name $(locale-ahead-of-master $(working-branch))) ##($(working-branch))..";
 echo true;
}