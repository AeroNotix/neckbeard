NPROCS ?= $(shell nproc)
BUILD_DIR = _obuild

all: build.ocp.root
	ocp-build build -njobs ${NPROCS}

build.ocp.root: build.ocp
	ocp-build -init -njobs ${NPROCS}

clean:
	ocp-build clean
