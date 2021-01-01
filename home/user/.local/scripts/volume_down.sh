#!/bin/sh

# cut -d splits string on your delimiter -f is the section you want
VOL_CURRENT=$(mixer | grep vol | cut -d':' -f 2)

VOL_REQUIRED=$(($VOL_CURRENT - 1))

mixer -s vol $VOL_REQUIRED
echo "Done"

