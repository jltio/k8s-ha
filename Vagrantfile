Vagrant.configure(2) do |config|

  config.vm.box = "centos/7"
  config.ssh.insert_key = false
  config.ssh.private_key_path = ["~/.vagrant.d/insecure_private_key", "~/.ssh/id_rsa"]
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"

  create_user = <<-SHELL
  groupadd centos
  useradd -d /home/centos -g centos -m -s /bin/bash centos
  echo "centos ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/centos
  mkdir /home/centos/.ssh
  chown centos.centos /home/centos/.ssh
  chmod 700 /home/centos/.ssh
  cp /home/vagrant/.ssh/authorized_keys /home/centos/.ssh/authorized_keys
  chown centos.centos /home/centos/.ssh/authorized_keys
  chmod 600 /home/centos/.ssh/authorized_keys
  SHELL

  # 3 VMs for Kubernetes master
  (1..3).each do |i|
    config.vm.define "k8s-master0#{i}" do |control|
      control.vm.hostname = "k8s-master0#{i}"
      control.vm.network "private_network", ip: "192.168.100.10#{i}"
      control.vm.provider "virtualbox" do |v|
        v.name = "k8s-master0#{i}"
        v.memory = 1024
        v.cpus = 1
      end
      config.vm.provision :shell, :inline => create_user
    end
  end

  # 3 VMs for Kubernetes worker
  (1..3).each do |i|
    config.vm.define "k8s-worker0#{i}" do |control|
      control.vm.hostname = "k8s-worker0#{i}"
      control.vm.network "private_network", ip: "192.168.100.11#{i}"
      control.vm.provider "virtualbox" do |v|
        v.name = "k8s-worker0#{i}"
        v.memory = 1024
        v.cpus = 1
      end
      config.vm.provision :shell, :inline => create_user
    end
  end

  # 2 VMs for Haproxy
  (1..2).each do |i|
    config.vm.define "haproxy0#{i}" do |control|
      control.vm.hostname = "haproxy0#{i}"
      control.vm.network "private_network", ip: "192.168.100.12#{i}"
      control.vm.provider "virtualbox" do |v|
        v.name = "haproxy0#{i}"
        v.memory = 1024
        v.cpus = 1
      end
      config.vm.provision :shell, :inline => create_user
    end
  end

end