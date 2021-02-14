unstage() {
 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi

 local query;

 if $(isEmpty $1); then
  query="reset";
 elif $(isFile $1); then
  query="reset $1";
 else
  query="reset $1/*";
 fi

 local before=$(staged);

 if ! $(run "git $query"); then
  echo false;
  return;
 fi

 local after=$(staged);

 if ! $(isEmpty $1); then
  diff=$(($before - $after));
 else
  diff=$before;
 fi

 if $(isZero $diff); then
  prompt $telescope "could not find $(targetType $target)";
  echo false;
 else
  $(status-list true);
  prompt $package "Unbundled **$diff.. file$(pluralize $diff) from package #($(staged)/$(changes))";
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