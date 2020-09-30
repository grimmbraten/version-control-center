local dir=$(dirname "$0");

# dependencies (none)
. $dir/status.sh
. $dir/reset.sh
. $dir/fetch.sh
. $dir/stash.sh
. $dir/push.sh
. $dir/logs.sh

# dependencies (status)
. $dir/stage.sh
. $dir/unstage.sh

# dependencies (fetch)
. $dir/merge.sh
. $dir/pull.sh

# dependencies (stash)
. $dir/checkout.sh

# dependencies (push)
. $dir/branch.sh

# dependencies (stage, unstage, push)
. $dir/commit.sh