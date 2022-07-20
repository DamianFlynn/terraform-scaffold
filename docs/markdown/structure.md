# Innofactor cloud framework

This project exists to support internal collaboration and work related to the Innofactor cloud framework.

The framework is intended to be an overall architecture, established from multiple consistent solutions, which can be deployed independently or together.

## Building Blocks

THe following building blocks, all of which are modules in thier own right, are implemented to provide a hierachy and structure to the resuable code which is contained within

### Solutions

A solution is a complete and integrated offering that includes everything required to solve a customer challenge and provide value to the customer.

Examples include

* Sentinel
* Networking
* Azure Virtual Desktop

### Components

A component is a atomic piece of functionality which works with other components to build Solutions

Examples

* Governance logging
* Platform Logging
* Governance Policy

### Modules

A module is a reusable collection of code that is independently developed and managed. One or more modules may be used to develop components.

Examples

* Azure Workbook
* Azure Dashboard


## Test Case: Azure Virtual Desktop

This is the solution we are going to build.

1. Pitch Deck - 4 Slides to Define what are we building
   Virtual Desktop or Application published to a user
   Hosted in the Cloud, and scales on demand, with Security in the core design

1. Scope / Statement Of Work
   1. Managemnt Structure for Virtual Desktop Service
   1. Node Pool for hosting a initial application set
   1. Image Builder

Options
   1. Azure AD Service

Requireemnts
1. How to guides:
   * Add a new App to a image
   * add a new pool for hosting apps
   * why add a new pool
   * is the pool working
   * are users connected


## Conponents

### Core AVD Structure
? It this common for Dev / Test / Prod, or do i need mutliple Instances....

-> Module: AVD Core Service

### Node Pool

-> Module: Virtual Machine (Windows)
-> Custom Image for the Virtual Machine

### Image Builder

This takes a packer file, and builds an image with packages the applications to be published.
the published image needs to be versioned, and generated on a schedule to enusre that it is always patched.

-> Module: Image Factory
    Option 1: Azure Image Builder
    Option 2: Packer Builder

-> Module: Image Gallery
    Concerns: Replication, Metadata, Security Scanning,
    Notifications: Teams Channel updates on new pushing, or issues.

-> Module: Image Defination
    This accepts in the app silent installs scripts
    the list of apps to embed in the image
    optimzation for the os
    securiyty fixes


### User Profile Storage

FOr presisitance of the users data, in a secure and fast congfiguration we need to host a storage offer to be intergrated into the plantform

-> Module: FXlogic

## Modules

### FXLogic

This is a module that takes the base **Storage Module** and adds ....

### IMage Factory

This module creats an azure image builder envitonment

### Image Factory Defination

This module includes the configuration settings for building image in the factory for an initial app offer defined as Json or Packer HCL

### Virtual Machine

This deployed a VM which will connect to a image and vnet for publishing

# Standard Module Structure

The standard module structure is a file and directory layout we recommend for reusable modules distributed in separate repositories. Terraform tooling is built to understand the standard module structure and use that structure to generate documentation, index modules for the module registry, and more.

The standard module structure expects the layout documented below. The list may appear long, but everything is optional except for the root module. Most modules don't need to do any extra work to follow the standard structure.

* **Root module.** This is the only required element for the standard module structure. Terraform files must exist in the root directory of the repository. This should be the primary entrypoint for the module and is expected to be opinionated. For the Consul module the root module sets up a complete Consul cluster. It makes a lot of assumptions however, and we expect that advanced users will use specific nested modules to more carefully control what they want.

* **README**. The root module and any nested modules should have README files. This file should be named README or README.md. The latter will be treated as markdown. There should be a description of the module and what it should be used for. If you want to include an example for how this module can be used in combination with other resources, put it in an examples directory like this. Consider including a visual diagram depicting the infrastructure resources the module may create and their relationship.

  The README doesn't need to document inputs or outputs of the module because tooling will automatically generate this. If you are linking to a file or embedding an image contained in the repository itself, use a commit-specific absolute URL so the link won't point to the wrong version of a resource in the future.

* **LICENSE**. The license under which this module is available. When you share your module, the LICENSE file will let people using it know the terms under which it has been made available. Terraform itself does not use this file. Many organizations will not adopt a module unless a clear license is present, therefore we recommend always having a license file, even if it is not an open source license.

* `main.tf`, `variables.tf`, `outputs.tf`. These are the recommended filenames for a minimal module, even if they're empty.  `variables.tf` and `outputs.tf` should contain the declarations for variables and outputs, respectively.

  * `main.tf` should be the primary entrypoint. For a simple module, this may be where all the resources are created. For a complex module, resource creation may be split into multiple files but any nested module calls should be in the main file. You can also create other configuration files and organize them however makes sense for your project.

  * `variables.tf` will contain the variable definitions for your module. When your module is used by others, the variables will be configured as arguments in the module block. Since all Terraform values must be defined, any variables that are not given a default value will become required arguments. Variables with default values can also be provided as module arguments, overriding the default value.

  * `outputs.tf` will contain the output definitions for your module. Module outputs are made available to the configuration using the module, so they are often used to pass information about the parts of your infrastructure defined by the module to other parts of your configuratio

* **Variables and outputs should have descriptions**. All variables and outputs should have one or two sentence descriptions that explain their purpose. This is used for documentation. See the documentation for variable configuration and output configuration for more details.

* **Nested modules**. Nested modules should exist under the `modules/` subdirectory. Any nested module with a `README.md` is considered usable by an external user. If a `README` doesn't exist, it is considered for internal use only. These are purely advisory; Terraform will not actively deny usage of internal modules. Nested modules should be used to split complex behavior into multiple small modules that advanced users can carefully pick and choose. For example, the Consul module has a nested module for creating the Cluster that is separate from the module to setup necessary IAM policies. This allows a user to bring in their own IAM policy choices.

  If the root module includes calls to nested modules, they should use relative paths like `./modules/consul-cluster` so that Terraform will consider them to be part of the same repository or package, rather than downloading them again separately.

  If a repository or package contains multiple nested modules, they should ideally be composable by the caller, rather than calling directly to each other and creating a deeply-nested tree of modules.

* **Examples**. Examples of using the module should exist under the `examples/` subdirectory at the root of the repository. Each example may have a `README` to explain the goal and usage of the example. Examples for submodules should also be placed in the root `examples/` directory.

  Because examples will often be copied into other repositories for customization, any module blocks should have their source set to the address an external caller would use, not to a relative path.

A minimal recommended module following the standard structure is shown below. While the root module is the only required element, we recommend the structure below as the minimum:

```sh
$ tree minimal-module/
.
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
```

A complete example of a module following the standard structure is shown below. This example includes all optional elements and is therefore the most complex a module can become:

```
$ tree complete-module/
.
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── ...
├── modules/
│   ├── nestedA/
│   │   ├── README.md
│   │   ├── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   ├── nestedB/
│   ├── .../
├── examples/
│   ├── exampleA/
│   │   ├── main.tf
│   ├── exampleB/
│   ├── .../
```
