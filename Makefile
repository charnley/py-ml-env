
CONDA=conda
ECONDA=./env/bin/conda
PYTHON=./env/bin/python
PIP=./env/bin/pip
JUPYTER=./env/bin/jupyter

all: env pip

env: environment.yml
	${CONDA} env create --file environment.yml --prefix env

pip: requirements.txt
	${PYTHON} -m pip install -r requirements.txt --no-cache-dir

update_conda:
	${CONDA} update conda -y

update: environment.yml
	${CONDA} env update --file environment.yml --prefix env --prune

notebook:
	set -e;\
	HOSTIP=`ip route get 1 | awk '{print $$NF;exit}'`;\
	${JUPYTER} notebook --ip $$HOSTIP --port 8888

