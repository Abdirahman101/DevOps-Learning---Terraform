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

**Terraform importing!**

- Terraform import is a powerful command that allows you to take existing resources in your cloud environment and bring them under your Terraform management.

Import block: Used to import instances using 'id'. You can find how to import aws_instance resources using the [terraform registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#import) under AWS.

<img width="400" height="109" alt="Screenshot 2025-07-28 at 13 50 29" src="https://github.com/user-attachments/assets/0c8f05c2-edf6-4de7-9868-2a07b3a0f6dd" />

<img width="682" height="114" alt="Screenshot 2025-07-28 at 13 53 43" src="https://github.com/user-attachments/assets/c0d9bc45-bd53-47ef-8345-122292dd5232" />

Remember to run `terraform plan` once imported. Ensures the resources you have imported matches your current infrastructure!

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

- `terraform import`
  Brings existing infrastructure under Terraform management by mapping it into your state file.

_Add more commands as you learn advanced workflows:_

- [ ] `terraform taint`
- [ ] `terraform state`
- [ ] `terraform workspace`

---
## Terraform Workflow

1. Init:
   - Used to initialise a working directory containing terraform confif files
   - This is the first command that should be run after writing a new terrform configuration
   - Downloads providers
   - Configures the backend, which manages your state files
  
2. Validate:
   - Checks to see if your code is well formed, spotting early syntax errors before moving onto bigger and more complex tasks such as `plan`
  
3. Plan:
   - Creates an execution plan
   - Compares your current state to your desired state specified in config files
  
4. Apply:
   - Where you apply the changes required to reach the desired state of the config (the execution)
   - By default, apply scans the current directory for the configation and applies the changes appropriately
   - This will ask confirmation before applying

5. Destroy:
   - Used to destroy the terraform  managed infrastructure
   - This will ask for confirmation before destroying
  
---
## Variables

- Define values once and reference them multiple times
- Makes the code reusable and "dry" (to not repeat yourself)
- Best practise is writing it in a separate "vairables.tf" file

**Input Variables**

[Input variables](https://developer.hashicorp.com/terraform/language/values/variables) are the most common type of variables in Terraform. They allow you to parameterize your Terraform configurations, which makes them more dynamic and reusable.

<img width="551" height="178" alt="Screenshot 2025-08-01 at 16 17 01" src="https://github.com/user-attachments/assets/dfcbb629-5831-4034-8cf7-8e284e2e1063" />

<img width="862" height="520" alt="Screenshot 2025-08-01 at 16 18 15" src="https://github.com/user-attachments/assets/dfa3328b-dcee-4407-a405-a4178cbbd407" />

Using var.instance_type allows us to reference the variables in our variables.tf file. Defining a default means we do not need to provide an answer when we run `terraform plan`.

Best practise is to create another file called terraform.tfvars. This is where you assign the variable's value, rather than defining it using default, this is shown below.

<img width="547" height="117" alt="Screenshot 2025-08-01 at 16 23 35" src="https://github.com/user-attachments/assets/cfd4e309-d167-43c6-929a-61290b55c730" />

<img width="538" height="61" alt="Screenshot 2025-08-01 at 16 23 59" src="https://github.com/user-attachments/assets/34926803-6777-4451-978d-5e7b9cf16e02" />

When using a .tfvars file, you want to run a `terraform apply` to see if the values are being added correctly and appropriately.

<img width="1199" height="278" alt="Screenshot 2025-08-01 at 16 25 34" src="https://github.com/user-attachments/assets/2560b650-e608-45f0-b7d3-ad864fd82a5f" />

**Local Variable**

- Allows you to centralise values that are used repeatedly. Making your code easier to manage and understand.
- Makes your code "dry" and reduces redundancy.
- They are internal to terraform where as, input variables are provided by the users.
- e.g. using a local variable for the "ami_id" variable from AWS. Then referring to this local variable in the resource block. 

**Output Variable**

- Displays variables when `terraform plan` is ran.
- Useful to pass over information to other configurations and automation tools.
- e.g. used for IP addresses and IDs
- Best practices:
    - Meaningful names used to make it clear what the output variable is (e.g. use "instance_id" and **not** "i_id)
    - Document outputs, always include a description in your output block. Helps others in your team understand what the output block is doing
    - Used for critical information in automation or chaining terraform configurations together
    - Be careful when outputting sensitive information like passwords - use terraform's sensitive attribute to prevent these values being displayed in your terminal

**Input vs Local vs Output**

<img width="1841" height="917" alt="Screenshot 2025-08-04 at 14 23 26" src="https://github.com/user-attachments/assets/0630ee7f-2fc7-4e71-bb74-5d2791c7b610" />

---

## Variable Hierarchy

<img width="413" height="288" alt="Screenshot 2025-08-04 at 14 31 58" src="https://github.com/user-attachments/assets/52694648-2944-4a58-8f7a-9ded3696dcc5" />

---

## Types of Variables

**Primitive Types vs Complex Types**

<img width="1880" height="1046" alt="Screenshot 2025-08-04 at 14 45 03" src="https://github.com/user-attachments/assets/cae2ad06-89f6-4f37-9ef7-bbeeac497668" />

---

## Modules

A Terraform Module is essentially a collection of configuration files that are grouped together in order to serve a specific process. Think of a Module as a blueprint for building a simple piece of infrastructure.

**Why do we use modules?**

1. Reusability
2. Organisation
3. Consistency
4. Collaboration

**What makes a good module**

1. Simplicity - avoid hardcoding values that may change between environments (e.g. AMI's, instance types, etc.)
2. Documentation - use a readme.md file to explain how to use the module
3. Reusability
4. Output Values

Modularity: Keeping modules focussed on a single responisibility.

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

Next, run `terraform plan`.

<img width="1004" height="958" alt="Screenshot 2025-07-27 at 11 22 01" src="https://github.com/user-attachments/assets/8bfe5835-b52e-4cc2-bae1-d581479e37ec" />

<img width="1057" height="117" alt="Screenshot 2025-07-27 at 11 22 22" src="https://github.com/user-attachments/assets/33ddd510-b344-404f-977f-f7821435e829" />

Terraform will now compare our current state (the current outlook of instances running in our AWS console) to the desired state (creating an EC2 instance).

<img width="351" height="50" alt="Screenshot 2025-07-27 at 11 24 18" src="https://github.com/user-attachments/assets/f6bf5c97-f5bd-458c-8e81-c74fcc1db154" />

Above is the current state.

Now, run `terraform apply`.

<img width="999" height="952" alt="Screenshot 2025-07-27 at 11 26 03" src="https://github.com/user-attachments/assets/ffcafcc4-4ed2-48b4-bea9-b3703df96ebb" />

<img width="531" height="241" alt="Screenshot 2025-07-27 at 11 26 45" src="https://github.com/user-attachments/assets/92879dea-f999-4fa5-b88e-bebd4ac255d8" />

We have now created our EC2 instance using Terraform! Below is the new current state shown in the AWS Console - there is now an EC2 instance running!

<img width="349" height="48" alt="New current state after terraform apply" src="https://github.com/user-attachments/assets/273f4e44-73c6-4f8d-bd57-25887a05ab43" />

---

## 🛠️ Terraform Import Challenge: Manual Deployment of EC2 + Terraform Import Usage

Create an EC2 instance in your AWS console (manually).

<img width="640" height="179" alt="Screenshot 2025-07-28 at 14 11 56" src="https://github.com/user-attachments/assets/4c8d5569-5563-4000-b64d-e582ea8a2586" />

Return to VS Code and add another resource block and name it 'import'

<img width="483" height="196" alt="Screenshot 2025-07-28 at 14 16 24" src="https://github.com/user-attachments/assets/7dbea5d2-fd89-451a-bf1d-ac9e75ca9f51" />

Run the import terraform import command in the Terraform registry for an AWS instance (resource). Add the respective name of your resource bnlock which in this case is 'import' and add the EC2 instance id (we just created manually).

<img width="550" height="145" alt="image" src="https://github.com/user-attachments/assets/26293c08-dd2d-4f3f-b677-ba91adc158d4" />

Next run `terraform plan` to check that the current state matches the desired state. We are given this output for updates in place: 

<img width="993" height="356" alt="Screenshot 2025-07-28 at 14 47 30" src="https://github.com/user-attachments/assets/2d94d2d5-73a4-41be-88a8-473b00e44819" />

We need to locate 'tags' in the terraform registry under 'Argument reference'. We can see that tags are configured under the resource block. Add the tag and the suggested `user_data_replace_on_change = false`

<img width="487" height="272" alt="image" src="https://github.com/user-attachments/assets/ac7bd75b-8d7f-4969-b8e8-27eb5e98459c" />

Run `terraform plan` again to preview the current vs desired states:

<img width="937" height="100" alt="Screenshot 2025-07-28 at 14 50 18" src="https://github.com/user-attachments/assets/1deb2c69-44ba-4d23-ab8c-af0942cb4ca6" />

As you can see, no changes are needed as our infrastructure matches the configuration (our desired state matches our current state). Making our terraform import successful - i.e. we have successfully imported our EC2 instance from AWS (**manually created**) into our managed terraform environment. 

---

## Terraform Module Demo Example

Create a new folder/directory named modules. Then add another folder/directory under modules called "ec2". Move the ec2.tf and variables.tf files to ./modules/ec2.

<img width="324" height="99" alt="Screenshot 2025-08-04 at 15 36 08" src="https://github.com/user-attachments/assets/dd0af24a-24c8-4b31-8317-51e715a7e055" />

Create a "main.tf" file in the directory that has the provider.tf file. The module can then be directed to in the main.tf file by includiong the path to the ec2 files.

<img width="266" height="86" alt="Screenshot 2025-08-04 at 15 38 35" src="https://github.com/user-attachments/assets/fc87c809-156d-499b-88ee-f3c654b54524" />

Run `terraform init` to initialise the backend and then run `terraform plan` to compare your current and desired states. Since, i've deleted my ec2 instances from previous hands-on labs, the expected output should be to add 2, change 0 and destroy 0. 

<img width="309" height="20" alt="Screenshot 2025-08-04 at 15 40 41" src="https://github.com/user-attachments/assets/1356107d-4a97-49f7-987e-60c71778e205" />

Run `terraform apply` to apply the terraform code.

<img width="615" height="122" alt="Screenshot 2025-08-04 at 15 42 31" src="https://github.com/user-attachments/assets/061db85e-f67b-4f16-879c-72a520856fcc" />

My AWS console now shows 2 new instances as expected!

<img width="744" height="61" alt="Screenshot 2025-08-04 at 15 43 25" src="https://github.com/user-attachments/assets/f5581f66-ced1-4dc7-b2fa-6ec91e5a11c3" />

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
