name "spark"
description "for systems in the spark cluster"

run_list "role[base]", "recipe[spark::install_spark]"

override_attributes [
  "apache_spark" => {
    "download_url" => "http://www.apache.org/dist/spark/spark-1.5.0/spark-1.5.0-bin-hadoop2.6.tgz",
    "checksum" => "d8d8ac357b9e4198dad33042f46b1bc09865105051ffbd7854ba272af726dffc"
  }
]
