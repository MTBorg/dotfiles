cd ..
directories=$(ls -d */ | sed 's/\///')

# Directories to ignore, any directory names placed in this array won't be symlinked.
# Useful if some configs don't go into directory $config_directory.
ignored_directories=( 
	"bash" 
	"sudo"
	"util_scripts"
	"init_scripts"
	"z"
	"packagelists"
)

# The directory in which to place the symlinks.
config_directory=~/config_test/

# Make sure the config directory actually exists
echo "Creating config directory $config_directory"
mkdir -p $config_directory

echo "Symlinking configs..."
for directory in $directories
do
	for ignored_directory in "${ignored_directories[@]}"
	do
	ignored=false
		if [ "$directory" == "$ignored_directory" ]
		then
			echo "Ignoring directory $ignored_directory" 
			ignored=true
			break
		fi
	done

	if [ $ignored = false ]
	then
		symTarget=$(pwd)/$directory
		echo "Initializing directory $symTarget"
		ln -s -f $symTarget $config_directory
	fi
done
