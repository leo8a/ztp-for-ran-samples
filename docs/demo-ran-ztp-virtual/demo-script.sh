#!/usr/bin/env bash


########################
# Download demo-magic
########################
curl -s https://raw.githubusercontent.com/paxtonhare/demo-magic/master/demo-magic.sh > /usr/local/bin/demo-magic.sh
chmod +x /usr/local/bin/demo-magic.sh
dnf install -y pv                   # prerequisites for demo-magic


########################
# Include the magic
########################
. /usr/local/bin/demo-magic.sh


########################
# Configure the options
########################
TYPE_SPEED=20                       # speed at which to simulate typing. bigger num = faster
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "  # custom prompt - see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
DEMO_CMD_COLOR=$WHITE
DEMO_COMMENT_COLOR=$WHITE


########################
# Start the magic
########################
clear                               # hide the evidence

pe "# Let's start by cloning the ztp-for-ran-sample repo"
pei "git clone https://github.com/leo8a/ztp-for-ran-samples.git"
pei "cd ztp-for-ran-samples/ran-ztp-workflow"
pei "ls -lah"
pei ""
pei ""

pe "# Let's now review the parameters of the plan to deploy"
pei "sed -n 1,20p ztp-ran-plan.yml"

pe ""
pei "# Ensure your pull_secret is downloaded and properly located"
pei "ls -lah /root/pull_secret.json"
pei ""

pe ""
clear
pei "# Start the Virtual Lab for RAN ZTP Workflows deployment"
pei "./bootstrap_ran_ztp_lab.sh"
pei ""
pei ""

pe "# Finally, let's review the deployed virtual lab"
p ""


########################
# Cleanup artifacts
########################
cd ../..
rm -rf ztp-for-ran-samples
