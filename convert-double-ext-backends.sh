#!/bin/bash
# convert-double-ext-backends.sh - Convert all SOC_SINGLE_EXT backends to their SOC_DOUBLE_EXT
# counterparts in a downstream MSM PCM routing driver source file ($1) that is modified by an OEM

# Example of what the script does:
# -	SOC_SINGLE_EXT("MultiMedia7", MSM_BACKEND_DAI_SEC_I2S_RX,
# +	SOC_DOUBLE_EXT("MultiMedia7", SND_SOC_NOPM,
# +		MSM_BACKEND_DAI_SEC_I2S_RX,

echo "[*] Script begin..."

while IFS="" read line; do
	ln=`echo "$line" | cut -d':' -f1` # line number, e.g. "4157"
	line=`echo "$line" | cut -d':' -f2-`

	backend=`echo "$line" | cut -d',' -f2 | xargs` # e.g. "MSM_BACKEND_DAI_SEC_I2S_RX"
	[ -z "$backend" ] && continue

	new_line=`echo "$line" | sed -e 's/SOC_SINGLE_EXT/SOC_DOUBLE_EXT/' -e "s/$backend/SND_SOC_NOPM/"`
	new_line="$new_line\n\t$backend,"

	if fgrep -q "$line" "$1"; then
		echo "[*] Updating old line with '$backend' backend..."
		sed "s/$line/$new_line/g" -i "$1"
	fi
done <<< `fgrep -n 'SOC_SINGLE_EXT("' "$1" | grep -v 'SND_SOC_NOPM'`

echo "[*] Script done!"
