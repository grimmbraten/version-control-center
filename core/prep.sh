prep() {
 if [ ! -d .git ]; then
  invalid;
  return;
 fi

 spacer;
 $($@);
 spacer;
}