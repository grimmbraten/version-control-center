# returns the total count of saved stashes
stash-count() {
 echo $(trim $(git stash list | wc -l));
}

# returns stash index if a existing stash matches the entered search query
find-stash-by-name() {
 echo $(git stash list | grep -w "$1" | cut -d: -f1);
}