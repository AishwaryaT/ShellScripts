#/bin/bash!

source ~/devstack/openrc admin admin

echo "List all neutron & nova resources"
neutron net-list
echo
neutron router-list
echo
neutron security-group-list
echo
neutron ipsec-site-connection-list
echo
neutron vpn-service-list
echo
neutron vpn-ikepolicy-list
echo
neutron vpn-ipsecpolicy-list
echo
neutron floatingip-list
echo
glance image-list
echo
nova list --all-tenants
