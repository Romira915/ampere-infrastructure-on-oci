resource "oci_core_instance" "ampere_instance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_id
  shape               = "VM.Standard.A1.Flex"

  shape_config {
    ocpus         = 4
    memory_in_gbs = 24
  }
  source_details {
    source_id   = var.image_id
    source_type = "image"
  }
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.public_ampere_subnet.id
  }

  display_name = "ampere-instance"
  defined_tags = {
    "Romira-s-Tags.Always-Free" = "true"
  }

  metadata = {
    "ssh_authorized_keys" = file(var.ssh_public_key_path)
    "user_data" = base64encode(join("\n", [
      "#cloud-config",
      yamlencode({
        timezone : "Asia/Tokyo",
        package_update : true,
        package_upgrade : true,
        packages : [
          "iptables-persistent",
        ],
        runcmd : [
          format("/bin/sed -i -e \"s/#Port 22/Port %d/\" /etc/ssh/sshd_config", var.instance_ssh_port),
          format("/bin/sed -i -e \"s/-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT/-A INPUT -p tcp -m state --state NEW -m tcp --dport %d -j ACCEPT/\" /etc/iptables/rules.v4", var.instance_ssh_port),
          ["systemctl", "restart", "ssh"],
          ["systemctl", "restart", "sshd"],
          "iptables-restore < /etc/iptables/rules.v4",
        ],
      }),
      ]
    ))
  }
}
