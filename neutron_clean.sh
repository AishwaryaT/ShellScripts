#/bin/bash!
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

neutron ipsec-site-connection-list
neutron vpn-service-list
neutron vpn-ipsecpolicy-list
neutron vpn-ikepolicy-list
neutron router-list 
neutron net-list
neutron security-group-list
nova list --all-tenants
