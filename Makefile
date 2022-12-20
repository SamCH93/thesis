all: docker

# specify same name as in source/Makefile
FILE=thesis

## build locally
local:
	-cd source && make cover pdf clean
	-mv source/thesis.pdf ./

## build docker image (requires root access for docker)
dbuild: Dockerfile
	docker build \
    -t $(FILE) .

## run docker image that produces pdf from within docker
docker: dbuild
	docker run \
    --rm \
	--env pdfdocker="true" \
	--env FILE=$(FILE) \
	--volume $(CURDIR):/output \
	$(FILE)

## run docker image that produces tex from within docker
docker2: dbuild
	docker run \
    --rm \
	--env FILE=$(FILE) \
	-v $(CURDIR):/output \
		$(FILE)
## compile pdf using LaTeX outside docker
	mv thesis.tex intro.tex source/
	mkdir -p source/figure
	mv figure/* source/figure
	rmdir figure/
	-cd source && make pdf2 clean
	-mv source/thesis.pdf ./
