# NTEE Codes 

The National Taxonomy of Exempt Entities (NTEE) is a taxonomy designed to classify all nonprofit entities by activity type. 

Nonprofits choose the most appropriate code for their activities, and the IRS provides this code in the publication 78 data (tax exempt entities). 

For each organization, you will see a `ntee_cd` NTEE code field that you can then use to lookup the NTEE code for the organization. 

## List NTEE Codes 
Lists all NTEE Codes observed in IRS data. Many codes do not have a title or definition. There are many NTEE codes, making this a particularly large json response. 

### HTTP Request

`GET https://api.charityapi.org/api/ntee_codes`


<!-- tabs-open -->

### curl
```shell
curl "https://api.charityapi.org/api/ntee_codes" \
  -H "apikey: apikeyhere"
```
<!-- tabs-close -->

Responses 

<!-- tabs-open -->
### Success
```json 
{
    "data": [
        {
            "code": "X900",
            "definition": null,
            "title": null
        },
        {
            "code": "U99",
            "definition": "Use this code for organizations that clearly provide science and technology research services where the major purpose is unclear enough that a more specific code cannot be accurately assigned.",
            "title": "Science & Technology N.E.C."
        },
        {
            "code": "V01",
            "definition": "Organizations whose activities focus on influencing public policy within the Social Science Research Institutes, Services major group area. Includes a variety of activities from public education and influencing public opinion to lobbying national and state legislatures.",
            "title": "Alliances & Advocacy"
        }
    ]
}

```
<!-- tabs-close -->

## Get NTEE category By Code 

Get a specific NTEE category by code. 

### HTTP Request

`GET https://api.charityapi.org/api/ntee_codes/:code`


<!-- tabs-open -->
```shell
curl "https://api.charityapi.org/api/ntee_codes/:code" \
  -H "apikey: apikeyhere"
```
<!-- tabs-close -->

> Sample response for https://api.charityapi.org/api/ntee_codes/U99 

Responses: 

<!-- tabs-open -->
```json 
{
    "data": {
        "code": "U99",
        "definition": "Use this code for organizations that clearly provide science and technology research services where the major purpose is unclear enough that a more specific code cannot be accurately assigned.",
        "title": "Science & Technology N.E.C."
    }
}
```

### No Results 

> Returns null if there is no matching code 

```json 
{
    "data": null
}
```
<!-- tabs-close -->