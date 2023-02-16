#!/bin/bash

#for skink
bamtools filter -in 359702_TSI_AGRF_DA149190.ccs.bam -out 359702_TSI_AGRF_DA149190.hifi.ccs.bam -tag "rq":">-0.99"
bamtools filter -in 359702_TSI_AGRF_DA149222.ccs.bam -out 359702_TSI_AGRF_DA149222.hifi.ccs.bam -tag "rq":">-0.99"

#for gecko
bamtools filter -in 359703_TSI_AGRF_DA149208.ccs.bam -out 359703_TSI_AGRF_DA149208.hifi.ccs.bam -tag "rq":">-0.99"
bamtools filter -in 359703_TSI_AGRF_DA149210.ccs.bam -out 359703_TSI_AGRF_DA149210.hifi.ccs.bam -tag "rq":">-0.99"
bamtools filter -in 359703_TSI_AGRF_DA162797.ccs.bam -out 359703_TSI_AGRF_DA162797.hifi.ccs.bam -tag "rq":">-0.99"
