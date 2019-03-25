COMPUTE_BASE_URL = 'https://www.googleapis.com/compute/v1'
PROJECT_ID = 'fredcast2'
ZONE = 'us-central1-c'

# Deployment Manager doesn't support f-strings, so...
def generate_config(context):
    resources = [{
        'name': 'fredcast-cron',
        'type': 'compute.v1.instance',
        'properties': {
            'zone': ZONE,
            'machineType': ''.join([COMPUTE_BASE_URL,'/projects/',PROJECT_ID,'/zones/',ZONE,'/machineTypes/f1-micro']),
            'disks': [{
                'deviceName': 'boot',
                'type': 'PERSISTENT',
                'boot': True,
                'autoDelete': True,
                'initializeParams': {
                'sourceImage': ''.join([COMPUTE_BASE_URL,'/projects/ubuntu-os-cloud/global/images/family/ubuntu-1804-lts']),
                'diskSizeGb': 10
                }
            }],
            'networkInterfaces': [{
                'network': ''.join([COMPUTE_BASE_URL,'/projects/',PROJECT_ID,'/global/networks/default']),
                'accessConfigs': [{
                    'name': 'External NAT',
                    'type': 'ONE_TO_ONE_NAT'
                }]
            }]
        }
    }]
    return {'resources': resources}
# end generate_config
