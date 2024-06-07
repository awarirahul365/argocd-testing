import azure.functions as func
import datetime
import json
import logging
import requests
app = func.FunctionApp()

@app.route(route="HttpTriggerReader", auth_level=func.AuthLevel.ANONYMOUS)
def HttpTriggerReader(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    json_string_reader=req.params.get('json')
    #Received as string format
    logging.info({json_string_reader})
    if not json_string_reader:
        return func.HttpResponse(
            "No Json provided",
            status_code=400
        )
    
    try:
        # converted to json format
        req_body=json.loads(json_string_reader)
    except:
        return func.HttpResponse(
            "Invalid Format",
            status_code=400
        )
    logging.info(f"JSON Body: {req_body}")
    headers = {"Content-Type": "application/json"}
    response_json = json.dumps(req_body, indent=4)
    #res=requests.post("https://httpfunctionreverse.azurewebsites.net/api/HttpTriggerReverse?",data=response_json,headers=headers)
    #res=requests.post("http://localhost:9000/api/HttpTriggerReverse",data=response_json,headers=headers)
    #logging.info({res.status_code})
    with open('/shared/output.json', 'w') as f:
        json.dump(response_json, f)
    return func.HttpResponse(response_json, mimetype="application/json")