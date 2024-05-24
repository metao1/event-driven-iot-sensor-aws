variable "iot_thing_name" {
  default = "iot_natural"
}

variable "iot_cert_arn" {

}

variable "lambda_function_name" {

}

variable "sql_version" {
  default = "2016-03-23"
}

variable "rule_national_park_habitantes_fire_sql" {
  default = "SELECT * FROM 'queimadas' where co2 >= 7"
}

variable "rule_waters_national_park_sql" {
  default = "SELECT * FROM 'aguas' where ph >= 5"
}

variable "rule_waters_national_park_habitantes_sql" {
  default = "SELECT * FROM 'habitante' where temperatura >= 39"
}

variable "rule_connection_logs" {
  default = "SELECT * FROM '$aws/things/+/shadow/+/accepted'"
}

variable "cloudwatch_log_group_name" {
  default = "iot_logs_group"
}
