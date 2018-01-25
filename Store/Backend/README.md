# Store Backend Written in Swift (macOS/Linux)
## USAGE
* Live version on ibm bluemix
```
// Use one of these urls
https://ioscoursestore.eu-gb.mybluemix.net
https://backend.xcode.ir
```
* docker
```
docker-compose up
```
* swift local build
```
swift build -c release
./.build/release/Backend
```


## RestAPI Endpoints
# `GET` /carriers

** List all supported carriers

### Request:

+ Headers:
    No specific headers needed.

+ Url Params:
    No specific query parameters needed.

+ Body:
    No specific body attributes needed.

***


### Response:

+ Status: **200**

+ Body:
```
[
    {
        "_id": "5a68d3ead74afa2ff77ab656",
        "name": "Irancell",
        "faName": "ایرانسل"
    }
]
```

# `POST` /order/new

** Create a new order and send them for payment

### Request:

+ Headers:
    No specific headers needed.

+ Url Params:
    No specific query parameters needed.

+ Body:
```
{
    "userName": "farzad",
    "carrierName": "Irancell"
}
```

***


### Response:

+ Status: **200**

+ Body:
```
{
    "orderID": "5a68ed9ee35e7262fa518965"
}
```

# `GET` /order/user

** Fetch all paid/unpaid user orders

### Request:

+ Headers:
    No specific headers needed.

+ Url Params:
    + `userName`: farzad

+ Body:
    No specific body attributes needed.

***


### Response:

+ Status: **200**

+ Body:
```
[
    {
        "creationDate": 538518814.7379999,
        "_id": "5a68ed9ee35e7262fa518965",
        "carrier": "5a68d3ead74afa2ff77ab656",
        "isPaid": false,
        "userName": "farzad"
    }
]
```

# `POST` /order/obtainCode

** Verify payment and get your code

### Request:

+ Headers:
    No specific headers needed.

+ Url Params:
    No specific query parameters needed.

+ Body:
```
{
    "userName": "farzad",
    "orderID": "5a68ed9ee35e7262fa518965",
    "paymentRefrence": "12345ABCa"
}
```

***


### Response:

+ Status: **200**

+ Body:
```
{
    "code": "AAAA-AAAA-AAAA"
}
```

# `GET` /inventory/user

** Fetch prev bought user items

### Request:

+ Headers:
    No specific headers needed.

+ Url Params:
    + `userName`: farzad

+ Body:
    No specific body attributes needed.

***


### Response:

+ Status: **200**

+ Body:
```
[
    {
        "code": "568347129087493265",
        "isActive": false,
        "_id": "5a68d5a470f2bd50eb6f25f6",
        "carrier": "5a68d3ead74afa2ff77ab656",
        "userName": "farzad"
    },
    {
        "code": "AAAA-AAAA-AAAA",
        "isActive": false,
        "_id": "5a68d7aa0267f27fdac30ae2",
        "carrier": "5a68d3ead74afa2ff77ab656",
        "userName": "farzad"
    }
]
```

