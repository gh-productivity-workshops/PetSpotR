from flask import Flask, request, jsonify
from cloudevents.http import from_http
import json
import os
from dapr.clients import DaprClient

app = Flask(__name__)
app_port = os.getenv('APP_PORT', '5000')

dapr = DaprClient()

statestore = 'pets'
pubsubbroker = 'pubsub'

# Register Dapr pub/sub subscriptions
@app.route('/dapr/subscribe', methods=['GET'])
def subscribe():
    subscriptions = [
        {
            'pubsubname': pubsubbroker,
            'topic': 'lostPet',
            'route': 'lostPet'
        },
        {
            'pubsubname': pubsubbroker,
            'topic': 'foundPet',
            'route': 'foundPet'
        }
    ]
    print('Dapr pub/sub is subscribed to: ' + json.dumps(subscriptions))
    return jsonify(subscriptions)


@app.route('/lostPet', methods=['POST'])
def lostPet():
    event = from_http(request.headers, request.get_data())
    petId = event.data['petId']

    print(f'Lost pet: {petId}', flush=True)

    try: 
        result = dapr.get_state(store_name=statestore, key=petId)
        data = json.loads(result.data)
        print(f'Pet state retrieved', flush=True)
    except Exception as e:
        print(f'Error: {e}', flush=True)

    # Convert comma separated string to list
    images = data['petImages'].split(',')
    try:
        for image in images:
            print(f'Image: {image}', flush=True)
            imageData = dapr.invoke_binding(
                binding_name='images',
                operation='get',
                binding_metadata={'blobName': image}
            )
            print(f'Image retrieved', flush=True)
    except Exception as e:
        print(f'Error: {e}', flush=True)

    return json.dumps({'success': True}), 200, {'ContentType': 'application/json'}

@app.route('/foundPet', methods=['POST'])
def foundPet():
    event = from_http(request.headers, request.get_data())
    imagePath = event.data['imagePath']
    type = event.data['type']
    breed = event.data['breed']
    print(f'Subscriber received : {imagePath}, {type}, {breed}', flush=True)

    # Return response
    return json.dumps({'success': True}), 200, {
        'ContentType': 'application/json'}

@app.route('/', methods=['GET'])
def index():
    return '<h1>PetSpotR Backend</h1>'

app.run(port=app_port)
