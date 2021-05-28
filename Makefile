## Target
current: target
-include target.mk

vim_session:
	bash -cl "vmt"

######################################################################

Sources += notes.md $(wildcard proposal/*.tex proposal/*.bib)

Ignore += appdocs proviewinfo

automatic_makeR = defined

######################################################################

## Proview G-Drive linke: https://drive.google.com/drive/folders/1gNSb77TGL6n_iInUIxnH5YKimUAXB7kV?usp=sharing

######################################################################

test.Rout: test.R
	$(wrapR)

## Write-up


######################################################################

### Makestuff

Sources += Makefile

## Sources += content.mk
## include content.mk

Ignore += makestuff
msrepo = https://github.com/dushoff
Makefile: makestuff/Makefile
makestuff/Makefile:
	git clone $(msrepo)/makestuff
	ls $@

-include makestuff/os.mk

-include makestuff/pipeR.mk

-include makestuff/git.mk
-include makestuff/makeR.mk
-include makestuff/visual.mk



