module "vault" {
  source = "./modules/vault"
  #count = var.create_lc ? 1 : 0

  boundary_aws_hosts = module.boundary_aws_hosts
  boundary_azure_hosts = module.boundary_azure_hosts
  #ssh_key = module.boundary_aws_hosts.ssh_private_key
  aws_db_instance_login_name = var.aws_db_instance_login_name
  aws_db_instance_login_password =  var.aws_db_instance_login_password
    
  depends_on = [
    module.hcp_vault,
    module.boundary_aws_hosts,
    module.boundary_azure_hosts
  ]
}

provider "vault" { 
  add_address_to_env = true
  address = module.hcp_vault.hcp_vault_cluster_public_ip
  token = module.hcp_vault.hcp_vault_cluster_admin_token
  namespace = var.vault_namespace
}