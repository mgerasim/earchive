route add -net 10.198.0.0/16 gw 10.198.1.252
route add -net 0.0.0.0/0 gw 10.198.1.190
route delete -net 0.0.0.0/0 gw 10.198.1.252

bundle install

route add -net 0.0.0.0/0 gw 10.198.1.252
route delete -net 0.0.0.0/0 gw 10.198.1.190
route delete -net 10.198.0.0/16 gw 10.198.1.252
