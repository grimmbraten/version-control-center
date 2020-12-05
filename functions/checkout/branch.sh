checkout() {
 local breed;
 
 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi

 if $(has-leafs); then
  $(stash-save $(growing-plant));  
 fi

 if $(plant-exists $1); then
  breed=$(plant-breed $1);

  if ! $(run "git checkout $1"); then
   echo false;
   return;
  fi
 elif $(plant-origin-exists $1); then
  breed=$(plant-breed origin/$1);

  if ! $(run "git checkout -b $1 origin/$1"); then
   echo false;
   return;
  fi
 else
  prompt $seeNoEvilIcon $branchDoesNotExist;
  echo false;
  return
 fi

 local index=$(getSeedIndexByName $1);

 if [ ! -z $index ]; then
  if $(stash-apply $index); then
   $(stash-drop $index);
  fi
 fi

 prompt $(plant-icon $(packages-ahead-of-master $breed)) "Planted $(plant-name $(packages-ahead-of-master $toIdentity)) #($toIdentity)";
 echo true;
}