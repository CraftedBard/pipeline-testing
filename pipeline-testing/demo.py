from flask import Flask, request
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'


@app.route('/dump', methods=['POST'])
def dump_request():

    print( request.files )
    print( dir( request ) )

    return ''
