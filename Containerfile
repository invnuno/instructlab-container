#
# FEDORA + INSTRUCTLAB
#

#
# REFERENCES
#

# Author: Nuno Carvalho - ncarvalh@redhat.com
# Project: https://github.com/invnuno/instructlab-container
# Image: https://registry.fedoraproject.org/repo/fedora/tags
# InstructLab project: https://github.com/instructlab/instructlab

# -- BUILD INSTRUCTIONS --
# 1. Clone project
# git clone https://github.com/invnuno/instructlab-container.git

# 2. Build the image:
# podman build -t instructlab:v1.0 -f Containerfile .


# +---------------------------+
# | Build process starts here |
# +---------------------------+

# -- IMAGE --
# Use the latest Fedora image
FROM fedora:40

# -- PREPARE ENVIRONMENT --
# Install dependencies
RUN dnf install -y gcc gcc-c++ make git python3.11 python3.11-devel python3-pip
RUN mkdir instructlab
WORKDIR instructlab

# Install InstructLab using PyTorch without CUDA bindings and no GPU acceleration
RUN pip install instructlab --extra-index-url=https://download.pytorch.org/whl/cpu -C cmake.args="-DLLAMA_NATIVE=off"

# Expose port 8000 for the OpenAI API
EXPOSE 8000

# -- ILAB --
# Configure ilab with default values
RUN ilab config init --non-interactive
# Download model
RUN ilab model download
# Choose an alternative model by uncomment the line below. Do NOT forget to comment the line above. See also "Notes & TIPS" to add the option whe running the container:
# RUN ilab model download --repository instructlab/granite-7b-lab-GGUF --filename=granite-7b-lab-Q4_K_M.gguf

# -- RUN CONTAINER --
# Run the container: podman run -d --restart always --name instructlab -p 8000:8000 instructlab:v1.0 ilab model serve

# +--------------+
# | NOTES & TIPS |
# +--------------+

# InstructLab ilab options
#    ilab model serve --model-path models/<your model filename>
