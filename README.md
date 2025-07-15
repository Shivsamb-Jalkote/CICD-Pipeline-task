# CICD-Pipeline-task
```markdown
# DevOps CI/CD Pipeline on AWS (EKS + Terraform + ArgoCD)

## 🎯 Objective
This project demonstrates a complete CI/CD pipeline on AWS using:
- **Terraform** for infrastructure provisioning
- **Kubernetes (EKS)** for container orchestration
- **ArgoCD** for GitOps-based deployment
- **NGINX** application as the sample workload

---

## 📁 Project Structure

```

.
├── terraform/       # Terraform code for AWS EKS
├── manifests/       # Kubernetes manifests (NGINX Deployment & Service)
├── argocd/          # ArgoCD Application YAML
└── README.md        # Project documentation

````

---

## 🔧 Step 1: Provision EKS Cluster using Terraform

### 📍 Prerequisites:
- AWS CLI configured (`aws configure`)
- Terraform installed (`v1.5+`)
- kubectl installed

### ▶️ Run Terraform

```bash
cd terraform
terraform init
terraform apply -auto-approve
````

### ✅ Outputs:

* EKS cluster provisioned
* IAM roles, node groups created
* Kubeconfig generated to access the cluster

---

## 🚀 Step 2: Deploy NGINX on EKS

### Option 1: Manual Apply

```bash
kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/service.yaml
```

### Option 2: GitOps with ArgoCD (Recommended)

---

## ⚙️ Step 3: Install and Configure ArgoCD

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### Port-forward ArgoCD UI:

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Visit [https://localhost:8080](https://localhost:8080)

### Login Credentials:

```bash
# Username: admin
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
```

---

## 📦 Step 4: Create ArgoCD Application

```bash
kubectl apply -f argocd/app.yaml
```

This will sync your `manifests/` folder to deploy NGINX.

---

## 🌐 Step 5: Access NGINX Application

### Option 1: Port Forward

```bash
kubectl port-forward svc/nginx-service 8080:80
# Then go to: http://localhost:8080
```

### Option 2: LoadBalancer (if used)

```bash
kubectl get svc nginx-service
# Access using the EXTERNAL-IP shown
```

---

## 🌍 Bonus (Optional): Ingress + DNS

1. Install Ingress Controller:

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install nginx-ingress ingress-nginx/ingress-nginx --namespace kube-system
```

2. Apply Ingress Resource:

```bash
kubectl apply -f manifests/ingress.yaml
```

3. Update DNS (e.g., Route53) to map your domain to the Ingress LoadBalancer IP.

---

## ✅ Validation

* ✅ Terraform successfully creates EKS infrastructure
* ✅ ArgoCD deploys NGINX via GitOps
* ✅ NGINX accessible via port-forward or public URL
* ✅ Clear documentation for reproduction

---

## 📝 Author

Shivsamb Jalkote – [GitHub](https://github.com/your-github-username)

```

---

Let me know:
- Your GitHub repo name (I'll update the links).
- If you'd like me to generate the Terraform, manifest, and ArgoCD files next.
```
