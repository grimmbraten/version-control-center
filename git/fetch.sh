fetch() {
 if [ ! -z $1 ]; then
  invalid "gf";
 else
  $(runFetchRequest true);
 fi
}   

runFetchRequest() {
 local output=$1;

 if ! $(run "git fetch -p"); then
  echo false;
  return;
 fi

 prompt $tada "Development environment is now synchronize with tracked destination" $output;
 echo true;
}