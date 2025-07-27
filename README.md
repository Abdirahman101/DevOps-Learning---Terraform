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

Locate the documentation for a EC2 resource:aws_instance in the terraform registry. Take a look at the "Argument Reference" to understand which arguments are required for spinning up an EC2 instance. For this task we require an AMI since we are not using a launch template (screenshot of the terraform skeleton below)

<img width="1025" height="422" alt="Screenshot 2025-07-27 at 10 59 32" src="https://github.com/user-attachments/assets/0c0a0812-ae57-41cd-9623-4f81f4238284" />

<img width="696" height="199" alt="AWS EC2 Terraform skeleton" src="https://github.com/user-attachments/assets/2f9701bb-cae8-4081-aa2d-9aa2703cc7a1" />

Open the AWS management console and navigate to the EC2 page. Click Launch an instance - this is where we will get the actual AMI ID and the free tier eligible instance_type. In this case, I have opted for the Amazon Linux AMI and the t2.micro 

<img width="469" height="136" alt="Screenshot 2025-07-27 at 11 10 51" src="https://github.com/user-attachments/assets/09d07d01-f335-4de1-b5d2-b3b3f61aa0f9" />

Create an access key in your AWS console under IAM and configure this in your terminal.

Next, run 'terraform plan'.

<img width="1004" height="958" alt="Screenshot 2025-07-27 at 11 22 01" src="https://github.com/user-attachments/assets/8bfe5835-b52e-4cc2-bae1-d581479e37ec" />

<img width="1057" height="117" alt="Screenshot 2025-07-27 at 11 22 22" src="https://github.com/user-attachments/assets/33ddd510-b344-404f-977f-f7821435e829" />

Terraform will now compare our current state (the current outlook of instances running in our AWS console) to the desired state (creating an EC2 instance).

<img width="351" height="50" alt="Screenshot 2025-07-27 at 11 24 18" src="https://github.com/user-attachments/assets/f6bf5c97-f5bd-458c-8e81-c74fcc1db154" />

Above is the current state.

Now, run 'terraform apply'.

<img width="999" height="952" alt="Screenshot 2025-07-27 at 11 26 03" src="https://github.com/user-attachments/assets/ffcafcc4-4ed2-48b4-bea9-b3703df96ebb" />

<img width="531" height="241" alt="Screenshot 2025-07-27 at 11 26 45" src="https://github.com/user-attachments/assets/92879dea-f999-4fa5-b88e-bebd4ac255d8" />

We have now created our EC2 instance using Terraform! Below is the new current state shown in the AWS Console - there is now an EC2 instance running!

<img width="349" height="48" alt="New current state after terraform apply" src="https://github.com/user-attachments/assets/273f4e44-73c6-4f8d-bd57-25887a05ab43" />

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
