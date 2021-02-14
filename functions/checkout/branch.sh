#TODO: Allow user to checkout branch by passing a search query
#TODO: Allow user to checkout branch by passing a jira ticket id

checkout() {
 local breed;
 
 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi

 if $(has-changes); then
  $(stash-save $(growing-plant));  
 fi

 if $(local-exists $1); then
  breed=$(plant-breed $1);

  if ! $(run "git checkout $1"); then
   echo false;
   return;
  fi
 elif $(remote-exists $1); then
  breed=$(plant-breed origin/$1);

  if ! $(run "git checkout -b $1 origin/$1"); then
   echo false;
   return;
  fi
 else
  prompt $telescope $branchDoesNotExist;
  echo false;
  return
 fi

 local index=$(find-stash-by-name $1);

 if [ ! -z $index ]; then
  if $(stash-apply $index); then
   $(stash-drop $index);
  fi
 fi

 prompt $(plant-icon $(packages-ahead-of-master $breed)) "Planted $(plant-name $(packages-ahead-of-master $toIdentity)) #($toIdentity)";
 echo true;
}