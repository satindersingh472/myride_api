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
**Note**: send the token as a header and "password" or "profile_image" should be sent by itself to change i.e. while changing a password only password should be sent as required data and same with profile_image <br>

**for example**: <br>

**Required Headers** <br>
```
{
   token: (string)
}
```
only one of these should be sent at one time

**Required Data**
```
{
   profile_image: (file with any of the formats from ['.jpeg','.jpg','.png','.gif'])
}
```
**`OR`**
```
{
   password: (string)
}
```
**`OR`** <br>
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

<br>
<br>


 ## /api/client_verified
This endpoint will check if client is verified or not

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



