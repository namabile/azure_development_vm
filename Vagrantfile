# vi: set ft=ruby :

Vagrant.configure('2') do |config|
    config.vm.box = 'azure'

    config.vm.provider :azure do |azure, override|
        # Mandatory Settings
        azure.mgmt_certificate = 'YOUR AZURE MANAGEMENT CERTIFICATE'
        azure.mgmt_endpoint = 'https://management.core.windows.net'
        azure.subscription_id = ENV["AZURE_SUBSCRIPTION_ID"]
        azure.vm_image = 'NAME OF THE IMAGE TO USE'
        azure.vm_name = 'PROVIDE A NAME FOR YOUR VIRTUAL MACHINE' # max 15 characters. contains letters, number and hyphens. can start with letters and can end with letters and numbers

        # vm_password is optional when specifying the private_key_file with Linux VMs
        # When building a Windows VM and using WinRM this setting is used to authenticate via WinRM (PowerShell Remoting)
        azure.vm_password = 'PROVIDE A VALID PASSWORD' # min 8 characters. should contain a lower case letter, an uppercase letter, a number and a special character

        # Optional Settings
        azure.storage_acct_name = 'NAME OF YOUR STORAGE ACCOUNT' # optional. A new one will be generated if not provided.
        azure.vm_user = 'PROVIDE A USERNAME' # defaults to 'vagrant' if not provided
        azure.cloud_service_name = 'PROVIDE A NAME FOR YOUR CLOUD SERVICE' # same as vm_name. leave blank to auto-generate
        azure.deployment_name = 'PROVIDE A NAME FOR YOUR DEPLOYMENT' # defaults to cloud_service_name
        azure.vm_location = 'PROVIDE A LOCATION FOR VM' # e.g., West US

        # Optional *Nix Settings
        azure.ssh_port = 'A VALID PUBLIC PORT' # defaults to 22
        azure.private_key_file = 'Path to your ssh private key file (~/.ssh/id_rsa) to use for passwordless auth. If the id_rsa file is password protected, you will be prompted for the password.'

        # Optional Windows Settings
        azure.winrm_transport = [ 'http', 'https' ] # this will open up winrm ports on both http (5985) and http (5986) ports
        azure.winrm_https_port = 'A VALID PUBLIC PORT' # customize the winrm https port, instead of 5986
        azure.winrm_http_port = 'A VALID PUBLIC PORT' # customize the winrm http port, insted of 5985
        azure.tcp_endpoints = '3389:53389' # opens the Remote Desktop internal port that listens on public port 53389. Without this, you cannot RDP to a Windows VM.
    end
end
