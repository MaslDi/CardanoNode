# CardanoNode
1. Setup and 2. Run Cardano Node
3. Generate Keys for transaction with mnemonic phrases (wallets) 
4. Send transactions


## 1. Setup Cardano Node 
-> settingUpNode.md
https://developers.cardano.org/docs/get-started/running-cardano/

## 2. Run Cardano Node
-> runningNode.md

## 3. Generate Keys for transaction (Mnemoics from Nami, Eternl or Yoroi Wallet)

./convMnemonic2Keys.sh < mnemonicsinputfile > < outputname >

-> input mnemonic into testmnemonics.txt

run sh script
```
./convMnemonic2Keys.sh testmnemonics.txt test
```

generates:
  - test.payment.addr
  - test.payment.skey
  - test.payment.vkey
  - test.staking.addr
  - test.staking.skey
  - test.staking.vkey
  
## Send transaction

https://github.com/gitmachtl/scripts/tree/master/cardano/mainnet  (Lot of scripts with different functions)

```
git clone https://github.com/gitmachtl/scripts/tree/master/cardano/mainnet
```

Change settings in 00_common.sh to your settup

Node has to be running and in synch. Query your test address:

For example - queryAddress:
```
./01_queryAddress.sh test.payment.addr
```

For example - send ADA to another address: 
Send 2 ADA from your address to a random one:
```
./01_sendLovelaces.sh test.payment.addr addr1qXYZ.... 2000000
```

  

  
