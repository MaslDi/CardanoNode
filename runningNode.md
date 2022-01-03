# CardanoNode

## Run your Node on your host addr according to your ipv4 / 6 address

cardano-node run \
   --topology mainnet-topology.json \
   --database-path cardano/db \
   --socket-path cardano/db/node.socket \
   --host-addr 137.184.68.153 \
   --port 1337 \
   --config mainnet-config.json
   

## Syn is starting and it will take a couple hours. After sync is done open new terminal and check blockchain status.

cardano-cli query tip --mainnet


Should look like:
{
    "epoch": 309,
    "hash": "42a0d73dfa4899a7eabf73fc39228c92f99d6da7b8f32a61260eb4095f712e8b",
    "slot": 48294604,
    "block": 6644997,
    "era": "Alonzo",
    "syncProgress": "99.00"
}

Blockchain is sync to 99%


If 
cardano-cli: Network.Socket.connect: <socket: 11>: does not exist (No such file or directory)
then Node is not started yet. You might wait until it starts (max 30mins)




Cardano Syn Pools:
https://a.adapools.org/topology?limit=50





