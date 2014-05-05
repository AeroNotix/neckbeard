build.ocp.root: build.ocp
	ocp-build -init -njobs $(shell nproc)
