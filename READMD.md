## QuickStart
### Clone and unzip 
```shell
git clone ... 
7z x config/home/ryukk/.tmux.7z -oconfig/home/ryukk/.tmux
7z x config/home/ryukk/.config/zim.7z -oconfig/home/ryukk/.config/zim

```

### Set the network proxy 

```shell
cat >> /etc/systemd/system/docker.service.d/proxy.conf <<EOF
[Service]
Environment="HTTP_PROXY=http://127.0.0.1:7890"
Environment="HTTPS_PROXY=http://127.0.0.1:7890"
Environment="NO_PROXY=localhost,127.0.0.1"
EOF
```

## cuda env setup
[Ref setup-nvidia-gpu-for-docker](https://www.gravee.dev/en/setup-nvidia-gpu-for-docker)

### Install nvidia deriver 
... Verify

```bash 
nvidia-smi
```

### Conf nvidia docker env
Add the Nvidia Container repos to apt

```bash
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
 && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
 sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
 sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
```

Install the Nvidia Container Toolkit from apt

```bash
sudo apt update
sudo apt install nvidia-container-toolkit -y
```

Configure Docker to use the toolkit

```bash
sudo nvidia-ctk runtime configure --runtime=docker
```

Restart docker

```bash
sudo systemctl restart docker
```

Verify Docker can use the GPU

```bash
sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
```

### BUILD

```shell
docker build \                           
    --build-arg HTTP_PROXY="http://127.0.0.1:7890" \
    --build-arg HTTPS_PROXY="http://127.0.0.1:7890" \
    -t zhiqiangz-dev \
    --network host \
    .
``` 