#added for getting tokan access
resource "null_resource" "accesstoken" {
  provisioner "local-exec" {
    command = "az login --service-principal --tenant ${var.tenant_id} --username ${var.client_id} --password ${var.client_secret}"
  }
    provisioner "local-exec" {
    command = "az account get-access-token --resource  ${var.resource_type} --query \"accessToken\" --output tsv > accesstoken.txt"
    
  }
}
data "template_file" "accesstokentemplatefile" {
    template = "./accesstoken.txt"
}

data "local_file" "accesstokenfile" {
    depends_on = [null_resource.accesstoken]
    filename = "${data.template_file.accesstokentemplatefile.rendered}"
    
}

output "accesstoken" {
    value= "${chomp("${data.local_file.accesstokenfile.content}")}"
    
}

# resource "null_resource" "deleteaccesstokenfile" {
#     depends_on = [databricks_cluster.this ]
#   provisioner "local-exec" {
#     command = "del accesstoken.txt"
#   }
    
# }
