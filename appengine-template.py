def generate_config(context):
    resources = [{
        'name': 'compute-enable',
        'type': 'deploymentmanager.v2.virtual.enableService',
        'properties': {
            'consumerId': 'project:fredcast2',
            'serviceName': 'compute'
        },
        'name': 'appengine-enable',
        'type': 'deploymentmanager.v2.virtual.enableService',
        'properties': {
            'consumerId': 'project:fredcast2',
            'serviceName': 'appengine'
        }
    }]
    return {'resources': resources}
# end generate_config
