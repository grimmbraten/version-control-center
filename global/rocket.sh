# return ahead count of working/passed local/remote branch
rocket-size() {
 local branch=$(working-branch);

 if [ -z $1 ]; then
  branch=$1;
 fi

 if $(remote-branch-exists $branch); then
  echo $(local-ahead-of-remote $branch);
 else
  echo $(local-ahead-of-master $branch);
 fi
}

# return unique name of rocket for working branch
rocket-name() {
 # TODO: Implement this feature
}