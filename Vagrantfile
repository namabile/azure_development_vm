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

      azure.vm_user = 'namabile' # defaults to 'vagrant' if not provided

    end

    default_json = {
      "rvm" => {
        "namabile" => {
          "rubies" => ["stable"]
        },
        "compile_time" => false
      },
      # prevents rvm from clashing with chef-solo
      :vagrant => {
        :system_chef_solo => '/opt/chef/bin/chef-solo'
      },
      :dotfiles => {
        :users => [
          {
            :user_name => "namabile",
            :git_url => "https://github.com/namabile/dotfiles.git",
            :files_to_use => [".tmux.conf", ".vimrc", ".gitconfig", ".bashrc", "git/git-prompt.sh", "git/git-completion.bash"]
          }
        ]
      }
    }

    config.vm.define 'dev' do |cfg|
      cfg.vm.network "private_network", ip: "10.0.0.10"
      cfg.vm.provider :azure do |azure, override|
        do_common_azure_stuff.call azure, override
        azure.vm_name = 'dev'
        config.vm.provision "chef_solo" do |chef|
          chef.add_recipe "apt"
          chef.add_recipe "ubuntu"
          chef.add_recipe "build-essential"
          chef.add_recipe "ntp"
          chef.add_recipe "git"
          chef.add_recipe "rvm::user"
          chef.add_recipe "mono"
          chef.add_recipe "fsharp"
          chef.add_recipe "dotfiles"
          chef.add_recipe "scala"
          chef.add_recipe "anaconda"

          chef.json = default_json
        end
      end
    end

    config.vm.define 'spark' do |cfg|
      cfg.vm.network "private_network", ip: "10.0.0.20"
      cfg.vm.provider :azure do |azure, override|
        do_common_azure_stuff.call azure, override
        azure.vm_name = 'spark'
        config.vm.provision "chef_solo" do |chef|
          chef.add_recipe "apt"
          chef.add_recipe "ubuntu"
          chef.add_recipe "build-essential"
          chef.add_recipe "ntp"
          chef.add_recipe "git"
          chef.add_recipe "rvm::user"
          chef.add_recipe "mono"
          chef.add_recipe "fsharp"
          chef.add_recipe "dotfiles"
          chef.add_recipe "apache_spark"
          chef.add_recipe "scala"
          chef.add_recipe "anaconda"

          chef.json = default_json.merge({
            :apache_spark => {
              :download_url => "http://www.apache.org/dyn/closer.lua/spark/spark-1.4.1/spark-1.4.1.tgz",
              :checksum => "73E311070B74C23D680935C979AEB3D7B04E6D4CFEBDB5511E7B5E8A985EEE32D73221FF3257D4A0E3AC948F899BDA2D713FA8A340D123FE30F4FDC67C9B132D"
            }
          })
        end
      end
    end

    config.vm.define 'eventstore' do |cfg|
      cfg.vm.network "private_network", ip: "10.0.0.30"
      cfg.vm.provider :azure do |azure, override|
        do_common_azure_stuff.call azure, override
        azure.vm_name = 'eventstore'
        config.vm.provision "chef_solo" do |chef|
          chef.add_recipe "apt"
          chef.add_recipe "ubuntu"
          chef.add_recipe "build-essential"
          chef.add_recipe "ntp"
          chef.add_recipe "git"
          chef.add_recipe "rvm::user"
          chef.add_recipe "mono"
          chef.add_recipe "fsharp"
          chef.add_recipe "dotfiles"
          chef.add_recipe "eventstore"

          chef.json = default_json.merge({
            :eventstore => {
              :source_uri => "http://download.geteventstore.com/binaries/EventStore-OSS-Ubuntu-v3.2.0.tar.gz"
            }
          })
        end
      end
    end

end
