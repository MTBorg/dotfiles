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
backup_directory=~/config_backup/

# Backup the current config
if [ -d $config_directory ]; then
	if [ -d $backup_directory ]; then
		echo "Backup directory $backup_directory already exists. Overwrite?(y/n)"
		read input
		if [ $input == "y" ]; then
			echo "Overwriting backup"
			echo "Creating backup of existing config directory $config_directory"
			test=$(sudo cp -rf $config_directory $backup_directory)
		elif [ $input == "n" ]; then
			echo "Skipping overwriting backup, exiting..."
			exit 1
		else
			echo "Received invalid input $input, exiting..."
			exit 1
		fi
	else
		echo "Creating backup of existing config directory $config_directory"
		test=$(sudo cp -rf $config_directory $backup_directory)
	fi
else
	echo "Could not find folder $config_directory. Skip backup and continue?(y/n)"
	read input
	if [ $input == "y" ]; then
		echo "Skipping backup..."
	elif [ $input == "n" ]; then
		echo "Won't skip backup, exiting..."
		exit 1
	else
		echo "Received invalid input $input, exiting..."
		exit 1
	fi
fi

cd ..
directories=$(ls -d */ | sed 's/\///')

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
