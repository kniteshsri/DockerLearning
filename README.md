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

3. Verify Docker installation inside WSL:
   ```bash
   docker --version
   ```

---

### **2️⃣ Clone or Initialize the Project**
```bash
mkdir my-docker-app
cd my-docker-app
```

---

### **3️⃣ Create a Simple Flask App**
1. **Create `app.py`**:
   ```python
   from flask import Flask

   app = Flask(__name__)

   @app.route("/")
   def home():
       return "Hello, SAP BTP from Docker on WSL!"

   if __name__ == "__main__":
       app.run(host="0.0.0.0", port=8080)
   ```

2. **Create `requirements.txt`**:
   ```txt
   flask
   ```

3. **Create `Dockerfile`**:
   ```dockerfile
   FROM python:3.9
   WORKDIR /app
   COPY . .
   RUN pip install -r requirements.txt
   CMD ["python", "app.py"]
   ```

4. **Create `.dockerignore`**:
   ```txt
   __pycache__/
   *.pyc
   *.pyo
   ```

---

### **4️⃣ Push the Project to GitHub**
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/my-docker-app.git
git push -u origin main
```

---

### **5️⃣ Build & Run Docker Locally**
1. **Build the Docker Image**:
   ```bash
   docker build -t my-docker-app .
   ```
2. **Run the Container**:
   ```bash
   docker run -p 8080:8080 my-docker-app
   ```
3. **Test the Application**:
   - Open a browser and go to: `http://localhost:8080`

---

### **6️⃣ Deploy to SAP BTP**
1. **Install Cloud Foundry CLI in WSL**:
   ```bash
   wget -O cf-cli.deb "https://packages.cloudfoundry.org/stable?release=debian64&version=v8&source=github"
   sudo dpkg -i cf-cli.deb
   cf --version
   ```

2. **Login to SAP BTP**:
   ```bash
   cf login -a https://api.cf.eu10.hana.ondemand.com -u YOUR_USERNAME -p YOUR_PASSWORD
   ```
   *(Replace `eu10` with your SAP BTP region.)*

3. **Create `manifest.yml`**:
   ```yaml
   applications:
     - name: my-docker-app
       memory: 256M
       instances: 1
       docker:
         image: YOUR_DOCKERHUB_USERNAME/my-docker-app:latest
   ```

4. **Push the Docker Image to Docker Hub**:
   ```bash
   docker login
   docker tag my-docker-app YOUR_DOCKERHUB_USERNAME/my-docker-app:latest
   docker push YOUR_DOCKERHUB_USERNAME/my-docker-app:latest
   ```

5. **Deploy to SAP BTP**:
   ```bash
   cf push
   ```

---

## **7️⃣ Automate Deployment with GitHub Actions**
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
             cf login -a https://api.cf.eu10.hana.ondemand.com -u ${{ secrets.CF_USERNAME }} -p ${{ secrets.CF_PASSWORD }}

         - name: Deploy to SAP BTP
           run: cf push
   ```
3. Add the following **secrets** in **GitHub Repository → Settings → Secrets and variables → Actions**:
   - `CF_USERNAME`: Your SAP BTP username
   - `CF_PASSWORD`: Your SAP BTP password

Once this workflow is added, every push to the **main** branch will **automatically deploy** the application to SAP BTP. 🚀

---

## **8️⃣ Access the Application**
Once deployed, SAP BTP provides a **URL**, such as:
```
https://my-docker-app.cfapps.eu10.hana.ondemand.com
```
Visit the URL to see your running **Docker app on SAP BTP via WSL**! 🎉

---

## **🎯 Summary**
✔ Installed **WSL & Docker**
✔ Created a **Flask app** inside **WSL**
✔ Pushed the project to **GitHub**
✔ Built & ran the **Docker container** inside WSL
✔ Pushed to **Docker Hub**
✔ Deployed to **SAP BTP using Cloud Foundry**
✔ **Automated deployment using GitHub Actions** 🚀

