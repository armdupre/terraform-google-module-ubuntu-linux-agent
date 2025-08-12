locals {
	CustomImageFamilyName = var.CustomImageFamilyName
	CustomImageProjectId = var.CustomImageProjectId
	CustomImageSize = var.CustomImageSize
	Eth0PrivateIpAddress = var.Eth0PrivateIpAddress
	Eth0PublicIpAddressName = "${local.Preamble}-eth0-ip-addr"
	Eth0SubnetName = var.Eth0SubnetName
	Eth0VpcNetworkName = var.Eth0VpcNetworkName
	Eth1PrivateIpAddress = var.Eth1PrivateIpAddress
	Eth1PrivateIpAliases = var.Eth1PrivateIpAliases
	Eth1SubnetName = var.Eth1SubnetName
	Eth1VpcNetworkName = var.Eth1VpcNetworkName
	InstanceId = var.InstanceId
	InstanceName = "${local.Preamble}-instance"
	MachineType = var.MachineType
	NetworkTargetTags = var.NetworkTargetTags
	Preamble = replace("${local.UserLoginTag}-${local.UserProjectTag}-${local.Tag}-${local.Version}-${local.InstanceId}", "_", "-")
	RegionName = var.RegionName
	SerialPortEnable = true
	Tag = var.Tag
	UserEmailTag = var.UserEmailTag
	UserLoginTag = var.UserLoginTag
	UserProjectTag = var.UserProjectTag
	Version = var.Version
	ZoneName = var.ZoneName
}

locals {
	startup_script  = <<-EOF
#!/bin/bash -xe
apt-get update
apt-get install -y iperf
apt-get install -y iperf3
lshw -class network
#iperf -s
#iperf -t 30 -c 10.0.2.116 -P 16
	EOF
}