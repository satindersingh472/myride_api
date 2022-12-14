# **`MyRide Api`**
MyRide will connect riders and drivers with each other for outside of the city rides.   <br>

Website url:**`https://myride.ml`** <br>

Front end repo: https://github.com/satindersingh472/myride_front <br>

user can either offer rides or can ride as a passenger. So, the user will be able to earn money or 
take benefit of not driving while going away from a city. <br>

## **`Endpoints`**

 ## /api/client
 HTTP methods available: **GET,POST,PATCH,DELETE** <br>
 client can get its information, create an account , modify its own account and delete its own account
 so, the first step in creating an account is send credentials as a required data and verify an email sent to the client's email.

 ## `GET`
 Get method will bring details about the client with valid id if client is verified<br>
 **Required params**
 ```
 {
   client_id: (number)
 }
 ```
**Data Returned** <br>
```
{
   first_name: (string),
   last_name: (string),
   email: (string),
   address: (string),
   city: (string),
   phone_number: (string),
   bio: (string),
   dob: (string),
   profile_image: (string)
}
```
<br>


 ## `POST`

 Post method will add a new a client's first_name, last_name, email and password to the database
 and it will also send an email to confirm the account.  <br>
 
 **Required Data**
 ```
 {
    first_name: (string),
    last_name: (string),
    email: (string),
    password: (string)
 }
 ```
 **Data Returned**
 ```
 {
    client_id: (number),
    token: (string)
 }
 ```
 after this point user will recieve an email for confirming an account <br>
 
<br>

## `PATCH` <br>
Patch method will patch the client's information and password as well
**Note**: send the token as a header and "password" or "profile" should be sent by itself to change i.e. while changing a password only password should be sent as required data and same with profile<br>

**for example**: <br>

**Required Headers** <br>
```
{
   token: (string)
}
```
only one of these should be sent at one time <br>

**Required Data**   <br>
```
{
   old_password: (string the old password),
   new_password: (string the new password )
}
```
**Data Returned** <br>
**On Success** : "password update successfull" <br>
**On Failure** : "password update failed" or **any other error** <br>

<br>

**`OR`** <br>

<br>

**Required Data**  <br>

**Optional data** : Send one or more of these optional data
```
{
   first_name: (string),
   last_name: (string),
   email: (string),
   address: (string),
   city: (string),
   phone_number: (string),
   bio: (string),
   dob: (data of birth format yyyy-mm-dd)
}
```
**Data Returned** <br>
**On Success** : "profile update successfull" <br>
**On Failure** : "profile update failed" or **any other error** <br>
 <br>

 ## `DELETE`

 Delete request will delete the client from the database if it is verified and if user has sent the correct token and password. <br>
 **Required Headers** <br>
 ```
 {
   token: (string),
 }
 ```

 **Required Data** <br>
 ```
 {
   password: (string)
 }
 ```

 **Data Returned** <br>
 **On success** : "client delete successfull" <br>
 **On failure** : "client delete failed" or **any other error** <br>

<br>
<br>

## /api/client_login
This endpoint will login user and logout user <br>
HTTP methods available : **POST,DELETE**   <br>

## `POST`
post method will log in the client with valid email and password <br>

**Required Data** <br>
```
{
   email: (string),
   password: (string)
}
```

**Data Returned**  <br>
```
{
   client_id: (number),
   token: (string)
}
```
<br>

## `DELETE`
delete method will logout the client and delete the token from session <br>

**Required Headers**
```
{
   token: (string)
}
```
**Data Returned** <br>
**On success** : "client logout successfull" <br>
**On failure** : "client logout failed" or **any other error**. <br>

<br>
<br>

## /api/client_image
This endpoint will help with the client profile image
HTTP methods available: **GET,PATCH** <br>

## `GET` <br>
Get method will return the image if valid client_id is sent <br>
**Required params** <br>
```
{
   client_id: (number)
}
```
**Data Returned** <br>
```
{
   profile_image: (string of an image file blob)
}
```
<br>

## `PATCH`
This will change the existing profile image or even if there is no profile image it will insert the sent profile image as file. <br>

**Required Headers**
```
{
   token: (string)
}
```
**Required Data**
```
{
   profile_image: (file with a format of ['.png','.jpg','.jpeg','.gif'])
}
```

**Data Returned** 

Image as a string. <br>


<br>
<br>

 ## /api/client_verified
 HTTP methods available: **GET**
This endpoint will check if client is verified or not <br>

## `GET`
it will check the status of a client verification <br>

**Required Header**
```
{
   token: (string)
}
```
**Data Returned**
```
{
   verified: (bool 0 or 1)
}
```

<br>
<br>

## /api/rides
HTTP methods available: **GET** <br>

## `GET`
It will show all the available rides to the user. at this time all the rides are being shown to the user <br>
regardless of the location but upcoming rides only not the past rides.  <br>
**Data Returned**
```
[
   {
      ride_id: (number),
      from_city: (string),
      to_city: (string),
      travel_date: (string),
      leave_time: (string),
      rider_id: (number),
      rider_first_name: (string),
      from_prov: (string),
      to_prov: (string)
   },
]
```

<br>
<br>

