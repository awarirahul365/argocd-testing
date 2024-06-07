import azure.functions as func
import datetime
import json
import logging
import requests 
app = func.FunctionApp()


@app.route(route="HttpTriggerReverse", auth_level=func.AuthLevel.ANONYMOUS)
def HttpTriggerReverse(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    try:
        # Read the data from the request
        file_path = '/shared/output.json'
        #data = req.get_json()
        with open(file_path, 'r') as f:
            data = json.load(f)
        # Reverse the 'message' field in each dictionary
        print(type(data))
        newdata=json.loads(data)
        print(type(newdata))
        for elem in newdata:
            elem['message']=elem['message'][::-1]
        json_data=json.dumps(newdata,indent=4)
        return func.HttpResponse(
            json_data,
            status_code=200,
            mimetype='application/json'
        )
    except Exception as e:
        return func.HttpResponse(
            str(e),
            status_code=500
        )