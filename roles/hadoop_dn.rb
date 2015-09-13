name "hadoop_dn"
description "role for systems acting as a data node in the hadoop cluster"

run_list [
  "role[base]",
  "recipe[hadoop::hadoop_hdfs_datanode]",
  "recipe[hadoop_wrapper::hadoop_dn_start]"
]

