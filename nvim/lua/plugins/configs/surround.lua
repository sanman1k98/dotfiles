local present, surround = pcall(require, 'nvim-surround')

if not present then
	return
end

--[[


# Adding new surrounds

Adding new surrounds is done by the keymap prefix `ys`, which can can be
thought of as meaning "you surround". It is used via `ys[object][char]`, where
`object` denotes the `text-object` that you are surrounding with a delimiter
pair defined by `char`.


# Deleting surrounds

By default, deleting surrounding pairs is done with the keymap prefix, `ds`.


# Changing surrounds

By default, changing surrounding pairs is done by the keymap prefix `cs`. It
is used via `cs[char1][char2]`, where `char1` refers to the pair to be
deleted, and `char2` represents the pair to replace it.


]]

surround.setup {}
