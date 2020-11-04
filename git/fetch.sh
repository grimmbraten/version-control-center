fetch() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "gf";
 else
  $(runFetchRequest true);
 fi

 spacer;
}   

# $1: boolean (verbose)
runFetchRequest() {
 if ! $(run "git fetch -p"); then
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully synchronized references" $1;
 echo true;
}