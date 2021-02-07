set -v

PROFILE_PATH=./archlive
BUILD_DIR=./build
WORK_DIR=$BUILD_DIR/work

# Clear any previously builds
sudo rm -rf $PROFILE_PATH $BUILD_DIR $WORK_DIR

cp -r /usr/share/archiso/configs/baseline/ $PROFILE_PATH && \
	cp install.sh $PROFILE_PATH/airootfs && \

# Copy autologin.conf to airootfs.
# autologin.conf makes the ISO automatically login as root
mkdir -p $PROFILE_PATH/airootfs/etc/systemd/system/getty@tty1.service.d && \
	cp autologin.conf $PROFILE_PATH/airootfs/etc/systemd/system/getty@tty1.service.d/

echo parted >> $PROFILE_PATH/packages.x86_64

# Build the ISO
mkdir -p $WORK_DIR && \
	sudo mkarchiso -v -w $WORK_DIR -o $BUILD_DIR/iso/ $PROFILE_PATH && \
	echo ISO built successfully
