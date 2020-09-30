fetch() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "gf";
 else
  $(runFetchRequest true);
 fi

 spacer;
}   

runFetchRequest() {
 local verbose=$1;

 if ! $(run "git fetch -p"); then
  echo false;
  return;
 fi

 prompt $tada "Development environment is now synchronize with tracked destination" $verbose;
 echo true;
}