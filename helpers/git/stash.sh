seeds() {
 echo $(trim $(git stash list | wc -l));
}

getSeedIndexByName() {
 echo $(git stash list | grep -w "$1" | cut -d: -f1);
}