from flask import Flask, request, jsonify
from cloudevents.http import from_http
import json
import os

app = Flask(__name__)

app_port = os.getenv('APP_PORT', '6002')

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
    print('Subscriber received : %s' % event.data['dogId'], flush=True)
    return json.dumps({'success': True}), 200, {
        'ContentType': 'application/json'}

@app.route('/foundDog', methods=['POST'])
def foundDog():
    event = from_http(request.headers, request.get_data())
    print('Subscriber received : %s' % event.data, flush=True)
    return json.dumps({'success': True}), 200, {
        'ContentType': 'application/json'}

app.run(port=app_port)
