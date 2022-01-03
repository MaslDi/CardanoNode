# CardanoNode
Create Node, integrate mnemoric phrases (wallets) and send transactions


# Setup Cardano Node 
-> settingUpNode.md
https://developers.cardano.org/docs/get-started/running-cardano/

# Run Cardano Node
-> runningNode.md

# Generate Keys for transaction (Mnemoics from Nami or Yoroi Wallet)
./convMnemonic2Keys.sh <mnemonicsinputfile> <outputname>

for example:
./convMnemonic2Keys.sh testmnemonics.txt test
  
generates:
  test.payment.addr
  test.payment.skey
  test.payment.vkey
  test.staking.addr
  test.staking.skey
  test.staking.vkey
  
# Send transaction
https://github.com/gitmachtl/scripts

  git clone https://github.com/gitmachtl/scripts/tree/master/cardano/mainnet
  
Change settings in 00_common.sh to your settup

Query your test address:

  ./01_queryAddress.sh test.payment.addr
  
Send 2 ADA from your address to a random one:
  
  ./01_sendLovelaces.sh test.payment.addr random.payment.addr 2000000


  

  
