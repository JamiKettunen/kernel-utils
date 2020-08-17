# kernel-utils
Utilities for the Linux Kernel

## convert-double-ext-backends.sh
This script makes adapting OEM sources to https://source.codeaurora.org/quic/la/kernel/msm-4.4/commit/sound/soc/msm/qdsp6v2/msm-pcm-routing-v2.c?id=e16667086d3c2b1864037afdf9039672d82113a0 (gets hit during merge from CAF) simple.

### Instructions
1. Copy `convert-double-ext-backends.sh` to the root your desired downstream MSM QCOM kernel tree
2. Run the script against the desired file after keeping current changes on conflict: `./convert-double-ext-backends.sh sound/soc/msm/qdsp6v2/msm-pcm-routing-v2.c`
