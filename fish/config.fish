alias ll "ls -al"

if type -q git
	alias g "git"
end

if test /etc/arch-release
	alias p "pacman"
	alias sysstart="systemctl start"
	alias sysstop="systemctl stop"
	alias sysstat="systemctl status"
	alias sysenable="systemctl enable"
	alias sysdisable="systemctl disable"
end

if type -q bat
	alias cat "bat"
end
