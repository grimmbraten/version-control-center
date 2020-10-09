onBranch() {
 echo $(git branch --show-current);
}

localAheadCount() {
 if [ -z $1 ]; then
  echo $(git rev-list --right-only --count origin/$(onBranch)...$(onBranch));
 elif $(hasBranch $1); then
  echo $(git rev-list --right-only --count $1...$(onBranch));
 else
  echo 0;
 fi
}

masterAheadCount() {
 echo $(git rev-list --right-only --count $(onBranch)...origin/master);
}

originAheadCount() {
 if [ -z $1 ]; then
  echo $(git rev-list --right-only --count $(onBranch)...origin/$(onBranch));
 else
  echo 0;
 fi
}

localBehindCount() {
 if [ -z $1 ]; then
  echo $(git rev-list --left-only --count origin/$(onBranch)...$(onBranch));
 elif $(hasBranch $1); then
  echo $(git rev-list --left-only --count $1...$(onBranch));
 else
  echo 0;
 fi
}

masterBehindCount() {
 echo $(git rev-list --left-only --count $(onBranch)...origin/master);
}

originBehindCount() {
 local branch=$(onBranch);

 if $(hasRemoteBranch); then
  echo $(git rev-list --left-only --count $(onBranch)...origin/$(onBranch));
 else
  echo 0;
 fi
}

getStashIndexByName() {
 echo $(git stash list | grep -w "$1" | cut -d: -f1);
}

identity() {
 if [ -z $1 ]; then
  echo $(git rev-parse --short HEAD);
 else
  echo $(git rev-parse --short $1);
 fi
}

masterIdentity() {
 echo $(git rev-parse --short origin/master);
}

originIdentity() {
 echo $(git rev-parse --short origin/$(onBranch));
}

stagedCount() {
 echo $(trim $(git diff --cached --numstat | wc -l));
}

unstagedCount() {
 echo $(trim $(git ls-files --modified --others --exclude-standard | wc -l));
}

changeCount() {
 local staged=$(stagedCount);
 local unstaged=$(unstagedCount);

 echo $(($staged + $unstaged));
}

hasChanges() {
 local staged=$(stagedCount);
 local unstaged=$(unstagedCount);

 local changes=$(($staged + $unstaged));
 if [ $changes -gt 0 ]; then
  echo true;
 else
  echo false;
 fi
}

hasBranch() {
 if $(hasLocalBranch $1); then
  echo true;
 elif $(hasRemoteBranch $1); then
  echo true;
 else
  echo false;
 fi
}

hasLocalBranch() {
 local branch=$(onBranch);

 if [ ! -z $1 ]; then
  branch=$1;
 fi

 if [ -n "$(git show-ref refs/heads/$branch)" ]; then;
  echo true;
 else
  echo false;
 fi
}

hasRemoteBranch() {
 local branch=$(onBranch);

 if [ ! -z $1 ]; then
  branch=$1;
 fi

 if [ $(trim $(git branch -a | egrep remotes/origin/$branch | wc -l)) -eq 1 ]; then;
  echo true;
 else
  echo false;
 fi
}

hasUnstagedChanges() {
 if [ $(unstagedCount) -gt 0 ]; then
  echo true;
 else
  echo false;
 fi
}

isBehindMaster() {
 if [ $(masterBehindCount) -gt 0 ]; then
  echo true;
 else
  echo false;
 fi
}

isBehindOrigin() {
 if [ $(originBehindCount) -gt 0 ]; then
  echo true;
 else
  echo false;
 fi
}

inRepository() {
 echo $(git config --local remote.origin.url|sed -n 's#.*/\([^.]*\)\.git#\1#p');
}

repositoryUrl() {
 echo $(git config --get remote.origin.url);
}

stashCount() {
 echo $(trim $(git stash list | wc -l));
}