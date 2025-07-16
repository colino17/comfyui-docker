# SOFTWARE VERSION VARIABLES
ARG COMFYUI_VERSION=v0.3.44
ARG COMFYUI_MANAGER_VERSION=3.33.8
ARG PYTORCH_VERSION=2.7.1-cuda12.8-cudnn9-runtime

# BASE IMAGE (INCLUDES CUDA)
FROM pytorch/pytorch:${PYTORCH_VERSION}

# INSTALL BASE PACKAGES
RUN apt update --assume-yes && \
    apt install --assume-yes \
        git \
        sudo \
        libgl1-mesa-glx \
        libglib2.0-0 && \
    rm -rf /var/lib/apt/lists/*

# INSTALL COMFYUI
RUN git clone --depth=1 https://github.com/comfyanonymous/ComfyUI.git /opt/comfyui && \
    cd /opt/comfyui && \
    git fetch origin ${COMFYUI_VERSION} && \
    git checkout FETCH_HEAD

# INSTALL COMFYUI MANAGER
RUN git clone --depth=1 https://github.com/Comfy-Org/ComfyUI-Manager.git /opt/comfyui-manager && \
    cd /opt/comfyui-manager && \
    git fetch origin ${COMFYUI_MANAGER_VERSION} && \
    git checkout FETCH_HEAD

# INSTALL DEPENDENCIES
RUN pip install \
    --requirement /opt/comfyui/requirements.txt \
    --requirement /opt/comfyui-manager/requirements.txt

# SET WORKING DIRECTORY
WORKDIR /opt/comfyui

# EXPOSE PORT
EXPOSE 8188

# STARTUP SCRIPT
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

# APPLICATION COMMAND
CMD ["/opt/conda/bin/python", "main.py", "--listen", "0.0.0.0", "--port", "8188", "--disable-auto-launch"]
