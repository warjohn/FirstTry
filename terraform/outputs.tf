output "server_ip" {
  description = "Public IPv4 address of the deployed server"
  value       = twc_server_ip.master_ipv4.ip
}