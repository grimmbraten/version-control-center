# check if passed branch exists locally
local-branch-exists() {
 if [ -n "$(git show-ref refs/heads/$1)" ]; then;
  echo true;
 else
  echo false;
 fi
}

# check if working/passed local branch is ahead of its remote origin
local-ahead-of-remote() {
 local branch=$(_get-branch $@);

 if $(remote-branch-exists $branch) && ! $(isEmpty $branch); then
  echo $(git rev-list --right-only --count origin/$branch...$branch);
 else
  echo 0;
 fi
}

# check if working/passed local branch is behind its remote origin
local-behind-remote() {
 local branch=$(_get-branch $@);

 if $(remote-branch-exists $branch) && ! $(isEmpty $branch); then
  echo $(git rev-list --left-only --count origin/$branch...$branch);
 else
  echo 0;
 fi
}

# check if working/passed local branch is ahead of remote master
local-ahead-of-master() {
 local branch=$(_get-branch $@);

 if $(remote-branch-exists master) && ! $(isEmpty $branch); then
  echo $(git rev-list --right-only --count origin/master...$branch);
 else
  echo 0;
 fi
}

# check if working/passed local branch is behind remote master
local-behind-master() {
 local branch=$(_get-branch $@);

 if $(remote-branch-exists master) && ! $(isEmpty $branch); then
  echo $(git rev-list --left-only --count origin/master...$branch);
 else
  echo 0;
 fi
}