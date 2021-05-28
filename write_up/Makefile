## Target
current: target
-include target.mk

vim_session:
	bash -cl "vmt"

%.tangle.r: %.Rnw
	R CMD Stangle $<

%.tex: %.Rnw
	R CMD Sweave $<

## Make Sweave weird depencies chain
%: %.pdf ;

######################################################################

Sources += $(wildcard *.R *.Rnw *.bib)

automatic_makeR = defined

######################################################################

## Write-up

# steve_single_models_writeup.bib: steve_single_models_writeup.bib ;
# steve_single_models_writeup.pdf: steve_single_models_writeup.Rnw
steve_single_models_writeup.tex: steve_single_models_writeup.Rnw

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
-include makestuff/texdeps.mk


