stage() {
 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi

 local diff;
 local before=$(unbundled-leafs);

 if ! $(run "git add $1"); then
  echo false;
  return;
 fi

 local after=$(unbundled-leafs);
 
 if [ $1 != . ]; then
  diff=$(($before - $after));
 else
  diff=$before;
 fi
 
 if $(zero $diff); then
  prompt $telescopeIcon "Could not find $(targetType $target)";
  echo false;
 else
  $(status-list true);
  prompt $packageIcon "Bundled *$diff. file$(pluralize $diff) to package #($(bundled-leafs)/$(leafs))";
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