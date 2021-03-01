# check if passed remote branch exists
remote-branch-exists() {
 if [ $(trim $(git branch -a | egrep remotes/origin/$1 | wc -l)) -eq 1 ]; then;
  echo true;
 else
  echo false;
 fi
}

# check if working/passed remote branch is ahead of its local branch
remote-ahead-of-locale() {
 echo $(local-behind-remote $@);
}

# check if working/passed remote branch is behind of its local branch
remote-behind-of-locale() {
 echo $(local-ahead-of-remote $@);
}

# check if working/passed remote branch is ahead of remote master
remote-ahead-of-master() {
 local branch=$(_get-branch $@);

 if $(remote-branch-exists master) && ! $(isEmpty $branch); then
  echo $(git rev-list --right-only --count origin/master...origin/$branch);
 else
  echo 0;
 fi
}

# check if working/passed remote branch is behind remote master
remote-behind-master() {
 local branch=$(_get-branch $@);

 if $(remote-branch-exists master) && ! $(isEmpty $branch); then
  echo $(git rev-list --left-only --count origin/master...origin/$branch);
 else
  echo 0;
 fi
}
