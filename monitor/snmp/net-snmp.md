## The General Structure of SNMP Commands

When using the suite of tools included in the snmp package(the net-snmp software suite), you will notice a few patterns in the way you must call the commands.

The first thing you must do is authenticate with the SNMP daemon that you wish to communicate with. This usually involves supplying quite a few pieces of information. The common ones are below:

  -v VERSION: This flag is used to specify the version of the SNMP protocol that you would like to use. we will bu using v3 in this guide

  -c COMMUNITY: This flag is used if you are using SNMP v1 or v2-style community string for authentication. Since we are using v3-style user-based authentication, we will not be needing this

  -u USER-NAME: This parameter is used to specify the username that you wish to authenticate as. To read or modify anything using SNMP, you must authenticate with a known username

  -l LEVEL: This is used to specify the security level that you are connecting with. The possible values are "noAuthNoPriv" for no authentication and no encryption, "authNoPriv" for authentication but no encryption, and "authPriv" for authentication and encryption. The username that you are using must be configured to operate at the security level you specify, or else the authentication will not succeed

  -a PROTOCOL: This parameter is used to specify the authentication protocol that is used. The possible values are "MD5" or "SHA". This must match the information that was specified when the user was created

  -x PROTOCOL: This parameter is used to specify the encryption protocol that is used. The possible values are "DES" OR "AES". This must match the information that was specified when the user was created. This is necessary whenever the user's privilege specification has "priv" after it, making encryption mandatory

  -A PASSPHRASE: This is used to give the authentication passphrase that was specified when the user was created

  -X PASSPHRSE: This is the encryption passphrase that was specified when the user was created. If none was specified but an encryption algorithm was given, the authentication passphrase will be used. This is required when the "-x" parameter is given or whenever a user's privilege specification has a "priv" after it, requiring encryption

## Usage

```
snmp_command -u bootstrap -l authPriv -a MD5 -x DES -A temp_password -X temp_password remote_host snmp_sub_command_or_options
```

For instance, from management server, you can test to make sure your bootstrap account is available by typing:
```
snmpget -u bootstrap -l authPriv -a MD5 -x DES -A temp_password -X temp_password remote_host 1.3.6.1.2.1.1.1.0
```
The 1.3.6.1.2.1.1.1.0 string is the OID that is responsible for displaying system information. It will basically return the output of "uname -a" on the remote system

## Refer

+ [Net-SNMP Documentation](http://www.net-snmp.org/docs/man/)
