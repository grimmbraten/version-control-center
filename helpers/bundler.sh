local dir=$(dirname "$0");

# determine if the check should be against the current or a provided branch
_get-plant() {
 if [ -z $1 ]; then
  echo $(growing-plant);
 else
  if $(local-exists $1); then
   echo $1;
  else
   echo  "";
  fi
 fi
}

. $dir/git/changes.sh
. $dir/git/identity.sh
. $dir/git/local.sh
. $dir/git/remote.sh
. $dir/git/repository.sh
. $dir/git/stash.sh

. $dir/formatters.sh
. $dir/validators.sh



