output "subnets" {
  value  = {for zone, subnet in var.public-subnets : upper(zone) => subnet["Name"] } 
}
