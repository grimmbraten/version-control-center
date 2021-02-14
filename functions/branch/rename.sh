branch-rename() {
 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi

 if $(local-exists $1); then
  #TODO Get plant icon and name to prompt instead
  prompt $compass $branchExists;
  echo false;
  return;
 fi

 local plant=$(growing-plant);

 if ! $(run "git branch -m $1"); then
  #Todo replace "plant" with actual plant name
  error "Failed to rename plant";
  echo false;
  return;
 fi

 if $(remote-exists $plant); then
  if $(question "Do you want to delete the remote origin?"); then
   if ! $(push-upstream); then    
    echo false;
    return;
   fi
  
   if ! $(branch-delete-origin $plant); then    
    echo false;
    return;
   fi
  fi
 fi
 
 #Todo replace "plant" with actual plant name
 successfully "Renamed plant #($(plant-breed))";
 echo true;
}