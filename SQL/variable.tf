variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
}

variable "sql_database_name" {
  description = "Name of the SQL Database"
  type        = string
}

variable "sql_admin_username" {
  description = "SQL Server admin username"
  type        = string
}

variable "sql_admin_password" {
  description = "SQL Server admin password"
  type        = string
  sensitive   = true
}

variable "resource_group_name" {
  description = "Resource Group where SQL Server will be deployed"
  type        = string
}

variable "location" {
  description = "Azure region for the SQL Server"
  type        = string
}
