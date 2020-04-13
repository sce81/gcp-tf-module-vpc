resource "google_compute_network" "network" {
  name                                  = "${var.env}-vpc"
  routing_mode                          = "${var.routing_mode}"
  auto_create_subnetworks               = "${var.auto-subnets}"
  description                           = "google compute network for ${var.env}"

}

resource "google_compute_subnetwork" "subnet" {
  count                                 = length(var.subnetwork_ip_range)
  name                                  = "${var.env}-${var.name}-subnet-${count.index +1}"
  ip_cidr_range                         = "${element(var.subnetwork_ip_range,count.index)}"
  region                                = "${var.region}"
  network                               = "${google_compute_network.network.name}"
  private_ip_google_access              = true

}


resource "google_compute_router" "router" {
  name                                  = "${var.env}-router"
  region                                = "${var.region}"
  network                               = "${google_compute_network.network.self_link}"
  bgp {
    asn = 64514
}
}

resource "google_compute_address" "address" {
  count                                 = "${var.subnet_count}"
  name                                  = "${var.env}-${var.name}-nat-ip-${count.index +1}"
  region                                = "${var.region}"
}

resource "google_compute_router_nat" "advanced-nat" {
  count                                 = "${var.subnet_count}"                        
  name                                  = "${var.env}-nat-${count.index +1}"
  router                                = "${google_compute_router.router.name}"
  region                                = "${var.region}"
  nat_ip_allocate_option                = "MANUAL_ONLY"
  nat_ips                               = ["${google_compute_address.address.*.self_link[count.index]}"]
  source_subnetwork_ip_ranges_to_nat    = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                                = "${google_compute_subnetwork.subnet.*.self_link[count.index]}"
    source_ip_ranges_to_nat             = ["PRIMARY_IP_RANGE"]
  }
}

