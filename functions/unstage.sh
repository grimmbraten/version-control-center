# unstage files from passed folder/file
unstage() {
 local query"reset";

 if $(isFile $1); then
  query="reset $1";
 else
  query="reset $1/*";
 fi

 local unstaged;
 local before=$(staged);

 # execute built reset query
 if ! $(run "git $query"); then
  echo false;
  return;
 fi

 local after=$(staged);

 if ! $(isEmpty $1); then
  unstaged=$(($before - $after));
 else
  unstaged=$before;
 fi

 # prompt user that no files were unstaged
 if $(isZero $diff); then
  prompt $telescope "could not find $(targetType $target)";
  echo false;
 else
  $(status-list true);
  prompt $package "Unbundled **$diff.. file$(pluralize $diff) from package ##($(staged)/$(changes))..";
  echo true;
 fi
}

# unstage all changed files
unstage-all() {
 if $(noArguments $@); then
  $(unstage);  
 else
  invalid;
 fi
}