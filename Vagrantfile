# vi: set ft=ruby :

Vagrant.configure('2') do |config|
    config.vm.box = 'azure'
    config.vm.box_url = 'https://github.com/msopentech/vagrant-azure/raw/master/dummy.box'

    config.vm.boot_timeout = 600
    config.ssh.username = 'namabile'
    config.ssh.private_key_path = File.expand_path('~/.ssh/azure.pem')

    config.omnibus.chef_version = :latest

    do_common_azure_stuff = Proc.new do |azure, override|

      azure.mgmt_certificate = File.expand_path('~/.ssh/azure.pem')
      azure.mgmt_endpoint = 'https://management.core.windows.net'
      azure.subscription_id = ENV["AZURE_SUBSCRIPTION_ID"]

      azure.vm_image = 'b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04_2-LTS-amd64-server-20150506-en-us-30GB'
      azure.vm_size = 'Small'
      azure.vm_location = 'East US'

      azure.ssh_port = '22'
      azure.ssh_private_key_file = File.expand_path('~/.ssh/azure.pem')

      azure.tcp_endpoints = '8000'
      azure.vm_virtual_network_name = "dev-network"

      azure.vm_user = 'namabile'

    end

    config.vm.define 'dev' do |cfg|
      cfg.vm.network "private_network", ip: "10.0.0.10"
      cfg.vm.provider :azure do |azure, override|
        do_common_azure_stuff.call azure, override
        azure.vm_name = 'dev'
        config.vm.provision "chef_solo" do |chef|
          chef.roles_path = "roles"
          chef.add_role("base")
          chef.add_role("fsharp")
        end
      end
    end

    config.vm.define 'eventstore' do |cfg|
      cfg.vm.network "private_network", ip: "10.0.0.20"
      cfg.vm.provider :azure do |azure, override|
        do_common_azure_stuff.call azure, override
        azure.vm_name = 'eventstore'
        config.vm.provision "chef_solo" do |chef|
          chef.roles_path = "roles"
          chef.add_role("eventstore")
        end
      end
    end

    config.vm.define 'hadoop_nn' do |cfg|
      cfg.vm.network "private_network", ip: "10.0.0.30"
      cfg.vm.provider :azure do |azure, override|
        do_common_azure_stuff.call azure, override
        azure.vm_name = 'hadoop-nn'
        azure.tcp_endpoints = "8000, 8080, 7077, 18080, 8081"
        config.vm.provision "chef_solo" do |chef|
          chef.roles_path = "roles"
          chef.add_role("hadoop_nn")
        end
      end
    end

    config.vm.define 'hadoop_dn' do |cfg|
      cfg.vm.network "private_network", ip: "10.0.0.40"
      cfg.vm.provider :azure do |azure, override|
        do_common_azure_stuff.call azure, override
        azure.vm_name = 'hadoop-dn'
        azure.tcp_endpoints = "8000, 8080, 7077, 18080, 8081"
        config.vm.provision "chef_solo" do |chef|
          chef.roles_path = "roles"
          chef.add_role("hadoop_nn")
      end
    end
  end

  config.vm.define 'spark' do |cfg|
    cfg.vm.network "private_network", ip: "10.0.0.50"
    cfg.vm.provider :azure do |azure, override|
      do_common_azure_stuff.call azure, override
      azure.vm_size = "large"
      azure.vm_name = 'spark'
      azure.tcp_endpoints = "8000, 8080, 7077, 18080, 8081"
      config.vm.provision "chef_solo" do |chef|
        chef.roles_path = "roles"
        chef.add_role("spark")
      end
    end
  end

end

