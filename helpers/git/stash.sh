# returns total count of saved stashes
stashes() {
 echo $(trim $(git stash list | wc -l));
}

# returns stash index of found stash from passed search query
find-stash-by-name() {
 echo $(git stash list | grep -w "$1" | cut -d: -f1);
}