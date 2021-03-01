# stage files from passed folder/file
stage() {
 if ! $(oneArguments $@); then
  invalid;
  echo false;
  return;
 fi

 local staged;
 local before=$(unstaged);


 # stage files from passed path/file
 if ! $(run "git add $1"); then
  echo false;
  return;
 fi

 local after=$(unstaged);
 
 if [ $1 != . ]; then
  staged=$(($before - $after));
 else
  staged=$before;
 fi
 
 # prompt user that no files were staged
 if $(isZero $staged); then
  prompt $telescope "Could not find $(targetType $target)";
  echo false;
 else
  $(status-list true);
  prompt $package "Bundled **$staged.. file$(pluralize $staged) to package ##($(staged)/$(changes))..";
  echo true;
 fi 
}

# stage all changed files
stage-all() {
 if $(noArguments $@); then
  $(stage .);
 else
  invalid;
 fi
}