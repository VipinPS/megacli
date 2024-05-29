FROM registry.access.redhat.com/ubi9/ubi

# Update and install required packages
RUN dnf -y update && \
    dnf -y install unzip ncurses

# Verify and create symbolic link for libncurses
RUN ls -al /usr/lib64/libncurses.so.6 && \
    ln -sf /usr/lib64/libncurses.so.6 /usr/lib64/libncurses.so.5

# Set the working directory
WORKDIR /usr/local/src

# Download MegaCLI
RUN   curl -O https://docs.broadcom.com/docs-and-downloads/raid-controllers/raid-controllers-common-files/8-04-07_MegaCLI.zip

# Unzip downloaded files
RUN unzip 8-04-07_MegaCLI.zip && \
    unzip CLI_Lin_8.04.07.zip && \
    unzip MegaCliLin.zip

# Install the RPM package
RUN dnf -y install MegaCli-8.04.07-1.noarch.rpm Lib_Utils-1.00-09.noarch.rpm

# Set the path for MegaCLI
ENV PATH="/opt/MegaRAID/MegaCli:$PATH"

# Default command
CMD ["/bin/bash"]
