variable "CustomImageFamilyName" {
	default = "ubuntu-minimal-2204-lts"
	description = "Group of images to which image belongs"
	type = string
}

variable "CustomImageProjectId" {
	default = "ubuntu-os-cloud"
	description = "Globally unique identifier for image source project"
	type = string
}

variable "CustomImageSize" {
	default = 30
	description = "Size of the image when expanded"
	type = number
}

variable "Eth0PrivateIpAddress" {
	default = "10.0.10.11"
	type = string
}

variable "Eth0SubnetName" {
	description = "Name of the subnet associated with the first network interface"
	type = string
}

variable "Eth0VpcNetworkName" {
	description = "Name of the virtual private cloud associated with the first network interface"
	type = string
}

variable "Eth1PrivateIpAddress" {
	default = "10.0.2.15"
	type = string
}

variable "Eth1PrivateIpAliases" {
	default = "/28"
	type = string
}

variable "Eth1SubnetName" {
	description = "Name of the subnet associated with the second network interface"
	type = string
}

variable "Eth1VpcNetworkName" {
	description = "Name of the virtual private cloud associated with the second network interface"
	type = string
}

variable "InstanceId" {
	default = "agent"
	description = "Id of the instance of this module that ensures uniqueness"
	type = string
}

variable "MachineType" {
	default = "c2-standard-8"
	description = "Designation for set of resources available to VM"
	type = string
	validation {
		condition = contains([	"c2-standard-4",	"c2-standard-8",	"c2-standard-16"
							], var.MachineType)
		error_message = <<EOF
MachineType must be one of the following types:
	c2-standard-4, c2-standard-8, c2-standard-16
		EOF
	}
}

variable "NetworkTargetTags" {
	default = [
		"ixnetwork-agent"
	]
	description = "Network tags make firewall rules and routes applicable to specific VM instances."
	type = list(string)
}

variable "RegionName" {
	default = "us-central1"
	description = "Geographical location where resources can be hosted" 
	type = string
}

variable "Tag" {
	default = "ubuntu"
	description = "App ID tag of application using the deployment"
	type = string
}

variable "UserEmailTag" {
	default = "terraform@example.com"
	description = "Email address tag of user creating the deployment"
	type = string
	validation {
		condition = length(var.UserEmailTag) >= 14
		error_message = "UserEmailTag minimum length must be >= 14."
	}
}

variable "UserLoginTag" {
	default = "terraform"
	description = "Login ID tag of user creating the deployment"
	type = string
	validation {
		condition = length(var.UserLoginTag) >= 4
		error_message = "UserLoginTag minimum length must be >= 4."
	}
}

variable "UserProjectTag" {
	default = "module"
	description = "Project tag of user creating the deployment"
	type = string
}

variable "Version" {
	default = "22-04"
	description = "Versioning of the application using the deployment"
	type = string
}

variable "ZoneName" {
	default = "us-central1-a"
	description = "Deployment area within a region"
	type = string
}

variable "init_cli" {
	default = <<-EOF
#!/bin/bash -xe
apt-get update
apt-get install -y iperf
apt-get install -y iperf3
lshw -class network
	EOF
	type = string
}