# Init configs
Run config init script in the folder scripts/init
```bash
cd scripts/init && bash init_configs.sh
```
This will prompt you for a backup of your current config directory (if it can be found), which you can set using the _config_directory_ variable (defaults to ~/config_test for safety reasons ;)). After the backup the script will symlink all folders in this repo to your config directory and run any scripts in scripts/init (except those defined in variables _ignored_directories_ and _ignored_scripts_ respectively). *RUN AT YOUR OWN RISK! I TAKE NO RESPONSIBILITY FOR LOST FILES!*
