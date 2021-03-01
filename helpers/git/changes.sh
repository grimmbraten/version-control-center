# returns the total count of local changes
changes() {
 local staged=$(staged);
 local unstaged=$(unstaged);

 echo $(($staged + $unstaged));
}

# returns total count of staged local changes
staged() {
 echo $(trim $(git diff --cached --numstat | wc -l));
}

# returns total count of unstaged local changes
unstaged() {
 echo $(trim $(git ls-files --modified --others --exclude-standard | wc -l));
}

# returns true if local branch has any changes
has-changes() {
 local staged=$(staged);
 local unstaged=$(unstaged);

 local changes=$(($staged + $unstaged));
 if [ $changes -gt 0 ]; then
  echo true;
 else
  echo false;
 fi
}

# returns true if local branch has staged changes
has-staged() {
 if [ $(staged) -gt 0 ]; then
  echo true;
 else
  echo false;
 fi
}

# returns true if local branch has unstaged changes
has-unstaged() {
 if [ $(unstaged) -gt 0 ]; then
  echo true;
 else
  echo false;
 fi
}