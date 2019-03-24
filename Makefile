DEPLOYMENT := "deployment-fredcast"

FORCE:

create: FORCE
	@gcloud deployment-manager deployments create $(DEPLOYMENT) --config main.yaml

update: FORCE
	@gcloud deployment-manager deployments update $(DEPLOYMENT)