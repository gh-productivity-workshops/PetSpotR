from flask import Flask, request, jsonify
from cloudevents.http import from_http
import json
import os
from dapr.clients import DaprClient
from petspotr import pet

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
    # Get Dapr pub/sub message
    event = from_http(request.headers, request.get_data())
    id = event.data['petId']

    # Get pet details from Dapr state store
    try: 
        result = dapr.get_state(store_name=statestore, key=id)
        data = json.loads(result.data)
        print(f'Pet state retrieved', flush=True)
    except Exception as e:
        print(f'Error: {e}', flush=True)
    p = pet(
            data['id'],
            data['name'],
            data['type'],
            data['breed'],
            data['images'],
            data['state'],
            data['ownerEmail']
        )
    
    # Fine-tune PetMatch model with new pet information
    p.train_model()

    return json.dumps({'success': True}), 200, {'ContentType': 'application/json'}

@app.route('/foundPet', methods=['POST'])
def foundPet():
    event = from_http(request.headers, request.get_data())
    data = json.loads(event.data)

    p = pet(
        data['petId'],
        data['Image']
    )

    # Use ML inference endpoint to see if there is a match
    match = p.predict_image()

    if match:
        p.alert_owner(dapr)

    # Return response
    return json.dumps({'success': True}), 200, {
        'ContentType': 'application/json'}

@app.route('/', methods=['GET'])
def index():
    return '<h1>PetSpotR Backend</h1>'

app.run(port=app_port)