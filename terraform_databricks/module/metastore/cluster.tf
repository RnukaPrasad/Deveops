# Create the cluster with the "smallest" amount
# of resources allowed.
data "databricks_node_type" "smallest" {
  local_disk = true
}

# Use the latest Databricks Runtime
# Long Term Support (LTS) version.
# data "databricks_spark_version" "latest_lts" {
#  long_term_support = true
#}

resource "databricks_cluster" "this" {
  depends_on = [ databricks_catalog.catalog ]
  cluster_name            = var.cluster_name
  node_type_id            = data.databricks_node_type.smallest.id
  spark_version           = var.spark_version #"13.3 LTS (Scala 2.12, Spark 3.4.1)"
  autotermination_minutes = var.cluster_autotermination_minutes
  num_workers             = var.cluster_num_workers
  data_security_mode      = var.cluster_data_security_mode

  library {
    # Install fsspec library
    pypi {
      package = "fsspec==0.9.0"
    }
  }

  library {
    # Install openpyxl library
    pypi {
      package = "openpyxl==3.0.14"
    }
  }

  library {
    # Install pyarrow library
    pypi {
      package = "pyarrow==5.0.0"
    }
  }

  library {
    # Install xlrd library
    pypi {
      package = "xlrd==2.0.1"
    }
  }

  library {
    # Install spark-excel library
    maven {
      coordinates = "com.crealytics:spark-excel_2.12:3.4.1_0.19.0"
      repo = "https://repo1.maven.org/maven2"
    }
  }
}

 

output "cluster_url" {
 value = databricks_cluster.this.url
}
