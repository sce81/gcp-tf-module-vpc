variable env                    {}
variable name                   {default = "vpc"}
variable ipv4_range             {}
variable subnetwork_ip_range    {type = list(string)}
variable auto-subnets           {default = "false"}
variable routing_mode           {default = "REGIONAL"}
variable region                 {}