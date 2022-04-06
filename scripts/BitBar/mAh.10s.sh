#!/usr/bin/env zsh

output="$(system_profiler SPPowerDataType | grep "Charge Remaining" | awk '{print $4}')"
capacity="$(system_profiler SPPowerDataType | grep "Charge Capacity" | awk '{print $5}')"

charge="${capacity} mAh | refresh=true size=12 color=#00ff00"

echo "$charge"
echo "---"

# <bitbar.title>Battery mAh</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Luca Angioloni</bitbar.author>
# <bitbar.author.github>LucaAngioloni</bitbar.author.github>
# <bitbar.desc>Shows the mAh of battery remaining.</bitbar.desc>
# <bitbar.image>http://s32.postimg.org/6k1iq3051/Screen_Shot_2016_04_27_at_20_0$
# <bitbar.dependencies>none</bitbar.dependencies>
