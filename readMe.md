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



