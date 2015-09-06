# vi: set ft=ruby :

Vagrant.configure('2') do |config|
    config.vm.box = 'azure'
    config.vm.box_url = 'https://github.com/msopentech/vagrant-azure/raw/master/dummy.box'

    config.vm.boot_timeout = 600
    config.ssh.username = 'namabile'
    config.ssh.private_key_path = File.expand_path('~/.ssh/azure.pem')

    config.omnibus.chef_version = :latest

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
      chef.add_recipe "build-essential"
      chef.add_recipe "ntp"
      chef.add_recipe "git"
      chef.add_recipe "rvm::user"
      chef.add_recipe "mono"
      chef.add_recipe "fsharp"
      chef.add_recipe "dotfiles"

      chef.json = {
        "rvm" => {
          "namabile" => {
            "rubies" => ["stable"]
          }
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
    end

end
