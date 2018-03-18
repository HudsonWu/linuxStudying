1. using the apt-key utility we can display all the known keys
apt-key list
apt-key list | grep "expired:"  # to quickly find the expired keys
2. update the key:
apt-key adv --keyserver keys.gnupg.net --recv-keys [key]
3. verify that you now have the key with the fingerprint
apt-key fingerprint [key]
