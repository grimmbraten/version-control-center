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

 local staged=$(bundled-leafs);

 if $(zero $staged); then
  prompt $telescopeIcon "No package ready to be sealed";
  echo false;
  return;
 fi
 
 local label=$(addEmoji $1);

 if $(empty $label); then
  label=$1;
 fi
 
 if  $(empty $2); then
  if ! $(run "git commit -m \"$label\""); then
   echo false;
   return;
  fi
 else
  if ! $(run "git commit -m \"$label\" -m \"$(capitalize $2)\""); then
   echo false;
   return;
  fi
 fi
 
 if [ $(leafs) -gt 0 ]; then
  $(status-list true);
 fi

 successfully "Sealed package with *$staged. file$(pluralize $staged)";
 prompt $packageIcon "*$(plant-breed)";
 prompt $(getEmojiForConsole $1) "$(trim "$(split $1 ":" 2)")";

 if ! $(empty $2); then
  prompt $descriptionIcon "$2";
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