#!/usr/bin/env python3

import sys

version = sys.argv[1].lower() if len(sys.argv) > 1 else ""
version_map = {
    "20.04": "focal", "20.04.6": "focal", "20.04lts": "focal",
    "22.04": "jammy", "22.04.4": "jammy", "22.04lts": "jammy",
    "23.10": "mantic", "24.04": "noble", "24.04lts": "noble",
}

# Support both numeric and codenames
if version in version_map:
    print(version_map[version])
elif version in version_map.values():
    print(version)
else:
    try:
        import distro
        print(distro.linux_distribution(full_distribution_name=False)[2])
    except ImportError:
        print("unknown")
