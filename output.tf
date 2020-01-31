output "resource_group_name" {
    value = "$azurerm_resource_group.generic.name"
}
output "resource_group_id" {
    value = "$azurerm_resource_group.generic.id"
}
output "lb_id" {
    value = "$azurerm_lb.http.id"
}
output "subnet_id" {
    value = "$azurerm_subnet.http.id"
}