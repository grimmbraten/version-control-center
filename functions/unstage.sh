unstage() {
 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi

 local query;

 if $(empty $1); then
  query="reset";
 elif $(isFile $1); then
  query="reset $1";
 else
  query="reset $1/*";
 fi

 local before=$(bundled-leafs);

 if ! $(run "git $query"); then
  echo false;
  return;
 fi

 local after=$(bundled-leafs);

 if ! $(empty $1); then
  diff=$(($before - $after));
 else
  diff=$before;
 fi

 if $(zero $diff); then
  prompt $telescopeIcon "could not find $(targetType $target)";
  echo false;
 else
  $(status-list true);
  prompt $packageIcon "Unbundled *$diff. file$(pluralize $diff) from package #($(bundled-leafs)/$(leafs))";
  echo true;
 fi
}

unstage-all() {
 if $(isCalledWithNoArguments $@); then
  $(unstage "");  
 else
  invalid;
 fi
}