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

export random=$(openssl rand -hex 8)
export user="testuser""$random"
export denom="test""$random"

export address="imv1szff7jw36thxct4smg8vlxunktxn4w0sr4p7tj"
export addressTransferTest="imv142d7mk6wujnklesrn5uy53kndv4arqaw3trrpn"
export recipient="imv1x2ft5kx5vlj93gymyveulha5sepcq9mwlnpzmu"
export lowFundWallet="imv1l0l667m73749whruyrsgkp207hpjatrcqf4xgj"

export oracle_url="https://api-staging.fdvr.co/instagram-nft/oracle-validate"
export oracle_url_edit="https://www.youtube.com/watch?v=dQw4w9WgXcQ"

#======Stylized test results======#
export TERM=xterm-color
export red=$(tput -T setaf 1)
export green=$(tput setaf 2)
export yellow=$(tput setaf 3)
export reset=$(tput sgr0)
#=================================#


