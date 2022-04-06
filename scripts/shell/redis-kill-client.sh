#redis-cli -c -h 10.50.1.21 -p 7600 client list
#redis-cli -c -h 10.50.1.21 -p 7601 client list
#redis-cli -c -h 10.50.1.21 -p 7602 client list
#redis-cli -c -h 10.50.1.21 -p 7603 client list
#redis-cli -c -h 10.50.1.21 -p 7604 client list
#redis-cli -c -h 10.50.1.21 -p 7605 client list
#redis-cli -c -h 10.50.1.21 -p 7606 client list
#redis-cli -c -h 10.50.1.21 -p 7607 client list
#redis-cli -c -h 10.50.1.21 -p 7608 client list


redis-cli -c -h 10.50.1.21 -p 7600 cluster nodes | cut -d' ' -f2 | cut -d@ -f1 | sed 's/:/ /g' | while read host port ; do redis-cli -c -h $host -p $port <<EOF
CLIENT KILL TYPE normal
CLIENT KILL TYPE slave
CLIENT KILL TYPE pubsub
EOF
done

redis-cli -c -h 10.50.1.21 -p 8100 cluster nodes | cut -d' ' -f2 | cut -d@ -f1 | sed 's/:/ /g' | while read host port ; do redis-cli -c -h $host -p $port <<EOF
CLIENT KILL TYPE normal
CLIENT KILL TYPE slave
CLIENT KILL TYPE pubsub
EOF
done
