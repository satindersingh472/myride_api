# **`MyRide Api`**
MyRide will connect riders and drivers with each other for outside of the city rides.

Website url:**`https://myride.ml`** <br>

user can either offer rides or can ride as a passenger. So, the user will be able to earn money or 
take benefit of not driving while going away from a city.

## **`Endpoints`**

 ## /api/client
 HTTP methods available: **GET,POST,PATCH,DELETE** <br>
 client can get its information, create an account , modify its own account and delete its own account
 so, the first step in creating an account is send credentials as a required data and verify an email sent to the client's email.

 ## `GET`
 Get method will bring details about the client with valid id and token if a client is verified. <br>
 **Required Headers**
 ```
 {
   token: (string),
   client_id: (string)
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
 and it will also send an email to confirm the account.
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
 after this point user will recieve an email for confirming an account
 
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
only one of these should be sent at one time

**Required Data**   <br>
```
{
   password: (string)
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
This endpoint will login user and logout user
HTTP methods available : **POST,DELETE**   <br>

## `POST`
post method will log in the client with valid email and password

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
delete method will logout the client and delete the token from session

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
HTTP methods available: **PATCH** <br>

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

Image as a string. 


<br>
<br>

 ## /api/client_verified
 HTTP methods available: **GET**
This endpoint will check if client is verified or not

## `GET`
it will check the status of a client verification

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




<br>

## /api/ride
HTTP methods available: **POST,PATCH** <br>

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
Patch will change information about the ride posted with valid token of a client and valid ride_id sent as a header

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
}
```
**Data Returned** 
**On success** : "ride update successfull" <br>
**On failure** : "ride update failed" or **any other error**. <br>

<br>
