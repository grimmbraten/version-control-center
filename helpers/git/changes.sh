leafs() {
 local staged=$(bundled-leafs);
 local unstaged=$(unbundled-leafs);

 echo $(($staged + $unstaged));
}

bundled-leafs() {
 echo $(trim $(git diff --cached --numstat | wc -l));
}

unbundled-leafs() {
 echo $(trim $(git ls-files --modified --others --exclude-standard | wc -l));
}

has-leafs() {
 local staged=$(bundled-leafs);
 local unstaged=$(unbundled-leafs);

 local changes=$(($staged + $unstaged));
 if [ $changes -gt 0 ]; then
  echo true;
 else
  echo false;
 fi
}