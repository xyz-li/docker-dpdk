FROM ubuntu

LABEL RUN docker run -it --privileged -v /sys/bus/pci/devices:/sys/bus/pci/devices -v /sys/kernel/mm/hugepages:/sys/kernel/mm/hugepages -v /sys/devices/system/node:/sys/devices/system/node -v /dev:/dev --name NAME -e NAME=NAME -e IMAGE=IMAGE IMAGE

# Setup yum repos, or use subscription-manager

# Install DPDK support packages.
RUN apt-get update && DEBIAN_FRONTEND=noninteractiv apt-get  install -y libhugetlbfs-dev  libpcap-dev curl gcc xz-utils meson ninja-build python3-pyelftools iproute2 make pkg-config

# Build DPDK and pktgen-dpdk for x86_64-native-linuxapp-gcc.
WORKDIR /root
COPY ./build_dpdk.sh /root/build_dpdk.sh
COPY ./dpdk-profile.sh /etc/profile.d/
RUN /root/build_dpdk.sh

ENV  LD_LIBRARY_PATH /usr/local/lib64
# Defaults to a bash shell, you could put your DPDK-based application here.
CMD ["/usr/bin/bash"]
