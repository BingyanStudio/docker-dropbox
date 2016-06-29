#!/usr/bin/env sh

has_gid () {
    cut -d: -f1,4 /etc/passwd | grep -q "^${1}:${2}" || return 1
}

# example: ensure_user btsync 1000 1000
ensure_user () {
    local user=$1
    local uid=$2
    local gid=$3
    local group_prefix=${4:-_}

    {
        deluser $user
        delgroup $user
        delgroup $group_prefix$user
    } 2>/dev/null

    adduser -h / -s /bin/sh -D -u $uid $user
    has_gid $user $gid || {
        addgroup -g $gid $group_prefix$user
        sed -i 's/^\('$user'\(:[^:]\{1,\}\)\{2\}\):[0-9]\{1,\}/\1:'$gid/ /etc/passwd
    }

}

ensure_user dropbox $UID $GID

chown -R $UID:$GID /.dropbox-dist /Dropbox

exec su dropbox -c "exec $*"
