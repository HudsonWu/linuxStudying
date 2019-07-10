# iptables

iptables is a command-line firewall utility that policy chains to allow or block traffic.

+ On a high-level iptables might contain multiple tables.
+ Tables might contain multiple chains.
+ Chains can be built-in or user-defined.
+ Chains might contain multiple rules. Rules are defined for the packets.

## Types of Tables

iptables has the following 4 built-in tables:

1. Filter table

Filter is default table for iptables. <br/>
So, if you don't define you own table, you'll be using filter table. <br/>
Iptables's filter table has the following built-in chains:
  + `INPUT chain`
  + `OUTPUT chain`
  + `FORWARD chain`

2. NAT table

Iptables's NAT table has the following built-in chains:
  + `PREROUTING chain`: Alters packets before routing
    + Packet translation happens immediately after the packet comes to the system(and before routing).
    + This helps to translate the destination ip address of the packets to something that matches the routing on the local server.
    + This is used for DNAT(destination NAT)
  + `POSTROUTING chain`: Alters packets after routing.
    + Packet translation happens when the packets are leaving the system.
    + This helps to translate the source ip address of the packets to something that might match the routing on the destination server.
    + This is used for SNAT(source NAT)
  + `OUTPUT chain`: NAT for locally generated packets on the firewall

3. Mangle table

Iptables's Mangle table is for specialized packet alteration. <br/>
This alters QOS bits in the TCP header. <br/>
Mangle table has the following built-in chains:
  + `PREROUTING chain`
  + `OUTPUT chain`
  + `FORWARD chain`
  + `INPUT chain`
  + `POSTROUTING chain`

4. Raw table

Raw table has the following built-in chains:
  + `PREROUTING chain`
  + `OUTPUT chain`

## Types of Chains

```
Input    This chain is used to control the behavior for incoming connections
Forward    This chain is used for incoming connections that aren't actually being delivered locally
Output    This chain is used for outgoing connections

-L, --list [chain]
    List all rules in the selected chain. If no chain is selected, all chains are listed.
-v, --verbose
    Verbose output
-n, --numeric
    Numeric output
-F, --flush [chain]
    Flush the selected chain(all the chains in the table if none is given)
-A, --append [chain] [rule-specification]
    Append one or more rules to the end of the selected chain
```

## Iptables Rules

1. Rules contain a criteria and a target

2. If the criteria is matched:
  + it goes to the rules specified in the target
  + executes the special values mentioned in the target

3. If the criteria is not matched:
  + it moves on to the next rule
  

```
# If you do 'iptables -t [table] --list', you'll see all the avaliable firewall rules of the table
# if you don't specify the -t option, it will display the default filter table
iptables -t nat --list

# The rules in the 'iptables --list' command output contains the following fields:
num: Rules number
target: Special target variable
prot: Protocols. tcp,udp,icmp,etc
opt: Special options for that specific rule
source: Source ip
destination: Destination ip
```

### Target Values

+ ACCEPT, firewall will accept the packet
+ DROP, firewall will drop the packet
+ QUEUE, firewall will pass the packet to the userspace
+ RETURN, firewall will stop executing the next set of rules in the current chain for this packet, the control will be returned to the calling chain


## Policy Chain Default Behavior

### what do you want iptables to do if the connection doesn't match any existing rules?

+ To see what your policy chains are currently configured to do with unmatched traffic
  + run the 'iptables -L | grep policy' command
+ To accept connections by default
  + iptables --policy INPUT ACCEPT
  + iptables --policy OUTPUT ACCEPT
  + iptables --policy FORWARD ACCEPT
+ To deny all connections by default
  + iptables --policy INPUT DROP
  + iptables --policy OUTPUT DROP
  + iptables --policy FORWARD DROP

## Connection-specific Responses

1. Accept, allow the connection
2. Drop, drop the connection, act like it never happened
3. Reject, don't allow the connection, but send back an error

## Allowing or Blocking Specific Connections

```
# Connections from a single IP address
iptables -A INPUT -s 10.10.10.10 -j DROP

# Connections from a range of IP addresses
iptables -A INPUT -s 10.10.10.0/24 -j DROP
iptables -A INPUT -s 10.10.10.0/255.255.255.0 -j DROP
```

## Connections to a specific port

```
iptables -A INPUT -p tcp --dport ssh -s 10.10.10.10 -j DROP
iptables -A INPUT -p tcp --dport ssh -j DROP
```

## Connection States

What is you only want SSH coming into your system to be allowed, <br/>
won't adding a rule to the output chain also allow outgoing SSH attempts? <br/>
That's where connection states come in, which give you the capability you'd need to <br/>
allow two way communication but only allow one way connections to be established. <br/>

```
iptables -A INPUT -p tcp --dport ssh -s 10.10.10.10 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -d 10.10.10.10 -m state --state ESTABLISHED -j ACCEPT
```

## Saving Changes

```
# Ubuntu
/sbin/iptables-save

# RedHat/CentOS
/sbin/service iptables save
/etc/init.d/iptables save
```
