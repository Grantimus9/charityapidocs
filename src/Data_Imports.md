# Data Imports

A Data Import represents a time CharityAPI.org retrieved and imported the latest data from the IRS. 

## Get Data Import By ID 
Retrieve a dataimport by its ID. 

### HTTP Request

`GET https://api.charityapi.org/api/dataimports/:id`

<!-- tabs-open -->
### curl
```shell
curl "https://api.charityapi.org/api/dataimports/:id" \
  -H "apikey: apikeyhere"
```
<!-- tabs-close -->


Responses: 

<!-- tabs-open -->

### Success
```json
{
    "data": {
        "completed": true,
        "crawled_urls": [
            "https://www.irs.gov/pub/irs-soi/eo1.csv",
            "https://www.irs.gov/pub/irs-soi/eo2.csv",
            "https://www.irs.gov/pub/irs-soi/eo3.csv",
            "https://www.irs.gov/pub/irs-soi/eo4.csv"
        ],
        "id": 355,
        "inserted_at": "2022-09-19T00:00:00",
        "name": "Data Import 2022-09-19",
        "s3_path": "redacted",
        "s3_urls": "redacted",
        "to_crawl_urls": [
            "https://www.irs.gov/pub/irs-soi/eo1.csv",
            "https://www.irs.gov/pub/irs-soi/eo2.csv",
            "https://www.irs.gov/pub/irs-soi/eo3.csv",
            "https://www.irs.gov/pub/irs-soi/eo4.csv"
        ],
        "updated_at": "2022-09-19T02:16:04"
    }
}
```

### Data Import In Progress
If a dataimport is currently in progress, it will show `"completed": false`. 

```json
{
    "data": {
        "completed": false,
        "crawled_urls": [
            "https://www.irs.gov/pub/irs-soi/eo1.csv",
            "https://www.irs.gov/pub/irs-soi/eo2.csv"
        ],
        "id": 600,
        "inserted_at": "2023-09-19T00:00:00",
        "name": "Data Import 2023-09-19",
        "s3_path": "redacted",
        "s3_urls": "redacted",
        "to_crawl_urls": [
            "https://www.irs.gov/pub/irs-soi/eo1.csv",
            "https://www.irs.gov/pub/irs-soi/eo2.csv",
            "https://www.irs.gov/pub/irs-soi/eo3.csv",
            "https://www.irs.gov/pub/irs-soi/eo4.csv"
        ],
        "updated_at": "2023-09-19T02:16:04"
    }
}
```

### No Results 

```json
{
    "data": null
}
```

<!-- tabs-close -->

## Get Recent Data Imports 
You can also retrieve the most recent dataimports by providing the string "recent" instead of a dataimport ID. This will return an object with 3 keys: 

Key | Description | Notes
--------- | ------- | -----------
in_progress_dataimport | The data import currently in progress, if any | null if none in progress
most_recent_complete_dataimport | The most recent data import that's complete | N/A
most_recent_dataimport | The most recent data import regardless of status | N/A

The same data import may appear in multiple keys; for example if it is both the most recent and complete data import.

### HTTP Request

`GET https://api.charityapi.org/api/dataimports/recent`

<!-- tabs-open -->

### curl
```shell
curl "https://api.charityapi.org/api/dataimports/recent" \
  -H "apikey: apikeyhere"
```
> Returns a list of dataimports. 
<!-- tabs-close -->

Responses: 

<!-- tabs-open -->
```json
{
    "data": {
        "in_progress_dataimport": null,
        "most_recent_complete_dataimport": {
            "completed": true,
            "crawled_urls": [
                "https://www.irs.gov/pub/irs-soi/eo1.csv",
                "https://www.irs.gov/pub/irs-soi/eo2.csv",
                "https://www.irs.gov/pub/irs-soi/eo3.csv",
                "https://www.irs.gov/pub/irs-soi/eo4.csv"
            ],
            "id": 357,
            "inserted_at": "2022-10-17T04:00:00",
            "name": "Data Import 2022-10-17",
            "s3_path": "redacted",
            "s3_urls": "redacted",
            "to_crawl_urls": [
                "https://www.irs.gov/pub/irs-soi/eo1.csv",
                "https://www.irs.gov/pub/irs-soi/eo2.csv",
                "https://www.irs.gov/pub/irs-soi/eo3.csv",
                "https://www.irs.gov/pub/irs-soi/eo4.csv"
            ],
            "updated_at": "2022-10-17T07:51:42"
        },
        "most_recent_dataimport": {
            "completed": true,
            "crawled_urls": [
                "https://www.irs.gov/pub/irs-soi/eo1.csv",
                "https://www.irs.gov/pub/irs-soi/eo2.csv",
                "https://www.irs.gov/pub/irs-soi/eo3.csv",
                "https://www.irs.gov/pub/irs-soi/eo4.csv"
            ],
            "id": 357,
            "inserted_at": "2022-10-17T04:00:00",
            "name": "Data Import 2022-10-17",
            "s3_path": "redacted",
            "s3_urls": "redacted",
            "to_crawl_urls": [
                "https://www.irs.gov/pub/irs-soi/eo1.csv",
                "https://www.irs.gov/pub/irs-soi/eo2.csv",
                "https://www.irs.gov/pub/irs-soi/eo3.csv",
                "https://www.irs.gov/pub/irs-soi/eo4.csv"
            ],
            "updated_at": "2022-10-17T07:51:42"
        }
    }
}
```
<!-- tabs-close -->