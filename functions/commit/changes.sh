commit() { 
 if ! $(isCalledWithOneOrTwoArguments $@); then
  invalid;
  echo false;
  return;
 fi

 if [ $(growing-plant) = master ]; then
  protected "master";
  echo false;
  return;
 fi

 local staged=$(staged);

 if $(isZero $staged); then
  prompt $telescope "No package ready to be sealed";
  echo false;
  return;
 fi
 
 if  $(isEmpty $2); then
  if ! $(run "git commit -m \"$1\""); then
   echo false;
   return;
  fi
 else
  if ! $(run "git commit -m \"$1\" -m \"$(capitalize $2)\""); then
   echo false;
   return;
  fi
 fi
 
 if [ $(changes) -gt 0 ]; then
  $(status-list true);
 fi

 successfully "Sealed package with *$staged. file$(pluralize $staged)";
 prompt $package "*$(plant-breed)";
 prompt $package "$(trim "$(split $1 ":" 2)")";
 #TODO change this icon

 if ! $(isEmpty $2); then
  prompt $package "$2";
 fi

 echo true;
}

commit-all() {
 if ! $(isCalledWithOneOrTwoArguments $@); then
  invalid;
  echo false;
  return;
 fi
 
 if ( $(stage .) && ! $(commit $1 "$2") ); then
  $(unstage "");
 fi
}