name "hadoop_nn"
description "for systems acting as the hadoop namenode"

run_list [
  "role[base]",
  "recipe[hadoop::hadoop_hdfs_namenode]",
  "recipe[hadoop_wrapper::hadoop_nn_init]",
  "recipe[hadoop_wrapper::hadoop_nn_start]"
]

override_attributes(
  "hadoop" => {
    "distribution" => "cdh"
  }
)
