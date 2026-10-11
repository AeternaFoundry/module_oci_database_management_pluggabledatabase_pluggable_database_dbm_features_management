variable "database_management_pluggabledatabase_pluggable_database_dbm_features_managements" {
  description = <<EOT
Map of database_management_pluggabledatabase_pluggable_database_dbm_features_managements, attributes below
Required:
    - enable_pluggable_database_dbm_feature
    - pluggable_database_id
Optional:
    - feature
    - modify_pluggable_database_dbm_feature
    - feature_details (block):
        - can_enable_all_current_pdbs (optional)
        - connector_details (optional, block):
            - connector_type (optional)
            - database_connector_id (optional)
            - management_agent_id (optional)
            - private_end_point_id (optional)
        - database_connection_details (optional, block):
            - connection_credentials (optional, block):
                - credential_name (optional)
                - credential_type (optional)
                - named_credential_id (optional)
                - password_secret_id (optional)
                - role (optional)
                - ssl_secret_id (optional)
                - user_name (optional)
            - connection_string (optional, block):
                - connection_type (optional)
                - port (optional)
                - protocol (optional)
                - service (optional)
        - feature (required)
        - is_auto_enable_pluggable_database (optional)
        - management_type (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    enable_pluggable_database_dbm_feature = bool
    pluggable_database_id                 = string
    feature                               = optional(string)
    modify_pluggable_database_dbm_feature = optional(bool)
    feature_details = optional(object({
      can_enable_all_current_pdbs = optional(bool)
      connector_details = optional(object({
        connector_type        = optional(string)
        database_connector_id = optional(string)
        management_agent_id   = optional(string)
        private_end_point_id  = optional(string)
      }))
      database_connection_details = optional(object({
        connection_credentials = optional(object({
          credential_name     = optional(string)
          credential_type     = optional(string)
          named_credential_id = optional(string)
          password_secret_id  = optional(string)
          role                = optional(string)
          ssl_secret_id       = optional(string)
          user_name           = optional(string)
        }))
        connection_string = optional(object({
          connection_type = optional(string)
          port            = optional(number)
          protocol        = optional(string)
          service         = optional(string)
        }))
      }))
      feature                           = string
      is_auto_enable_pluggable_database = optional(bool)
      management_type                   = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.database_management_pluggabledatabase_pluggable_database_dbm_features_managements : (
        v.feature == null || (contains([for v in ["DB_LIFECYCLE_MANAGEMENT", "DIAGNOSTICS_AND_MANAGEMENT", "SQLWATCH"] : lower(v)], lower(v.feature)))
      )
    ])
    error_message = "must be one of: \"DB_LIFECYCLE_MANAGEMENT\", \"DIAGNOSTICS_AND_MANAGEMENT\", \"SQLWATCH\""
  }
  validation {
    condition = alltrue([
      for k, v in var.database_management_pluggabledatabase_pluggable_database_dbm_features_managements : (
        v.feature_details == null || (contains([for v in ["DB_LIFECYCLE_MANAGEMENT", "DIAGNOSTICS_AND_MANAGEMENT", "SQLWATCH"] : lower(v)], lower(v.feature_details.feature)))
      )
    ])
    error_message = "must be one of: \"DB_LIFECYCLE_MANAGEMENT\", \"DIAGNOSTICS_AND_MANAGEMENT\", \"SQLWATCH\""
  }
  validation {
    condition = alltrue([
      for k, v in var.database_management_pluggabledatabase_pluggable_database_dbm_features_managements : (
        v.feature_details == null || (v.feature_details.connector_details == null || (v.feature_details.connector_details.connector_type == null || (contains([for v in ["DIRECT", "EXTERNAL", "MACS", "PE"] : lower(v)], lower(v.feature_details.connector_details.connector_type)))))
      )
    ])
    error_message = "must be one of: \"DIRECT\", \"EXTERNAL\", \"MACS\", \"PE\""
  }
  validation {
    condition = alltrue([
      for k, v in var.database_management_pluggabledatabase_pluggable_database_dbm_features_managements : (
        v.feature_details == null || (v.feature_details.database_connection_details == null || (v.feature_details.database_connection_details.connection_credentials == null || (v.feature_details.database_connection_details.connection_credentials.credential_type == null || (contains([for v in ["DETAILS", "NAMED_CREDENTIAL", "NAME_REFERENCE", "SSL_DETAILS"] : lower(v)], lower(v.feature_details.database_connection_details.connection_credentials.credential_type))))))
      )
    ])
    error_message = "must be one of: \"DETAILS\", \"NAMED_CREDENTIAL\", \"NAME_REFERENCE\", \"SSL_DETAILS\""
  }
  validation {
    condition = alltrue([
      for k, v in var.database_management_pluggabledatabase_pluggable_database_dbm_features_managements : (
        v.feature_details == null || (v.feature_details.database_connection_details == null || (v.feature_details.database_connection_details.connection_string == null || (v.feature_details.database_connection_details.connection_string.connection_type == null || (contains([for v in ["BASIC"] : lower(v)], lower(v.feature_details.database_connection_details.connection_string.connection_type))))))
      )
    ])
    error_message = "must be one of: \"BASIC\""
  }
}

