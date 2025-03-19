# **Docker Project Deployment on SAP BTP Using WSL**

This project demonstrates how to **set up a Dockerized Flask application**, push it to **GitHub**, and deploy it on **SAP Business Technology Platform (BTP)** using **WSL (Windows Subsystem for Linux)**.

---

## **Prerequisites**
- **Windows 10/11** with **WSL 2** installed
- **Docker Desktop** with **WSL integration enabled**
- **GitHub Account**
- **SAP BTP Account** with Cloud Foundry enabled
- **Docker Hub Account**
- **Cloud Foundry CLI** installed in WSL

---

## **Setup Steps**

### **1️⃣ Install & Set Up WSL with Docker**
1. Install WSL 2:
   ```powershell
   wsl --install
   ```
2. Enable Docker WSL Integration:
   - Open **Docker Desktop** → **Settings** → **Resources** → **WSL Integration**
   - Enable it for your WSL distribution (e.g., Ubuntu).

3. Install necessary dependencies inside WSL:
   ```bash
   sudo apt update -y
   sudo apt install git -y
   sudo apt install docker.io -y
   ```

4. Configure Docker in WSL:
   ```bash
   sudo nano /etc/wsl.conf
   ```
   Add the following lines:
   ```ini
   [boot]
   systemd=true
   ```
   Then restart WSL:
   ```bash
   exit
   wsl --shutdown
   wsl
   ```

5. Verify systemd is running:
   ```bash
   systemctl --no-pager status user.slice > /dev/null 2>&1 && echo 'OK: Systemd is running' || echo 'FAIL: Systemd not running'
   ```

---

### **2️⃣ Clone or Initialize the Project**
```bash
cd ~
git clone https://github.com/kniteshsri/DockerLearning.git
cd DockerLearning/
git checkout main
```

---

### **3️⃣ Build & Run Docker Locally**
1. **Build the Docker Image**:
   ```bash
   docker build -t docker-learning .
   ```
2. **Run the Container**:
   ```bash
   docker run -p 8080:8080 docker-learning
   ```
3. **Test the Application**:
   - Open a browser and go to: `http://localhost:8080`

---

### **4️⃣ Deploy to SAP BTP**
1. **Install Cloud Foundry CLI in WSL**:
   ```bash
   wget -O cf-cli.deb "https://packages.cloudfoundry.org/stable?release=debian64&version=v8&source=github"
   sudo dpkg -i cf-cli.deb
   cf --version
   ```

2. **Login to SAP BTP**:
   ```bash
   cf login -a https://api.cf.us10-001.hana.ondemand.com
   ```

3. **Push the Docker Image to Docker Hub**:
   ```bash
   docker login -u kniteshsri001
   docker tag docker-learning kniteshsri001/docker-learning:latest
   docker push kniteshsri001/docker-learning:latest
   ```

4. **Deploy to SAP BTP**:
   ```bash
   cf push
   ```

---

## **5️⃣ Automate Deployment with GitHub Actions**
To automate the deployment process, create a **GitHub Actions workflow**:

1. Create a `.github/workflows/deploy.yml` file in your repository.
2. Add the following content:
   ```yaml
   name: Deploy to SAP BTP

   on:
     push:
       branches:
         - main

   jobs:
     deploy:
       runs-on: ubuntu-latest

       steps:
         - name: Checkout Repository
           uses: actions/checkout@v3

         - name: Set Up Cloud Foundry CLI
           run: |
             wget -O cf-cli.deb "https://packages.cloudfoundry.org/stable?release=debian64&version=v8&source=github"
             sudo dpkg -i cf-cli.deb
             cf --version

         - name: Log in to Cloud Foundry
           run: |
             cf login -a https://api.cf.us10-001.hana.ondemand.com -u ${{ secrets.CF_USERNAME }} -p ${{ secrets.CF_PASSWORD }}

         - name: Deploy to SAP BTP
           run: cf push
   ```
3. Add the following **secrets** in **GitHub Repository → Settings → Secrets and variables → Actions**:
   - `CF_USERNAME`: Your SAP BTP username
   - `CF_PASSWORD`: Your SAP BTP password

Once this workflow is added, every push to the **main** branch will **automatically deploy** the application to SAP BTP. 🚀

---

## **6️⃣ Linux Commands Reference**
These are the key **WSL Linux commands** used in the process:
```bash
sudo apt update -y
sudo apt install git -y
git clone https://github.com/kniteshsri/DockerLearning.git
cd DockerLearning/
git checkout main
docker build -t my-docker-app .
sudo apt install docker.io
sudo nano /etc/wsl.conf
systemctl --no-pager status user.slice > /dev/null 2>&1 && echo 'OK: Systemd is running' || echo 'FAIL: Systemd not running'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-compose-plugin
sudo ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/bin/docker-compose
sudo usermod -aG docker $USER
exit
docker run --rm -it hello-world
docker ps
cd DockerLearning/
docker build -t docker-learning .
docker run -p 8080:8080 docker-learning
docker ps -a
wget -O cf-cli.deb "https://packages.cloudfoundry.org/stable?release=debian64&version=v8&source=github"
sudo dpkg -i cf-cli.deb
cf --version
cf login -a https://api.cf.us10-001.hana.ondemand.com
git pull
docker login
docker tag docker-learning kniteshsri001/docker-learning:latest
docker push kniteshsri001/docker-learning:latest
cf push
```

---

## **🎯 Summary**
✔ Installed **WSL & Docker**
✔ Cloned the **GitHub project**
✔ Built & ran the **Docker container** inside WSL
✔ Pushed to **Docker Hub**
✔ Deployed to **SAP BTP using Cloud Foundry**
✔ **Automated deployment using GitHub Actions** 🚀

