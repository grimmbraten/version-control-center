commit-rename() {
 if ! $(isCalledWithOneOrTwoArguments $@); then
  invalid;
  echo false;
  return;
 fi

 if ( $(plant-origin-exists $(growing-plant)) && [ $(plant-origin-ahead) -eq 0 ] ) || [ $(forest-ahead) -eq 0 ]; then
  prompt $seeNoEvilIcon "Package has already been delivered";
  echo false;
  return;
 fi
 
 if $(empty $2); then
  if ! $(run "git commit --amend -m \"$(addEmoji $1)\""); then
   echo false;
   return;
  fi
 else
  if ! $(run "git commit --amend -m \"$(addEmoji $1)\" -m \"$2\""); then
   echo false;
   return;
  fi
 fi
 
 successfully "Relabeled package #($(plant-breed)";
 echo true;
}