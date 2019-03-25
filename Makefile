DEPLOYMENT := "deployment-fredcast"

FORCE:

create: FORCE
	# Create deployment, and then configure the resources
	@gcloud deployment-manager deployments create $(DEPLOYMENT) --config main.yaml
	@gcloud compute scp fredcast-cleanup.sh fredcast-cron:/tmp/fredcast-cleanup.sh
	@gcloud compute ssh fredcast-cron --command 'sudo mv /tmp/fredcast-cleanup.sh /root/fredcast-cleanup.sh'
	@gcloud compute ssh fredcast-cron --command '(sudo crontab -l ; echo "0 0 * * * bash /root/fredcast-cleanup.sh") | sort -u - | sudo crontab -'

update: FORCE
	@gcloud deployment-manager deployments update $(DEPLOYMENT) --config main.yaml

delete: FORCE
	@gcloud deployment-manager deployments delete $(DEPLOYMENT)

list: FORCE
	@gcloud deployment-manager deployments list
