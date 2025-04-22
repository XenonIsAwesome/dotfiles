
function debdl() {
    tmpdir=$(mktemp -d)
    workdir=$(mktemp -d)

    PACKAGES_HASH=$(echo "$@" | sha256sum | cut -c1-16)

    # moving old debs to tmp
    sudo mv /var/cache/apt/archives/*.deb $tmpdir 2>/dev/null || true

    # moving new debs to workdir
    sudo apt-get reinstall -y --download-only "$@"
    sudo mv /var/cache/apt/archives/*.deb $workdir
    
    # moving old debs back to archives
    sudo mv $tmpdir/*.deb /var/cache/apt/archives/ 2>/dev/null || true
    
    # making tar
    pushd $workdir 2>&1 >/dev/null
    tar czf "debs-${PACKAGES_HASH}.tar.gz" *.deb
    popd 2>&1 >/dev/null

    # moving tar to cwd
    mv "${workdir}/debs-${PACKAGES_HASH}.tar.gz" ./
}

debdl "$@"