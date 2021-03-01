local dir=$(dirname "$0");

. $dir/delete.sh;
. $dir/local.sh;
. $dir/remote.sh;
. $dir/rename.sh;

# prompt the user that the master branch is always protected
protected-branch() {
 if [ $1 = master ]; then
  protected "master";
  echo false;
 else
  echo true;
 fi
}