SERVER=$(shell oc whoami --show-server)
TOKEN=$(shell oc whoami -t)

all: output.yaml

output.yaml: schemas/deploymentconfig.json
	kustomize build -o $@

schemas/deploymentconfig.json: schemas/openshift.json
	bash extract-dc-schema.sh < $< > $@ || { rm -f $@; exit 1; }

schemas/openshift.json:
	curl -sSf -o $@ -H "Authorization: Bearer $(TOKEN)" $(SERVER)/openapi/v2

clean:
	rm -f output.yaml schemas/deploymentconfig.json
