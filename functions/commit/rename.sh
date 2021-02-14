commit-rename() {
 if ! $(isCalledWithOneOrTwoArguments $@); then
  invalid;
  echo false;
  return;
 fi

 if ( $(remote-exists $(growing-plant)) && [ $(remote-ahead) -eq 0 ] ) || [ $(local-behind-master) -eq 0 ]; then
  prompt $telescope "Package has already been delivered";
  echo false;
  return;
 fi
 
 if $(isEmpty $2); then
  if ! $(run "git commit --amend -m \"$1\""); then
   echo false;
   return;
  fi
 else
  if ! $(run "git commit --amend -m \"$1\" -m \"$2\""); then
   echo false;
   return;
  fi
 fi
 
 successfully "Relabeled package #($(plant-breed)";
 echo true;
}