clean:
	docker rmi war_machine

image:
	docker image inspect war_machine 2>1 1>/dev/null

build:
	docker build . -t war_machine --no-cache

shell:
	docker run --name war_machine --rm -ti -v ${HOME}/.ssh:/root/.ssh -v ${HOME}/.kube:/root/.kube war_machine

shell_slim:
	docker run --name war_machine --rm -ti war_machine
