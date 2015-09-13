name "base"
description "base role: sets up basic development tools and languages"

run_list [
  "recipe[apt]",
  "recipe[ubuntu]",
  "recipe[build-essential]",
  "recipe[ntp]",
  "recipe[git]",
  "recipe[rvm::user]",
  "recipe[java]",
  "recipe[scala]",
  "recipe[simple-scala-sbt]",
  "recipe[anaconda]",
  "recipe[dotfiles]"
]

default_attributes(
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
  },
  :anaconda => {
    :owner => "namabile",
    :group => "namabile",
    :flavor => "x86_64",
    :accept_license => "yes"
  },
  :java => {
    :install_flavor => "oracle",
    :jdk_version => "7",
    :oracle => {
          "accept_oracle_download_terms" => true
      }
    }
)
