# Count the number of a package's dependencies, i.e. the number of entries 
# (words) in the field "Depends On" using pacman -Q <package>.
# E.g.: If depends on only b, c and d then pacscountd a returns 3
function pacscountd() {
	pacman -Qi $1 | sed -n "s/^Depends On[[:space:]]\{0,\}:// p" | wc -w
}

# Count the number of packages requiring a given package, i.e. the number of
# entries (words) in the field "Required By" using pacman -Q <package>.
# E.g.: If a is required by only b and c then pacscountr a returns 2
function pacscountr() {
	pacman -Qi $1 | sed -n "s/^Required By[[:space:]]\{0,\}:// p" | wc -w
}
