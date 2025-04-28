
function debdl() {
    PACKAGES=$@
    PACKAGES_HASH=$(echo $@ | sha256sum | cut -c1-16)
    TMPDIR=$(mktemp -d)

    pushd $TMPDIR 2>&1 >/dev/null

    # downloading
    apt -s reinstall --no-install-recommends $PACKAGES | ~/scripts/depends_finder.py > deps.txt
    xargs -a deps.txt -r apt download

    # compressing
    tar_name="debs-${PACKAGES_HASH}.tar.gz"
    tar czf $tar_name *
    
    popd 2>&1 >/dev/null

    mv $TMPDIR/$tar_name ./
    rm -r $TMPDIR/
}

debdl "$@"