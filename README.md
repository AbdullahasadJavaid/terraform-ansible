<img width="1024" height="800" alt="terraform+ansible post" src="https://github.com/user-attachments/assets/076cd146-c4e9-4dc6-916f-f521b9bfc3a0" />

---



## Terraform & Ansible Nginx Experiment

This is a hands-on experiment project where I used **Terraform** to provision AWS EC2 instances and **Ansible** to install and configure **Nginx** on them.  

The setup creates **2 EC2 instances** in the Mumbai (`ap-south-1`) region, with SSH and HTTP access via a security group.  

---

## Features

- Provision EC2 instances with Terraform
- Configure security groups for SSH (22) and HTTP (80)
- Install and start Nginx using Ansible
- Fully automated workflow

---

## Prerequisites

Make sure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- AWS CLI configured with proper credentials (`aws configure`)
- SSH key pair created in AWS (used in `terraform/main.tf` as `key_name`)

---

## Terraform Setup

1. **Clone the repo**

```bash
git clone https://github.com/<your-username>/<repo-name>.git
cd <repo-name>
```

2. **Initialize Terraform**

```bash
terraform init
```

3. **Preview the infrastructure changes**

```bash
terraform plan
```

4. **Apply Terraform to create resources**

```bash
terraform apply
```

> Type `yes` when prompted. This will create:
> * Security Group
> * 2 EC2 instances

5. **Get the public IPs of EC2 instances**

```bash
terraform output instance_public_ips
```

---

## Ansible Setup

1. **Create the inventory file `hosts`** with the EC2 public IPs from Terraform output:

```ini
[web]
<EC2_PUBLIC_IP_1>
<EC2_PUBLIC_IP_2>

[web:vars]
ansible_user=your-user
ansible_ssh_private_key_file=key-file
```

2. **Run the Ansible playbook to install Nginx**

```bash
ansible-playbook -i hosts install_nginx.yml
```

3. **Verify Nginx is running**

```bash
curl http://<EC2_PUBLIC_IP_1>
curl http://<EC2_PUBLIC_IP_2>
```

> You should see the default Nginx welcome page.

---

## Clean Up

After testing, destroy the infrastructure to avoid AWS charges:

```bash
terraform destroy
```
**Terraform commands**

```bash
terraform init        # Initialize Terraform
terraform plan        # Preview changes
terraform apply       # Apply changes
terraform output      # Show outputs (like public IPs)
terraform destroy     # Destroy infrastructure
```

**Ansible commands**

```bash
ansible-playbook -i hosts install_nginx.yml  # Run the playbook
curl http://<EC2_PUBLIC_IP>                  # Test Nginx
```
