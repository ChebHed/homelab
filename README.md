# Homelab File Handler - Learning Project

A complete homelab setup to learn Docker, Kubernetes, Ansible, and AWS with a real file sharing application.

## What You'll Learn

- **Docker**: Containerization, networking, volumes
- **Kubernetes**: Pods, services, ingress, persistent storage
- **Ansible**: Infrastructure automation, configuration management
- **AWS**: EKS, S3, IAM, CloudFormation

## Quick Start

### Phase 1: Docker Setup (Week 1)

1. **On your home PC (Windows WSL):**
```bash
# Clone this repo
git clone <your-repo>
cd homelab-file-handler

# Start FileBrowser
docker-compose up -d

# Access from work laptop
# http://your-home-ip:8080
```

2. **Configure FileBrowser:**
- Default login: `admin` / `admin`
- Change password immediately
- Create users for file sharing
- Test file upload/download

### Phase 2: Kubernetes (Week 2-3)

1. **Install minikube:**
```bash
# Install minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start minikube
minikube start --driver=docker
```

2. **Deploy to Kubernetes:**
```bash
# Apply all manifests
kubectl apply -f k8s/

# Check status
kubectl get pods -n homelab
kubectl get services -n homelab

# Access the app
kubectl port-forward svc/filebrowser-service 8080:80 -n homelab
# Then: http://localhost:8080
```

### Phase 3: Ansible Automation (Week 4-5)

1. **Install Ansible:**
```bash
pip install ansible
```

2. **Run the playbook:**
```bash
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
```

### Phase 4: AWS Deployment (Week 6-8)

1. **Setup AWS CLI:**
```bash
aws configure
```

2. **Create EKS cluster:**
```bash
# Install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Create cluster
eksctl create cluster -f aws/eks-cluster.yaml
```

3. **Deploy to EKS:**
```bash
# Update kubeconfig
aws eks update-kubeconfig --region us-west-2 --name homelab-cluster

# Deploy application
kubectl apply -f k8s/
```

## File Structure

```
homelab-file-handler/
├── docker-compose.yml          # Docker setup
├── k8s/                        # Kubernetes manifests
│   ├── namespace.yaml
│   ├── configmap.yaml
│   ├── pvc.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
├── ansible/                    # Ansible automation
│   ├── playbook.yml
│   └── inventory.ini
├── aws/                        # AWS configurations
│   ├── eks-cluster.yaml
│   └── s3-bucket.yaml
└── nginx/                      # Reverse proxy config
    └── nginx.conf
```

## Learning Path

### Week 1-2: Docker + Networking
- [ ] Run FileBrowser with Docker Compose
- [ ] Access from work laptop (PC-to-PC)
- [ ] Understand Docker volumes and networking
- [ ] Learn about container security

### Week 3-4: Kubernetes
- [ ] Install minikube
- [ ] Deploy FileBrowser to k8s
- [ ] Learn about pods, services, ingress
- [ ] Understand persistent storage
- [ ] Practice kubectl commands

### Week 5-6: Ansible
- [ ] Automate Docker setup
- [ ] Automate k8s deployment
- [ ] Learn about playbooks and roles
- [ ] Practice infrastructure as code

### Week 7-8: AWS
- [ ] Set up AWS account
- [ ] Create EKS cluster
- [ ] Deploy to cloud
- [ ] Learn about S3, IAM, VPC
- [ ] Understand cloud networking

## Troubleshooting

### Docker Issues
```bash
# Check containers
docker ps
docker logs homelab-filebrowser

# Restart services
docker-compose down && docker-compose up -d
```

### Kubernetes Issues
```bash
# Check pod status
kubectl describe pod -n homelab

# Check logs
kubectl logs -f deployment/filebrowser -n homelab

# Check services
kubectl get svc -n homelab
```

### Network Access
- **From work laptop**: `http://your-home-ip:8080`
- **Find your home IP**: `ip addr show` or `hostname -I`
- **Firewall**: Make sure port 8080 is open

## Next Steps

1. **Monitoring**: Add Prometheus + Grafana
2. **CI/CD**: GitHub Actions for deployment
3. **Security**: SSL certificates, authentication
4. **Backup**: Automated backups to S3
5. **Scaling**: Multiple replicas, load balancing

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Ansible Documentation](https://docs.ansible.com/)
- [AWS EKS Documentation](https://docs.aws.amazon.com/eks/)
- [FileBrowser Documentation](https://filebrowser.org/)
