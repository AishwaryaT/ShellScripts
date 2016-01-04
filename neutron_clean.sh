#/bin/bash!
#
# tips:
# 1. remove "grep rally" if you want to delete non rally created resources as well
# 2. change "grep 172" in case of floatingip. 172 here is the starting of puplic ip

source ~/devstack/openrc admin admin

echo "Clean Up Script Started"
echo -e "\n"
echo -e "It cleans up all rally created resources including \n1.ipsec-site-connections \n2.vpn-services \n3.ikepolicies \n4.ipsecpolicies \n5.routers \n6.networks \n7.secgroups \n8.nova instances \n9.keypairs."

neutron ipsec-site-connection-list | grep rally | while read x; do
id=$(echo $x| awk '{ print $2;}')
neutron ipsec-site-connection-delete $id;
done

neutron vpn-service-list | grep rally | while read x; do
id=$(echo $x| awk '{ print $2;}')
neutron vpn-service-delete $id;
done

neutron vpn-ipsecpolicy-list | grep rally | while read x; do  
id=$(echo $x| awk '{ print $2;}') 
neutron vpn-ipsecpolicy-delete $id;
done

neutron vpn-ikepolicy-list | grep rally | while read x; do
id=$(echo $x| awk '{ print $2;}')
neutron vpn-ikepolicy-delete $id;
done

neutron floatingip-list | grep 172| while read x; do
id=$(echo $x| awk '{ print $2;}')
neutron floatingip-delete $id;
done

neutron router-list | grep rally | while read x; do
id=$(echo $x| awk '{ print $2;}')
neutron router-gateway-clear $id;
subnet=$(neutron router-port-list $id | awk '/subnet_id/' | awk -F'"' '{print $4}')
neutron router-interface-delete $id $subnet;
neutron router-delete $id; 
done

neutron net-list | grep rally | while read x; do
id=$(echo $x| awk '{ print $2;}')
neutron net-delete $id;
done

neutron security-group-list | grep rally | while read x; do
id=$(echo $x| awk '{ print $2;}')
neutron security-group-delete $id;
done

nova list --all-tenants| grep rally| while read x; do
id=$(echo $x| awk '{ print $2;}')
nova delete $id;
done

rm -f /tmp/rally_keypair*

neutron ipsec-site-connection-list
neutron vpn-service-list
neutron vpn-ipsecpolicy-list
neutron vpn-ikepolicy-list
neutron floatingip-list
neutron router-list 
neutron net-list
neutron security-group-list
nova list --all-tenants
