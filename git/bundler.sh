local dir=$(dirname "$0");

# dependencies (none)
. $dir/unstage.sh
. $dir/status.sh
. $dir/reset.sh
. $dir/fetch.sh
. $dir/stash.sh
. $dir/merge.sh
. $dir/stage.sh
. $dir/push.sh
. $dir/logs.sh

# dependencies (fetch)
. $dir/pull.sh

# dependencies (stash, stash)
. $dir/checkout.sh

# dependencies (checkout, push)
. $dir/branch.sh

# dependencies (stage, unstage, push)
. $dir/commit.sh