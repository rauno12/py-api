
<!-- GETTING STARTED -->
## Getting Started

### Installation

1. Install MySQL database if needed

2. Install Python ant it's prerequisites
   
   This demo runs on Python 3.6.9, and the packages listed in
   requirements.txt. Install them with `pip -r requirements.txt`
   
3. Create a database and user for the api.

    ```sh
    CREATE DATABASE api COLLATE = 'utf8_general_ci';
    
    CREATE USER 'apiuser'@'localhost' IDENTIFIED BY 'password';
    
    GRANT SELECT, INSERT, UPDATE ON api.* TO apiuser@localhost;
    
    FLUSH PRIVILEGES;
    ```

4. Create the tables into database:
    
    run `schema.sql` in your mysql console
    
5. Insert initial data into database

    run `migra.sql` in your mysql console
    
6. Run the API

    run `api.py` in your process manager


<!-- USAGE EXAMPLES -->
## Usage

### Sectors

Service to get all available sectors (parent child structure)

**Request:**
```
GET /sectors HTTP/1.1
```

**Response (example):**
```
[
  {
    "id": 1,
    "parent_id": null,
    "name": "Manufacturing"
  },
  {
    "id": 2,
    "parent_id": 1,
    "name": "Construction materials"
  },
  {
    "id": 3,
    "parent_id": 1,
    "name": "Electronics and Optics"
  }
]
```

### Submissions

Services for handling user sessions and submitted data from *TEST.html*

The key concept is:
* New user (without existing session_id) lands on the *TEST.html*
* User will fill the form and submit
* Submitted data will be POST to API (*/submission/0*) where data will be store and (generated) session_id returned
* Returned session_id will be stored to user cookie
* User can edit and save his data while session is valid
* User data is modified trough API using session_id as reference (PUT */submission/{session_id}*)
* FYI: New session can be start by deleting exiting session cookie


The use case is that user lands on the page (no existing session). User will fill the form and submit data. Data 

#### New session
**Request:**
```
PUT /submission/0 HTTP/1.1

{
  "username": "Juhan",
  "is_agree_of_terms": true,
  "sectors": [
    {
      "sector_id": 15
    },
    {
      "sector_id": 16
    },
    {
      "sector_id": 17
    },
    {
      "sector_id": 18
    }
  ]
}
```
**Response:**
```
HTTP/1.1 201 Created

{
  "session_id": "93bb670b78ae4376a3d04f5edcde0320"
}
```

#### Existing session
**Request:**
```
POST /submission/{session_id} HTTP/1.1

{
  "username": "Jaan",
  "is_agree_of_terms": true,
  "sectors": [
    {
      "sector_id": 5
    },
    {
      "sector_id": 6
    }
  ]
}
```
**Response:**
```
HTTP/1.1 204 No Content
```

#### Get submission
**Request:**
```
GET /submission/{session_id} HTTP/1.1
```

**Response:**
```
HTTP/1.1 200 OK

{
  "username": "Jaan",
  "is_agree_of_terms": true,
  "sectors": [
    {
      "sector_id": 5
    },
    {
      "sector_id": 6
    }
  ]
}
```