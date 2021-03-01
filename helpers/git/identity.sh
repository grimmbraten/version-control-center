# returns name of the working branch
working-branch() {
 echo $(git branch --show-current);
}

# returns branch hash for working/passed locale branch
branch-hash() {
 if [ -z $1 ]; then
  echo $(git rev-parse --short HEAD);
 else
  echo $(git rev-parse --short $1);
 fi
}

# returns branch hash for working/passed remote branch
remote-branch-hash() {
 if [ -z $1 ]; then
  echo $(git rev-parse --short origin/$(working-branch));
 else
  echo $(git rev-parse --short origin/$1);
 fi
}

# returns branch hash for remote master branch
repository-hash() {
 echo $(git rev-parse --short origin/master);
}
