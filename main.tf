resource "google_compute_instance" "Instance" {
	name = local.InstanceName
	zone = local.ZoneName
	machine_type = local.MachineType
	boot_disk {
		device_name = "persistent-disk-0"
		auto_delete = true
		initialize_params {
			image = data.google_compute_image.Image.id
			size = local.CustomImageSize
		}
	}
	allow_stopping_for_update = true
	network_interface {
		network = data.google_compute_network.Eth0VpcNetwork.self_link
		network_ip = local.Eth0PrivateIpAddress
		subnetwork = data.google_compute_subnetwork.Eth0Subnet.self_link
		access_config {
			nat_ip = google_compute_address.Eth0PublicIpAddress.address
			network_tier = "PREMIUM"
		}
		alias_ip_range {
			ip_cidr_range = local.Eth0PrivateIpAliases
		}
	}
	network_interface {
		network = data.google_compute_network.Eth1VpcNetwork.self_link
		network_ip = local.Eth1PrivateIpAddress
		subnetwork = data.google_compute_subnetwork.Eth1Subnet.self_link
		access_config {
			network_tier = "PREMIUM"
		}
		alias_ip_range {
			ip_cidr_range = local.Eth1PrivateIpAliases
		}
	}
	network_performance_config {
		total_egress_bandwidth_tier	= "TIER_1"
	}
	metadata = {
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
		serial-port-enable = local.SerialPortEnable
	}
	metadata_startup_script = local.startup_script
	tags = local.NetworkTargetTags
	labels = {
		owner = replace(replace(local.UserEmailTag, ".", "-"), "@", "-")
		project = lower(local.UserProjectTag)
	}
}

resource "google_compute_address" "Eth0PublicIpAddress" {
	name = local.Eth0PublicIpAddressName
	region = local.RegionName
	network_tier = "PREMIUM"
	address_type = "EXTERNAL"
}