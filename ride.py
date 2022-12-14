import json
from flask import request,make_response
from apihelpers import verify_endpoints_info,add_for_patch,bring_picture
from dbhelpers import conn_exe_close


# will help filter the results according to the city typed in
def rides_filter():
    # if user just typed one city it will still work because it will just be equal to empty string
    if(request.args.get('from_city') != None):
        data_one = request.args['from_city']
    else:
        data_one = ''
    if(request.args.get('to_city') != None):
        data_two = request.args['to_city']
    else:
        data_two = ''
    results = conn_exe_close('call rides_filter(?,?)',[data_one,data_two])
    if(type(results) == list and len(results) >= 1):
        # will send the results as 200 if everything is fine other wise error
        return make_response(json.dumps(results,default=str),200)
    elif(len(results) == 0):
        return make_response(json.dumps('No results related to search',default=str),400)
    elif(type(results) == str):
        return make_response(json.dumps(results,default=str),400)
    else:
        return make_response(json.dumps(results,default=str),500)

# will get all the rides available after now()
# stored procedure rides_get_all is not expecting any arguments
def rides_get_all():
    # will directly call the stored procedure to get all the results for rides
    results = conn_exe_close('call rides_get_all()',[])
    if(type(results) == list and len(results) != 0):
        # if response has rides then this statement will be true
        # for result in results:
        #     if(result['profile_image'] != None and result['profile_image'] != ''):
        #         result['profile_image'] = bring_picture(result['profile_image'])
        return make_response(json.dumps(results,default=str),200)
    # if not then this statement will be true
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps('No rides available',default=str),400)
    elif(type(results) != list):
        # if error then this statement will be true
        return make_response(json.dumps(results,default=str),400)
    else:
        # if server error then this statement will get executed
        return make_response(json.dumps(results,default=str),500)




def ride_get():
    # will check for headers iftoken is present
    invalid_headers = verify_endpoints_info(request.headers,['token'])
    if(invalid_headers != None):
        # if not then error will show up
        return make_response(json.dumps(invalid_headers,default=str),400)
        # check if id is sent or not
    invalid = verify_endpoints_info(request.args,['client_id'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
    results = conn_exe_close('call ride_get(?,?)',[request.args['client_id'],request.headers['token']])
    # will show the response with 200 if there is a valid response with a list of dictionarie or dictionaries
    if(type(results) == list and len(results) >= 1):
        return make_response(json.dumps(results,default=str),200)
    # if error then show the error
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps('No rides available',default=str),400)
    else:
        # if server messed up then show this error
        return make_response(json.dumps(results,default=str),500)


def ride_patch():
    # token and id will be sent as a headers
    invalid_headers = verify_endpoints_info(request.headers,['token'])
    if(invalid_headers != None):
        return make_response(json.dumps(invalid_headers,default=str),400)
    # will grab the original data related to the ride and modify it based on information sent by user
    invalid = verify_endpoints_info(request.json,['ride_id'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
    results = conn_exe_close('call ride_get_for_patch(?,?)',[request.json['ride_id'],request.headers['token']])
    # looking for these arguments inside data that user should have sent
    # but it is not common that every information will the user want to change
    # the user might want to change one or two column
    # the rest of the data we will use the existing one from the db itself
    required_data = ['from_city','to_city','travel_date','leave_time','from_prov','to_prov']
    # this code will overwrite the sent data to the original data and grab all the orignal data with
    # overwritten data and call the procedure by sending new and some old data or 
    # totally new data or totally old data if user did not sent anything
    results = add_for_patch(request.json,required_data,results[0])
    results = conn_exe_close('call ride_patch(?,?,?,?,?,?,?,?)',
    [results['from_city'],results['from_prov'],results['to_city'],results['to_prov'],results['travel_date'],results['leave_time'],
    request.json['ride_id'],request.headers['token']])
    # if something is changed then we will call the stored procedure again 
    # it will help in making changes at the screen without refreshing the window
    if(type(results) == list and results[0]['row_count'] == 1):
        results = conn_exe_close('call ride_get_for_patch(?,?)',[request.json['ride_id'],request.headers['token']])
        return make_response(json.dumps(results[0],default=str),200)
        # if nothing changed then the following message will appear
    elif(type(results) == list and results[0]['row_count'] == 0):
        return make_response(json.dumps('Ride update failed',default=str),400)
    else:
        # on server error the following message will be displayed
        return make_response(json.dumps(results,default=str),500)
    



def ride_post():
    # will check for token as a header is sent or not
    invalid_headers = verify_endpoints_info(request.headers,['token'])
    if(invalid_headers != None):
        return make_response(json.dumps(invalid_headers,default=str),400)
    # will check for required data is sent or not if not then it will ask for that
    invalid = verify_endpoints_info(request.json,['from_city','from_prov','to_city','to_prov','travel_date','leave_time'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
    # after everythin sent it will call the stored procedure to post the ride 
    results = conn_exe_close('call ride_post(?,?,?,?,?,?,?)',
    [request.json['from_city'],request.json['from_prov'],request.json['to_city'],request.json['to_prov'],request.json['travel_date'],request.json['leave_time'],request.headers['token']])
    if(type(results) == list and results[0]['rides_posted_count'] == 1):
        # if ride posted successfully then it will give back the number of rides posted and ride id
        return make_response(json.dumps(results[0],default=str),200)
        # if no ride posted then error will show up from the following statment
    elif(type(results) == list and results[0]['rides_posted_count'] == 0):
        return make_response(json.dumps('Ride post failed',default=str),400)
    else:
        # server error will show up as error 500
        return make_response(json.dumps(results,default=str),500)


def ride_delete():
    # will check for token inside headers
    # if not sent then error will show up
    invalid_header = verify_endpoints_info(request.headers,['token'])
    if(invalid_header != None):
        return make_response(json.dumps(invalid_header,default=str),400)
    # will check for ride id sent as data if not sent then error will show up
    invalid = verify_endpoints_info(request.json,['ride_id'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
    # call the procedure to delete the ride data from tables
    results = conn_exe_close('call ride_delete(?,?)',[request.json['ride_id'],request.headers['token']])
    # if results is a list then row count 1 means something is deleted 
    # row count 0 means not deleted or does not even exists in database
    if(type(results) == list and results[0]['row_count'] == 1):
        return make_response(json.dumps('ride delete successfull',default=str),200)
    elif(type(results) == list and results[0]['row_count'] == 0):
        return make_response(json.dumps('Ride delete failed',default=str),400)
    elif(type(results) != list):
        # if some error occur from user side then this statement will show up
        return make_response(json.dumps(results,default=str),400)
    else:
        # if error from server side it will be 500 errror code 
        return make_response(json.dumps(results,default=str),500)