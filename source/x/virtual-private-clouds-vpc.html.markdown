---
title: Virtual Private Clouds
---

<h1>Virtual Private Clouds</h1>

## Home Networks

The reason all your home IPs start with `192.168...` is not just convention.

The IPv4 spec defines 3 private address ranges

192.168.0.0/16 (2^16 = 65,536 IPs)
172.16.0.0/12 (2^20 = 1,048,576 IPs)
10.0.0.0/8 (2^24 = 16,777,216 IPs)

## 192.168.0.0/16 - CIDR blocks

`192.168.0.0/16` is a CIDR block. It defines a continuous block of IP addresses, starting at 192.168.0.0 and counting up.

The number of IP addresses is determined by the `/16`.
An IP is 32 bits, and `/32` means "all 32 bits are fixed"  (so, there's 2^0 = 1 IPs)
`/31` means "first 31 bits are fixed, last 1 bit can vary (so, there's 2^1 = 2 IPs)
`/30` means "first 30 bits are fixed, last 2 bits can vary (so, there's 2^2 = 4 IPs)

So the CIDR `192.168.0.0/30` means these 4 IP addresses:
`192.168.0.0`
`192.168.0.1`
`192.168.0.2`
`192.168.0.3`

Of the three private address ranges, home networks use the smallest - `192.168.0.0/16`.

So that's why all the IPs start with `192.168...`
No computer on the internet can be allocated any of these private addresses. When your computer sends a request to `192.168.1.1`, your router knows eg "this goes to the printer, not out to the internet".

Your home network is a collection of computers in your house that are physically together, connected by wire or wireless communication.

It is a physical network, not a virtual network.
If you wanted to add a computer that's 200m away, you'd need a 200m long ethernet cable to add it to this physical network.

## Virtual Private Cloud

A VPC isn't a physical network - it's a virtual one. That means, a handful of computers (or virtual computers) are taken from a pool, and software is configured so they can communicate with one another securely. It's software, not physical wire, that connects the VPC together, and excludes other computers from it.

A handful of components / ideas make up a VPC.

## Subnet

A subnet is a single, continuous block of IP addresses. This block must be a subset of the VPC's block.

## NACLs - Network Access Control Lists

A NACL is a firewall for a subnet. It determinse what traffic is allowed in, and out, of the subnet. But traffic within the subnet does not need to touch the NACL.

It's a list of rules - eg. 

| Rule Number | Source IP    | Destination IP | Protocol | Action  |
|-------------|--------------|----------------|----------|---------|
| 1           | 192.168.1.0  | 10.0.0.0       | TCP      | ALLOW   |
| 2           | 10.0.0.0     | 192.168.1.0    | UDP      | ALLOW   |
| 3           | 0.0.0.0/0    | 0.0.0.0/0      | ICMP     | DENY    |

NACL rules have a number, are evaluated in ascending order, and evaluation stops as soon as the first matching rule is reached.

NACLs are stateless. If you allow SSH traffic in on port 22, you must also allow it out for things to work (as opposed to a security group, which applies to a computer, and is stateful - if you allow SSH traffic in on port 22, it remembers and lets the response to an incoming request back out).

## Route Table

Each subnet has a route table. Routers direct traffic between networks. So you can define routing rules to say eg. "Route IP range X to Subnet A, IP range Y to Subnet B, and everything else to the internet".

## Public vs Private Subnets

If the route table of a subnet has even a single rule pointing to the internet, that subnet is a public subnet. Otherwise, it is a private subnet.

## Internet Gateways vs NAT Gateways

A public subnet can contain an internet gateway. The IG will allow both outbound requests, and inbound requests.

A NAT gateway does not allow inbound requests. It handles outbound requests on behalf of instances within a private subnet. NAT stands for Network Address Translation. If an instance within a private subnet wants to make a request to the internet, it needs a public IP address so the response can be routed back. The request is sent via the NAT Gateway, which says "OK, private IP A will be mapped to public IP B, and when the response to Public IP B comes back to me, I know to route it back to private IP A."

NAT Gateways require internet access, so must be placed in a public subnet.

So if an instance in a private subnet, and makes a request to internet, it'll be like this:

private instance -> private subnet route table (says to go to NAT in public subnet) -> private subnet NACL -> public subnet NACL -> public subnet route table -> NAT gateway (maps private IP to a public one) -> internet (and the response goes back through the same steps)

## AWS VPCs

In AWS, a subnet must be within a single AZ. A VPC may contain subnets in different AZs, but they must all be in the one region. VPC peering can be used to connect VPCs in different regions - but they must have different IP address ranges. See [AWS VPC Peering Basics](https://docs.aws.amazon.com/vpc/latest/peering/vpc-peering-basics.html).

In AWS, you can set up gateways from private subnets to AWS resources, to avoid going over the public internet. These stay on AWS's own networks.

## VPC Endpoints

VPC endpoints allow you to privately connect your VPC to supported AWS services without requiring an internet gateway, NAT device, etc.

The traffic stays on AWS's private network.

## Security Groups

Security groups act as virtual firewalls for your instances to control inbound and outbound traffic.

Unlike NACLs, security groups are stateful. If you allow inbound connections on port 22, they'll keep track of that connection and allow the response traffic to return outbound on port 22 automatically.

