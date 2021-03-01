local dir=$(dirname "$0");

. $dir/git;

. $dir/formatters.sh;
. $dir/validators.sh;

# determine if the check should be against the current or a provided branch
_get-branch() {
 if [ -z $1 ]; then
  echo $(working-branch);
 else
  if $(local-branch-exists $1); then
   echo $1;
  else
   echo  "";
  fi
 fi
}