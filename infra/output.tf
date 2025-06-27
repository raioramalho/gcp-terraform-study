// Output url from instance

output "my_instance_url" {    
 value = join("",["http://",google_compute_instance.my_instance.network_interface.0.access_config.0.nat_ip])
}