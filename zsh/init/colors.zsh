# I would like to manage these vars from the terminal emulator, but we'll
# ensure they exist with some defaults if I haven't set it in their
# config or it doesn't support it.

export CONFIG_COLORS_LIGHT="${CONFIG_COLORS_LIGHT:-dawnfox}"
export CONFIG_COLORS_DARK="${CONFIG_COLORS_DARK:-carbonfox}"

if [[ -z "${CONFIG_COLORS}" ]]; then
	if [[ "${TERM}" == "xterm-ghostty" ]]; then
		# Keep in sync with ghostty config.
		export CONFIG_COLORS="carbonfox"
	else
		export CONFIG_COLORS="dawnfox"
	fi
fi

if [[ "${CONFIG_COLORS}" == "${CONFIG_COLORS_LIGHT}" ]]; then
	export CONFIG_COLORS_MODE="light"
elif [[ "${CONFIG_COLORS}" == "${CONFIG_COLORS_DARK}" ]]; then
	export CONFIG_COLORS_MODE="dark"
fi
