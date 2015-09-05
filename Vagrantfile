# vi: set ft=ruby :

Vagrant.configure('2') do |config|
    config.vm.box = 'azure'
    config.vm.box_url = 'https://github.com/msopentech/vagrant-azure/raw/master/dummy.box'

    config.ssh.username = 'namabile'
    config.ssh.private_key_path = File.expand_path('~/.ssh/azure.pem')

    config.vm.provider :azure do |azure, override|
        # Mandatory Settings
        azure.mgmt_certificate = File.expand_path('~/.ssh/azure.pem')
        azure.mgmt_endpoint = 'https://management.core.windows.net'
        azure.subscription_id = ENV["AZURE_SUBSCRIPTION_ID"]

        azure.vm_name = 'dev'
        azure.vm_image = 'b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04_2-LTS-amd64-server-20150506-en-us-30GB'
        azure.vm_size = 'Small'
        azure.vm_location = 'East US'

        azure.ssh_port = '22'
        azure.ssh_private_key_file = File.expand_path('~/.ssh/azure.pem')

        azure.tcp_endpoints = '8000'

        azure.vm_user = 'namabile' # defaults to 'vagrant' if not provided

    end

    config.vm.provision "chef_solo" do |chef|
      chef.add_recipe "apt"
      chef.add_recipe "ubuntu"
      chef.add_recipe "omnibus_updater"
      chef.add_recipe "build-essential"
      chef.add_recipe "networking_basic"
      chef.add_recipe "ntp"
      chef.add_recipe "git"
      chef.add_recipe "rvm"
      chef.add_recipe "rvm::system"
      chef.add_recipe "rvm::vagrant"
      chef.add_recipe "rvm::user"
      chef.add_recipe "mono"
      chef.add_recipe "fsharp"

      chef.json = {
        "rvm" => {
          "namabile" => {
            "rubies" => ["stable"]
          }
        }
      }
    end

end
