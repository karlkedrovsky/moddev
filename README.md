# Vagrant VM For Basic Module Development Presentation

This contains the vagrant file for setting up a VM with an
installation of Drupal used for my presentation at the 1/28/2014 KC
Drupal Users Group meeting. To use it just do the following.

1. Install [VirtualBox](https://www.virtualbox.org/)
1. Install [Vagrant](http://www.vagrantup.com/)
1. git clone https://github.com/karlkedrovsky/moddev.git
1. cd moddev
1. vagrant up

After that you should be able to go to http://10.1.0.31 and log in
using a user name of "admin" and the password "admin".

You might want to take a look at the Vagrantfile to make sure the IP
(and anything else) don't conflict with your maching. It would also be
handy to update your hosts file to point the host "moddev" to the IP
address in Vagranfile.

The VM contains an NFS export of the docroot of the site so that you
can mount it from the host and use your favorite editor to edit
files. I use a start.sh and stop.sh script to start/stop my VMs and
take care of mounting and unmounting the shares. Just take a look at
them and you'll see how it's done.
