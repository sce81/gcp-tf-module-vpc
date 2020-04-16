output "vpc_id" {
  value = google_compute_network.network.id
}

output "vpc_name" {
  value = google_compute_network.network.name
}

output "vpc_gateway" {
  value = google_compute_network.network.gateway_ipv4
}

output "vpc_self_link" {
  value = google_compute_network.network.self_link
}

output "subnet_name" {
  value = google_compute_subnetwork.subnet[*].name
}

output "subnet_gateway" {
  value = google_compute_subnetwork.subnet[*].gateway_address
}

output "subnet_id" {
  value = google_compute_subnetwork.subnet[*].id
}

output "subnet_self_link" {
  value = google_compute_subnetwork.subnet[*].self_link
}

output "router_id" {
  value = google_compute_router.router.id
}

output "router_name" {
  value = google_compute_router.router.name
}

output "address_id" {
  value = google_compute_address.address[*].id
}

output "address_self_link" {
  value = google_compute_address.address[*].self_link
}

output "nat_id" {
  value = google_compute_router_nat.nat[*].id
}

