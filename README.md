# 🚀 Terraform Learning Journey

Welcome to my Terraform learning journey repository, where I document my notes, commands, concepts, and mini-projects as I learn Terraform for infrastructure as code (IaC).

---

## 📚 Content Notes

> Use this section to add short concept notes as you learn, e.g., about providers, resources, modules, backends, and state management.

- **What is Terraform?**: A tool for building, changing, and versioning infrastructure safely and efficiently.
- **Provider:** A plugin to interact with cloud platforms (AWS, Azure, etc.).
- **Resource:** Represents infrastructure components (VM, S3 bucket).
- **State File:** Tracks infrastructure state to allow Terraform to determine changes.
- **Module:** A container for multiple resources used together.

**Terraform State File**:

- An up to date record of your existing infrastructure. 
- The Terraform state file (terraform.tfstate) tracks your infrastructure so Terraform knows what it manages.
- Ensures Idempotency: Running terraform apply multiple times with the same config won’t create duplicates or make unnecessary changes.

**⚖️ Desired State (.tf) vs Current State (.tfstate)**:

- Desired State (.tf files):
The infrastructure you want, defined in your Terraform configuration.

- Current State (terraform.tfstate):
The infrastructure you have, tracked by Terraform after apply.

Terraform uses the state file to compare what you want vs. what you have:
- If they match ➔ No changes on terraform apply.
- If they differ ➔ Terraform applies only what’s needed to match your config.

**Configuring a Resource Block (AWS instance example)**

```hcl
resource "<resource type>" "<name of instance>" {
  ami = "<amazon machine image template>" # e.g., "ami-0abcd1234ef567890" for Ubuntu
  instance_type = "t2.micro" # hardware configuration (t2.micro is free tier eligible)
tags = { # optional but good practice for organization
Name = "Helloworld"
}
}
```

---

## ⚙️ Terraform Commands Explained

> Document what each Terraform command does

- `terraform init`  
  Initialises a Terraform working directory, downloading required provider plugins and preparing the backend.

- `terraform validate`  
  Validates your configuration files for syntax correctness.

- `terraform plan`  
  Shows what actions Terraform will take to achieve the desired state.
  __'+' create: resources that will be created
  '~' update in-place: resources that will be modified
  '-' destroy: resources that will be destroyed__

- `terraform apply`  
  Applies the changes required to reach the desired state.

- `terraform destroy`  
  Destroys the managed infrastructure safely.

- `terraform fmt`  
  Formats your Terraform code for consistent style.

- `terraform show`  
  Displays the current state in a human-readable format.

_Add more commands as you learn advanced workflows:_

- [ ] `terraform taint`
- [ ] `terraform state`
- [ ] `terraform import`
- [ ] `terraform workspace`

---

## 🛠️ Creating an EC2 instance task

First visit [terraform registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) and install the AWS provider. Once installed, run the terraform init command in your terminal (make sure you cd into the desired directory on your local machine)

<img width="326" height="252" alt="Screenshot 2025-07-24 at 20 04 49" src="https://github.com/user-attachments/assets/0da198d3-cba1-447e-a108-5da2a88856ee" />

<img width="608" height="285" alt="Screenshot 2025-07-24 at 20 05 13" src="https://github.com/user-attachments/assets/2bdb92c5-42ee-42a4-b89c-cd420689efac" />









---

## 🛠️ Project Documentation

> Use this section to track your mini-projects, learning labs, and experiments with clear structure.


## 🌱 How to Use This Repository

✅ Clone this repo for your learning notes  
✅ Update `Content Notes` as you learn  
✅ Expand `Terraform Commands Explained` with your understanding  
✅ Document your projects under `Project Documentation`  

---

> _This README evolves with your Terraform journey. Commit frequently to track your growth._

---

## 🖇️ References

- [Terraform Official Documentation](https://developer.hashicorp.com/terraform/docs)
- [Terraform GitHub](https://github.com/hashicorp/terraform)
- [Learn Terraform - HashiCorp](https://developer.hashicorp.com/terraform/tutorials)

---

✨ Happy Terraforming!
