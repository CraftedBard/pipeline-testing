#!/bin/sh
source ve/bin/activate
FLASK_APP=demo
exec flask run --host=0.0.0.0
