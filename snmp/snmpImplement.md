1. Install the SNMP Daemon and Utilities
We will use two servers, one will contain the manager portion, while the other server have the agent.
1) manager
-- apt-get install snmp snmp-mibs-downloader --
(snmp-mibs-downloader, which contains some proprietary(专有的) information about standard MIBs that allow us to access most of the MIB tree by name)
2) agent
-- apt-get install snmpd --

2. Configuring the SNMP Manager
We just need to modify one file to make sure that our client can use the extra MIB data we installed
/etc/snmp/snmp.conf
In this file, there are a few comments and a single un-commented line. To allow the manager to import the MIB files, we simply need to comment out the "mlib :" line

3. Configuring the SNMP Agent Machine
/etc/snmp/snmpd.conf
Inside, we will have to make a few changes. These will mainly be used to bootstrap out configuration so that we can manage it from our other server
1)   agentAddress udp:127.0.0.1:161
 --> agentAddress udp:161,udp6:[::1]:161
2) createUser bootstrap MD5 temp_password DES
We will need to temporarily insert a "createUser" line. These directives are not normally kept in this file, but we will be removing it again in amoment, so it doesn't matter too much
The user we are creating will be called "bootstrap" and will be used as a template in which to create our first "real" user. The SNMP packages do this through a process of cloning the user's properties
When defining a new user, you must specify the authentication type(MD5 or SHA) as well as supply a passphrase that must be at least 8 characters. If you plan on using encryption for the transfer, you also must specify the privacy protocol(DES or AES) and optionally a privacy protocol passphrase. If no privacy protocol passphrase is supplied, the authentication passphrase will be used for the privacy protocol as well
3) rwuser bootstrap priv
   rwuser demo priv
We need to set up the level of access that this user will have, and also for the new user we will be creating, called demo. We will allow them read and write access by using the rwuser directive(the alternative is rouser for read-only access)
We will enforce the use of encryption by specifying priv after our user. If we wanted to restrict the user to a specific part of the MIB, we could specify the highest-level OID that the user should have access to at the end of the line
To implement these changes, restart the snmpd service

4. Now, from the machine that you installed the management software on, we can connect to our agent server to create our regular user
1) Test to make sure your bootstrap account is available
-- snmpget -u bootstrap -l authPriv -a MD5 -x DES -A temp_password -X temp_password remote_host 1.3.6.1.2.1.1.1.0 --
2) Set Up the Regular User Account
Although we have specified the privileges for the demo user account in our snmpd.conf file, we haven't actually created this user yet. We are going to use the bootstrap user as a template for our new user.
On the management server, we can create the user from the template using the snmpusm tool and the following general syntax:
-- snmpusm authentication_info remote_host create new_user existing_user --
For instance:
-- snmpusm -u bootstrap -l authPriv -a MD5 -x DES -A temp_password -X temp_password remote_host create demo bootstrap
3) Change the password to something else(passwords must be at least 8 characters long)
-- snmpusm -u demo -l authPriv -a MD5 -x DES -A temp_password -X temp_password remote_host passwd temp_passwd my_new_password --
4) Test our new credentials and password
-- snmpget -u demo -l authPriv -a MD5 -x DES -A my_new_password -X my_new_password remote_host sysUpTime.0 --
You shoule get back a value that represents the last time that the remote SNMP daemon was restarted

5. Creating a Client Configuration File
The client configuration file can be placed in two different locations depending on how wide_spread you wish to share it
If you want to share your login credentials with any valid user on your management machine, you can place your configuration details into the global snmp.conf file. 
-- vi /etc/snmp/snmp.conf --
If, however, you want to define the authentication credentials for user alone, you can create a hidden .snmp directory within your user's home directory, and create the file there:
-- mkdir ~/.snmp --
-- cd ~/.snmp --
-- vi snmp.conf --
The commands that we are using to authenticate are in the table below:
-------------------------------------------------------------------------------------------------
 Command Flag            Description                        Translated snmp.conf directive
-u USERNAME      The SNMPv3 username to authenticate as       defSecurityName USERNAME
-l authPriv      The security level to authenticate with      defSecurityLevel authPriv
-a MD5           The authentication protocol to use           defAuthType MD5
-x DES           The privacy(encryption) protocol to use      defPrivType DES
-A PASSPHRASE    The authentication passphrase                def AuthPassphrase PASSPHRASE
-X PASSPHRASE    The privacy passphrase                       def PrivPassphrase PASSPHRASE
-------------------------------------------------------------------------------------------------
snmp.conf:
----------------------------------
defSecurityName demo
defSecurityLevel authPriv
defAuthType MD5
defPrivType DES
defAuthPassphrase my_new_password
defPrivPassphrase my_new_password
----------------------------------
test:
-- snmpget remote_host sysUpTime.0 --

6. Removing the Bootstrap Account
Now that your regular account is configured correctly, we can remove the bootstrap account, since it is fairly insecure
On agent server, /etc/snmp/snmpd.conf:
# createUser bootstrap MD5 temp_password DES
# rwuser bootstrap priv
Now, restart the SNMP daemon
If you want to completely remove the bootstrap user from the usmUserTable, you can do so by issuing this command from the management server:
-- snmpusm remote_host delete bootstrap --

