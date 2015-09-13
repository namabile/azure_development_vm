role "eventstore"
description "for systems that will host an eventstore server"

run_list "role[base], recipe[eventstore]"

override_attributes [
  "eventstore" => {
    "source_url" => "http://download.geteventstore.com/binaries/EventStore-OSS-Ubuntu-v3.2.0.tar.gz"
  }
]
