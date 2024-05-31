# Azure Spark-Cluster Job


### Architecture

![](assets/Sparkcluster_architecture.png)



## 🛠 How to run the Spark-Job on Azure
1. **Azure VM**: Ensure you have an active Azure account and have an working Azure VM (Ubuntu OS).
2. **Upload Files on running Azure VM**:
    - Download `.pem` (private key) for your Azure VM.
    - Set the following the following env variables and run the `upload_files.sh` script:

```bash

export IDENTITY_FILE='spark-clusters_key.pem' # your .pem file path
export REMOTE_USER='azureuser' # Your User on VM
export REMOTE_HOST='20.83.161.61' # VM IP
chmod 400 $IDENTITY_FILE
chmod +x upload_files.sh
./upload_files.sh
```

3. Run the Job on Azure VM

- SSH into your VM

```bash
ssh -X $REMOTE_USER@$REMOTE_HOST -i $IDENTITY_FILE
```

- Dowload docker on Azure VM

```bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

- Start Docker-Compose

```bash

docker-compose up -d --build

```

- Start the Job

```bash

docker exec -it spark-master spark-submit --master spark://spark-master:7077 jobs/main.py

```

- Exit out of SSH Session

4. Download the Output on Local Machine

- Run the `download_files.sh` script on local machine to get the final output in the folder `src/output`

```bash
chmod +x download.sh
./upload_files.sh
```

