# SPEC=abrev/abrev_spec.lua
	# $(RUN) -c "PlenaryBustedFile $(SPEC) { minimal_init = 'minimal_init.vim' }"

SPEC=abrev_spec.lua

RUN=nvim --headless --noplugin -u minimal_init.vim

test:
	$(RUN) -c "PlenaryBustedFile $(SPEC)"
