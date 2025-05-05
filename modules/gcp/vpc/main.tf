locals {
  subnet_region = var.subnet_region != "" ? var.subnet_region : var.region
  
  # Define default routes
  default_routes = [
    {
      name                   = "egress-internet"
      description            = "route through IGW to access internet"
      destination_range      = "0.0.0.0/0"
      tags                   = "egress-inet"
      next_hop_internet      = "true"
    }
  ]
}

module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 10.0"

    project_id   = var.project_id
    network_name = var.network_name
    routing_mode = var.routing_mode
    delete_default_internet_gateway_routes = false
    subnets = [
        {
            subnet_name           = "${var.subnet_prefix}-public-01"
            subnet_ip             = var.subnet_cidrs.public_01
            subnet_region         = local.subnet_region
            subnet_private_access = "false"  # Public subnet should have direct internet access
            subnet_enable_flow_logs = true
        },
        {
            subnet_name           = "${var.subnet_prefix}-private-01"
            subnet_ip             = var.subnet_cidrs.private_01
            subnet_region         = local.subnet_region
            subnet_private_access = "true"
            subnet_enable_flow_logs = true
        },
        {
            subnet_name           = "${var.subnet_prefix}-public-02"
            subnet_ip             = var.subnet_cidrs.public_02
            subnet_region         = local.subnet_region
            subnet_private_access = "false"  # Public subnet should have direct internet access
            subnet_enable_flow_logs = true
        },
        {
            subnet_name           = "${var.subnet_prefix}-private-02"
            subnet_ip             = var.subnet_cidrs.private_02
            subnet_region         = local.subnet_region
            subnet_private_access = "true"
            subnet_enable_flow_logs = true
        },
        {
            subnet_name           = "${var.subnet_prefix}-public-03"
            subnet_ip             = var.subnet_cidrs.public_03
            subnet_region         = local.subnet_region
            subnet_private_access = "false"  # Public subnet should have direct internet access
            subnet_enable_flow_logs = true
        },
        {
            subnet_name           = "${var.subnet_prefix}-private-03"
            subnet_ip             = var.subnet_cidrs.private_03
            subnet_region         = local.subnet_region
            subnet_private_access = "true"
            subnet_enable_flow_logs = true
        }
    ]

    # Use the default routes instead of var.routes to avoid the error
    routes = local.default_routes
    firewall_rules = [
      {
        name                    = "${var.network_name}-in-all"
        description             = "Allow all inbound traffic"
        direction               = "INGRESS"
        priority                = 100  # Lower number = higher priority
        source_ranges           = ["0.0.0.0/0"]
        allow = [{
          protocol = "all"
          ports    = []
        }]
      },
      {
        name                    = "${var.network_name}-out-all"
        description             = "Allow all outbound traffic"
        direction               = "EGRESS"
        priority                = 100  # Lower number = higher priority
        destination_ranges      = ["0.0.0.0/0"]
        allow = [{
          protocol = "all"
          ports    = []
        }]
      }
    ]
}

#module for NAT gateway
module "cloud_nat" {
    source        = "terraform-google-modules/cloud-nat/google"
    version       = "~> 5.0"
    
    project_id    = var.project_id
    region        = local.subnet_region
    network       = module.vpc.network_name
    create_router = true
    router        = "${var.network_name}-router"
    depends_on    = [module.vpc]
}