#!/bin/bash

export PATH=$PATH:~/HiFiAdapterFilt/
export PATH=$PATH:~/HiFiAdapterFilt/DB

#for skink
bash hifiadapterfilt.sh -t 32 -p 359702_TSI_AGRF_DA149222.hifi.ccs
bash hifiadapterfilt.sh -t 32 -p 359702_TSI_AGRF_DA149190.hifi.ccs

#for gecko
bash hifiadapterfilt.sh -t 32 -p 359703_TSI_AGRF_DA149208.hifi.ccs
bash hifiadapterfilt.sh -t 32 -p 359703_TSI_AGRF_DA149210.hifi.ccs
bash hifiadapterfilt.sh -t 32 -p 359703_TSI_AGRF_DA162797.hifi.ccs
