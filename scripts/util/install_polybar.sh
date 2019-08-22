# libxcb dependencies
sudo apt-get install \
	libxcb1-dev \
	libxcb-util0-dev \
	libxcb-randr0-dev \
	libxcb-composite0-dev

# xcb-proto dependencies
sudo apt-get install \
	python-xcbgen \
	xcb-proto

# xcb-util-image dependencies
sudo apt-get install bxcb-image0-dev	

# xcb-util-wm dependencies
sudo apt-get install \
	libxcb-ewmh-dev \
	libxcb-icccm4-dev

# Build the source
mkdir build && \
	cd build && \
	cmake .. && \
	make -j$(nproc) && \
	sudo make install && \
	make userconfig
