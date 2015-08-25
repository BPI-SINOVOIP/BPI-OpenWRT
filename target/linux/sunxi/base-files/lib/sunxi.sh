#!/bin/sh

# defaults
SUNXI_BOARD_NAME="generic"
SUNXI_BOARD_MODEL="Generic sunxi board"

sunxi_board_detect() {
	local board
	local model

	[ -e "/tmp/sysinfo/" ] || mkdir -p "/tmp/sysinfo/"

	model="$( cat /proc/device-tree/model )"

	case "$model" in
		"BPI M1")
			board="bpi-m1"
			;;

		"BPI M1 Plus")
			board="bpi-m1-plus"
			;;

		"BPI R1")
			board="bpi-r1"
			;;

	esac

	if [ "$board" != "" ]; then
		SUNXI_BOARD_NAME="$board"
	fi

	if [ "$model" != "" ]; then
		SUNXI_BOARD_MODEL="$model"
	fi


	echo "$SUNXI_BOARD_NAME" > /tmp/sysinfo/board_name
	echo "$SUNXI_BOARD_MODEL" > /tmp/sysinfo/model
	echo "Detected $SUNXI_BOARD_NAME // $SUNXI_BOARD_MODEL"
}

sunxi_board_name() {
	local name

	[ -f /tmp/sysinfo/board_name ] && name="$(cat /tmp/sysinfo/board_name)"
	[ -z "$name" ] && name="unknown"

	echo "$name"
}
