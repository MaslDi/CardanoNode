#!/bin/bash

# $1 = path to mnemonic file
# $2 = outputfilename

#-------------------------------------------------------
#Displays an Errormessage if parameter is not 0
checkError()
{
if [[ $1 -ne 0 ]]; then echo -e "\n\n\e[35mERROR (Code $1) !\e[0m\n"; exit 1; fi
}
#-------------------------------------------------------



cardanoaddress="./cardano-address"
cardanocli="./cardano-cli"

addrformat="--mainnet"   #--testnet-magic xxx for testnet
networktag="mainnet" #0 for testnet, 1 for mainnet

#addrformat="--testnet-magic 1097911063"   #--testnet-magic xxx for testnet
#networktag="testnet" #0 for testnet, 1 for mainnet

addrName="${2}" #only for tempfiles

mnemonics=$(cat ${1})

${cardanoaddress} key from-recovery-phrase Shelley <<< ${mnemonics} > "${addrName}.root.xsk"
checkError "$?"; if [ $? -ne 0 ]; then exit $?; fi

${cardanoaddress} key child 1852H/1815H/0H/0/0          < "${addrName}.root.xsk"                    > "${addrName}.1852.1815.0.0.0.payment.xsk"
checkError "$?"; if [ $? -ne 0 ]; then exit $?; fi

${cardanoaddress} key public --with-chain-code          < "${addrName}.1852.1815.0.0.0.payment.xsk" > "${addrName}.1852.1815.0.0.0.payment.xvk"
checkError "$?"; if [ $? -ne 0 ]; then exit $?; fi

${cardanoaddress} address payment --network-tag ${networktag} < "${addrName}.1852.1815.0.0.0.payment.xvk" > "${addrName}.1852.1815.0.0.0.enterprise.addr"
checkError "$?"; if [ $? -ne 0 ]; then exit $?; fi

${cardanocli} key convert-cardano-address-key --shelley-payment-key --signing-key-file "${addrName}.1852.1815.0.0.0.payment.xsk"  --out-file              "${addrName}.1852.1815.0.0.0.payment.skey"
checkError "$?"; if [ $? -ne 0 ]; then exit $?; fi

${cardanocli} key verification-key                                  --signing-key-file "${addrName}.1852.1815.0.0.0.payment.skey" --verification-key-file "${addrName}.1852.1815.0.0.0.payment.vkey"
checkError "$?"; if [ $? -ne 0 ]; then exit $?; fi

cp "${addrName}.1852.1815.0.0.0.payment.skey" "${addrName}.payment.skey"
cp "${addrName}.1852.1815.0.0.0.payment.vkey" "${addrName}.payment.vkey"

${cardanoaddress} key child 1852H/1815H/0H/2/0        < "${addrName}.root.xsk"                  > "${addrName}.1852.1815.0.2.0.stake.xsk"
checkError "$?"; if [ $? -ne 0 ]; then exit $?; fi

${cardanoaddress} key public --with-chain-code        < "${addrName}.1852.1815.0.2.0.stake.xsk" > "${addrName}.1852.1815.0.2.0.stake.xvk"
checkError "$?"; if [ $? -ne 0 ]; then exit $?; fi

${cardanoaddress} address stake --network-tag ${networktag} < "${addrName}.1852.1815.0.2.0.stake.xvk" > "${addrName}.1852.1815.0.2.0.stake.addr"
checkError "$?"; if [ $? -ne 0 ]; then exit $?; fi

${cardanocli} key convert-cardano-address-key --shelley-stake-key --signing-key-file "${addrName}.1852.1815.0.2.0.stake.xsk"  --out-file              "${addrName}.1852.1815.0.2.0.stake.skey"
checkError "$?"; if [ $? -ne 0 ]; then exit $?; fi

${cardanocli} key verification-key                                --signing-key-file "${addrName}.1852.1815.0.2.0.stake.skey" --verification-key-file "${addrName}.1852.1815.0.2.0.stake.vkey"
checkError "$?"; if [ $? -ne 0 ]; then exit $?; fi

cp "${addrName}.1852.1815.0.2.0.stake.skey" "${addrName}.staking.skey"
cp "${addrName}.1852.1815.0.2.0.stake.vkey" "${addrName}.staking.extended.vkey"

${cardanocli} key non-extended-key --extended-verification-key-file "${addrName}.staking.extended.vkey" --verification-key-file "${addrName}.staking.vkey"
checkError "$?"; if [ $? -ne 0 ]; then exit $?; fi

${cardanoaddress} address delegation $(cat "${addrName}.1852.1815.0.2.0.stake.xvk") < "${addrName}.1852.1815.0.0.0.enterprise.addr" > "${addrName}.1852.1815.0.0.0.base.addr"
checkError "$?"; if [ $? -ne 0 ]; then exit $?; fi

${cardanocli} address build --payment-verification-key-file ${addrName}.payment.vkey --staking-verification-key-file ${addrName}.staking.vkey ${addrformat} > ${addrName}.payment.addr
checkError "$?"; if [ $? -ne 0 ]; then exit $?; fi