## /api/ride
HTTP methods available: **GET,POST,PATCH,DELETE** <br>

## `GET`
this method will get all the rides associated with user that is posted by the user <br>
given the valid client id and token.

**Required Headers**  <br>
```
{
   token: (string)
}
```
**Required Params** 
```
{
   client_id: (number)
}
```

**Data Returned**  <br>
```
[
   {
      ride_id: (number),
      rider_first_name: (string),
      rider_last_name: (string),
      from_city: (string),
      from_prov: (string),
      to_city: (string),
      to_prov: (string),
      travel_date: (date with format yyyy-mm-dd),
      leave_time: (time format hh:mm::ss)
   }
]
```
**On no rides** : "no rides to show" <br>

<br>


<br>

## `POST` <br>
It will post the ride in the database. User with a valid token can post a ride. <br>

**Required Headers** <br>
```
{
   token: (string)
}
```

**Required Data** <br>
```
{
   from_city: (string),
   to_city: (string),
   travel_date: (date with format yyyy-mm-dd),
   leave_time: (time format hh:mm::ss)
   from_prov: (string),
   to_prov: (string)
}
```

**Data Returned** <br>
```
{
   ride_id: (number),
   rides_posted_count: (number) it is the number of rides posted in the database to make sure if atleast one row_count has been made
}
```
**On failure** : "ride post failed" or **any other error** <br>

<br>

## `PATCH`
Patch will change information about the ride posted with valid token of a client and valid ride_id sent as a header <br>

**Required Headers** <br>
```
{
   token: (string),
   ride_id: (number)
}
```
**Optional Data** : Send one or more of the optional arguments to see any change in the data <br>
```
{
   from_city: (string),
   to_city: (string),
   travel_date: (date as a string format "yyyy-mm-dd"),
   leave_time: (time as format hh:mm:ss)
   to_prov: (string),
   from_prov: (string)
}
```
**Data Returned** 
**On success** : "ride update successfull" <br>
**On failure** : "ride update failed" or **any other error**. <br>

<br>

## `DELETE`  <br>

Delete will delete the ride belongs to a client if valid token is sent as header and ride_id sent as data. <br>
**Required Headers**
```
{
   token: (string)
}
```
**Required Data**  <br>
```
{
   ride_id: (number)
}
```
**Data Returned** <br>
**On success** : "ride delete successfull" <br>
**On failure** : "ride delete failed" or **any other error** <br>

<br>
<br>

## /api/booking_passenger
HTTP methods available: **GET,POST,DELETE** <br>

## `Get`
It will display all the bookings associated with a passenger.
so, the passenger can get all its upcoming and past bookings. <br> 

**Required Headers** <br>
```
{
   token: (string)
}
```

**Required params** <br>
```
{
   client_id: (string)
}
```

**Data Returned** <br>
```
[
   {
      booking_id: (number),
      is_confirmed: (bool),
      is_completed: (bool),
      from_city: (string),
      to_city: (string),
      travel_date: (string),
      leave_time: (string),
      rider_id: (number),
      ride_id: (number),
      rider_first_name: (string),
      rider_last_name: (string),
      rider_phone_number: (string),
      to_prov: (string),
      from_prov: (string),
      rider_email: (string)
   },
]
```
<br>

## `POST` <br>
post method will post a new booking for a ride with a valid token and ride id. <br>

**Required Headers** <br>
```
{
   token: (string)
}
```

**Required Data**  <br>
```
{
   ride_id: (string)
}
```
**Data Returned** <br>
```
{
   booking_id: (number)
}
```
<br>

## `DELETE`
delete method will delete the booking for a passenger <br>
**Required Headers**
```
{
   token: (string)
}
```
**Required Data**
```
{
   booking_id: (number)
}
```
**On success** : "booking delete successfull"  <br>
**On failure** : "booking delete failed" or **any other error**. <br>

<br>
<br>

## /api/booking_rider
HTTP methods available: **GET,PATCH**  <br>

## `GET`  <br>
Get method will grab the information about the specific ride by sending the ride id and a valid token <br>

**Required Headers** <br>
```
{
   token: (string)
}
```
**Required Data** <br>
```
{
   ride_id: (number)
}
```

**Data Returned** <br>
```
{
   ride_id: (number),
   booking_id: (number),
   is_confirmed: (bool),
   is_completed: (bool),
   passenger_first_name: (string),
   passenger_last_name: (string),
   phone_number: (string),
   email: (string)
}

```
<br>

## `PATCH`  <br>
Riders can confirm or complete the bookings. <br>

**Required Headers** <br>
```
{
   token: (string)
}
```
**Required Data** <br>
```
{
   booking_id: (number)
}
```
**Optional Data** : Send one or both <br>
```
{
   is_confirmed: true (false is not allowed , it wont do anything),
   is_completed: true(false is not allowed, it wont do anything)
}
```
**Data Returned**
```
{
   is_confirmed = 1 (if is_confirmed is sent as a data object key and value "true" ),
   is_completed = 1 (if is_completed is sent as a data object key and value "true" ),

   or 

   is_completed = 1 (if both options were sent as data object keys and value "true" for both)
}
```

<br>
<br>

**END**
