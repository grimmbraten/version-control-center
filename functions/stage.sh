stage() {
 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi

 local diff;
 local before=$(unstaged);

 if ! $(run "git add $1"); then
  echo false;
  return;
 fi

 local after=$(unstaged);
 
 if [ $1 != . ]; then
  diff=$(($before - $after));
 else
  diff=$before;
 fi
 
 if $(isZero $diff); then
  prompt $telescope "Could not find $(targetType $target)";
  echo false;
 else
  $(status-list true);
  #TODO: Change "package" to bundle branches / sprouts? depending on commit sice
  prompt $package "Bundled **$diff.. file$(pluralize $diff) to package #($(staged)/$(changes))";
  echo true;
 fi 
}

stage-all() {
 if $(isCalledWithNoArguments $@); then
  $(stage .);
 else
  invalid;
 fi
}