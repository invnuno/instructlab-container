# Build your own Container image with InstructLab
This repository contains the Containerfile to build a Container image using Podman with the necessary environment and dependencies to run InstructLab's AI models.

## 1. Build it
To build the Docker image, run the following command:

```bash
podman build -t instructlab:latest -f Containerfile .
```

## 2. Run it
```bash
podman run -d --name instructlab -p 8000:8000 instructlab:latest ilab model serve
```

# References
[InstructLab website](https://instructlab.ai/)

[InstructLab GitHub](https://github.com/instructlab)