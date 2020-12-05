#TODO, this is now broken, investigate how to split a string with whitespace and take correct value from line
addEmoji() { 
 local type=$(split $1 ":" 1);
 local description=$(split $1 ":" 2);

 if [ $type != $description ]; then
  while read line; do
   if $(contains $line $type); then
    echo "$(split $(split $line "-" 1) " " 2) $(trim $description)";
    return;
   fi
  done <$types/commit.txt
 fi

 echo "";
}

getEmojiForConsole() {
 local type=$(split $1 ":" 1);

 while read line; do
  if $(contains $line $type); then
   echo "\\$(split $line "-" 2)";
   return;
  fi
 done <$types/commit.txt

 echo $bookmarkIcon;
}