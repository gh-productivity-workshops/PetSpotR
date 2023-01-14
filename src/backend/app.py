from flask import Flask, request, jsonify
from cloudevents.http import from_http
import json
import os
from dapr.clients import DaprClient

app = Flask(__name__)
app_port = os.getenv('APP_PORT', '6002')

dapr = DaprClient()

# Register Dapr pub/sub subscriptions
@app.route('/dapr/subscribe', methods=['GET'])
def subscribe():
    subscriptions = [
        {
            'pubsubname': 'pubsub',
            'topic': 'lostDog',
            'route': 'lostDog'
        },
        {
            'pubsubname': 'pubsub',
            'topic': 'foundDog',
            'route': 'foundDog'
        }
    ]
    print('Dapr pub/sub is subscribed to: ' + json.dumps(subscriptions))
    return jsonify(subscriptions)


@app.route('/lostDog', methods=['POST'])
def lostDog():
    event = from_http(request.headers, request.get_data())
    dogId = event.data['dogId']

    print(f'Lost dog: {dogId}', flush=True)

    try: 
        result = dapr.get_state(store_name='dogs', key=dogId)
        data = json.loads(result.data)
        print(f'Dog state retrieved', flush=True)
    except Exception as e:
        print(f'Error: {e}', flush=True)

    # Convert comma separated string to list
    images = data['dogImages'].split(',')
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

@app.route('/foundDog', methods=['POST'])
def foundDog():
    event = from_http(request.headers, request.get_data())
    print('Subscriber received : %s' % event.data, flush=True)
    return json.dumps({'success': True}), 200, {
        'ContentType': 'application/json'}

app.run(port=app_port)
