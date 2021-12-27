#!/bin/sh

#Var legend:
#denom  - Denom id, Denom name
#adress  - Your address
#recipient - recipient address
#======Response Codes======#
#RC  - response code
#QRC - query response code
#TRC - transfer response code
#MRC - mint response code
#==========================#

random=$(openssl rand -hex 8)
denom="test""$random"
address="imv1szff7jw36thxct4smg8vlxunktxn4w0sr4p7tj"
recipient="imv1x2ft5kx5vlj93gymyveulha5sepcq9mwlnpzmu"
oracle_url=https://api-staging.fdvr.co/instagram-nft/oracle-validate
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset=$(tput sgr0)