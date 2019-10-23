## Target
current: target
-include target.mk

######################################################################

Sources += notes.md $(wildcard proposal/*.tex proposal/*.bib)

Ignore += appdocs proviewinfo

######################################################################

## Makestuff setup
Sources += Makefile
msrepo = https://github.com/dushoff
ms = makestuff
Ignore += local.mk
-include local.mk
-include $(ms)/os.mk

Ignore += $(ms)
## Sources += $(ms)
Makefile: $(ms) $(ms)/Makefile
$(ms):
	git clone $(msrepo)/$(ms)


### Makestuff rules

-include $(ms)/git.mk
-include $(ms)/visual.mk

