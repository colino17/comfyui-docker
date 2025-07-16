# Description

This is a Docker image for [ComfyUI](https://www.comfy.org/), which makes it easy to run ComfyUI using Docker Compose. The image also includes the [ComfyUI Manager](https://github.com/ltdrdata/ComfyUI-Managergithub ) extension.

## Installation

The image can be installed using the below Docker Compose yaml.

```yaml
services:
  comfyui:
    container_name: comfyui
    image: ghcr.io/colino17/comfyui-docker:latest
    restart: always
    environment:
      - USER_ID=1000
      - GROUP_ID=100
    volumes:
      - /path/to/comfyui/models:/opt/comfyui/models:rw
      - /path/to/comfyui/nodes:/opt/comfyui/custom_nodes:rw
      - /path/to/comfyui/input:/opt/comfyui/input:rw
      - /path/to/comfyui/output:/opt/comfyui/output:rw
    ports:
      - 8188:8188
    deploy:
      resources:
        reservations:
          devices:
            - driver: cdi
              device_ids:
                - nvidia.com/gpu=0
              capabilities:
                - gpu

```

## License and Attribution

This image is forked from [https://github.com/lecode-official/comfyui-docker](https://github.com/lecode-official/comfyui-docker).

The ComfyUI Docker image is licensed under the [MIT License](LICENSE). [ComfyUI](https://github.com/comfyanonymous/ComfyUI/blob/master/LICENSE) and the [ComfyUI Manager](https://github.com/ltdrdata/ComfyUI-Manager/blob/main/LICENSE.txt) are both licensed under the GPL 3.0 license.
