from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return '<h1>Welcome to Coding</h1>'
 
# main driver function
if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0') 