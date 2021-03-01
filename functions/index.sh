local dir=$(dirname "$0");

# dependencies (none)
. $dir/unstage.sh;
. $dir/status.sh;

. $dir/fetch.sh;
. $dir/merge.sh;
. $dir/stage.sh;
. $dir/logs.sh;

. $dir/push;

. $dir/reset;

. $dir/stash;

# dependencies (fetch)
. $dir/pull.sh;

# dependencies (stash, stash)
. $dir/checkout;

# dependencies (checkout, push)
. $dir/branch;

# dependencies (stage, unstage, push)
. $dir/commit;