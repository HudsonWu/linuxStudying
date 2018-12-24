# iptables

iptables is a command-line firewall utility that policy chains to allow or block traffic <br/>

On a high-level iptables might contain multiple tables. <br/>
Tables might contain multiple chains. <br/>
Chains can be built-in or user-defined. <br/>
Chains might contain multiple rules. Rules are defined for the packets. <br/>

## Types of Tables

iptables has the following 4 built-in tables <br/>

1. Filter table
Filter is default table for iptables. <br/>
So, if you don't define you own table, you'll be using filter table. <br/>
Iptables's filter table has the following built-in chains: <br/>
`INPUT chain`, `OUTPUT chain`, `FORWARD chain` <br/>

2. NAT table
Iptables's NAT table has the following built-in chains <br/>
`PREROUTING chain`: Alters packets before routing. <br/>
i.e Packet translation happens immediately after the packet comes to the system(and before routing). <br/>
This helps to translate the destination ip address of the packets to something that matches the routing on the local server. <br/>
This is used for DNAT(destination NAT) <br/>
`POSTROUTING chain`: Alters packets after routing. <br/>
i.e Packet translation happens when the packets are leaving the system. <br/>
This helps to translate the source ip address of the packets to something that might match the routing on the destination server. <br/>
This is used for SNAT(source NAT) <br/>
`OUTPUT chain`: NAT for locally generated packets on the firewall <br/>

3. Mangle table
Iptables's Mangle table is for specialized packet alteration. <br/>
This alters QOS bits in the TCP header. <br/>
Mangle table has the following built-in chains: <br/>
`PREROUTING chain`, `OUTPUT chain`, `FORWARD chain`, `INPUT chain`, `POSTROUTING chain` <br/>

4. Raw table
Raw table has the following built-in chains: <br/>
`PREROUTING chain`, `OUTPUT chain` <br/>

## Types of Chains

<pre>
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
</pre>

## Iptables Rules

1. Rules contain a criteria and a target

2. If the criteria is matched, <br/>
it goes to the rules specified in the target(or) executes the special values mentioned in the target

3. If the criteria is not matched, it moves on to the next rule

Target Values: <br/>
ACCEPT, firewall will accept the packet; <br/>
DROP, firewall will drop the packet; <br/>
QUEUE, firewall will pass the packet to the userspace; <br/>
RETURN, firewall will stop executing the next set of rules in the current chain for this packet, <br/>
the control will be returned to the calling chain <br/>

If you do 'iptables -t [table] --list', you'll see all the avaliable firewall rules of the table, <br/>
if you don't specify the -t option, it will display the default filter table <br/>
> iptables -t nat --list <br/>
The rules in the 'iptables --list' command output contains the following fields: <br/>
```
num: Rules number
target: Special target variable
prot: Protocols. tcp,udp,icmp,etc
opt: Special options for that specific rule
source: Source ip
destination: Destination ip
```

## Policy Chain Default Behavior

what do you want iptables to do if the connection doesn't match any existing rules? <br/>
1. To see what your policy chains are currently configured to do with unmatched traffic, <br/>
run the 'iptables -L | grep policy' command <br/>
2. To accept connections by default <br/>
```
iptables --policy INPUT ACCEPT
iptables --policy OUTPUT ACCEPT
iptables --policy FORWARD ACCEPT
```
3. To deny all connections by default
```
iptables --policy INPUT DROP
iptables --policy OUTPUT DROP
iptables --policy FORWARD DROP
```

## Connection-specific Responses

1. Accept, allow the connection
2. Drop, drop the connection, act like it never happened
3. Reject, don't allow the connection, but send back an error

## Allowing or Blocking Specific Connections

1. Connections from a single IP address
> iptables -A INPUT -s 10.10.10.10 -j DROP <br/>
2. Connections from a range of IP addresses
> iptables -A INPUT -s 10.10.10.0/24 -j DROP <br/>
or <br/>
> iptables -A INPUT -s 10.10.10.0/255.255.255.0 -j DROP <br/>

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
Ubuntu: /sbin/iptables-save
RedHat/CentOS: /sbin/service iptables save
/etc/init.d/iptables save
```
