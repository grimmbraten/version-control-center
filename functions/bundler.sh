local dir=$(dirname "$0");

# dependencies (none)
. $dir/unstage.sh
. $dir/status.sh

. $dir/fetch.sh
. $dir/merge.sh
. $dir/stage.sh
. $dir/logs.sh

. $dir/push/origin.sh
. $dir/push/upstream.sh

. $dir/reset/hard.sh
. $dir/reset/tracked.sh
. $dir/reset/untracked.sh

. $dir/stash/apply.sh
. $dir/stash/drop.sh
. $dir/stash/list.sh
. $dir/stash/save.sh

# dependencies (fetch)
. $dir/pull.sh

# dependencies (stash, stash)
. $dir/checkout/branch.sh
. $dir/checkout/master.sh
. $dir/checkout/new.sh
. $dir/checkout/previous.sh

# dependencies (checkout, push)
. $dir/branch/delete.sh
. $dir/branch/local.sh
. $dir/branch/remote.sh
. $dir/branch/rename.sh

# dependencies (stage, unstage, push)
. $dir/commit/changes.sh
. $dir/commit/push.sh
. $dir/commit/rename.sh
. $dir/commit/undo.sh