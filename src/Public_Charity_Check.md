# Public Charity Check

This public charity check makes it simple to confirm whether or not a tax ID number is a real charity and tax deductible. Send the API the tax ID number and it will respond with a simple true/false indicating that organization's current status. This endpoint is commonly used to reconfirm your list of organizations are still in good standing with the IRS and donations are still tax deductible.

[Blog Post Introducing the simple Charity Check API](https://www.charityapi.org/post/charity-data-api)

### HTTP Request

`GET https://api.charityapi.org/api/public_charity_check/:ein`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
ein | N/A | The Tax ID number / Employer Identification Number


<!-- tabs-open -->

### curl
```shell
curl "https://api.charityapi.org/api/public_charity_check/:ein" \
  -H "apikey: apikeyhere"
```
<!-- tabs-close -->

Responses:

<!-- tabs-open -->
### Public Charity
```json
{
    "data": {
        "public_charity": true,
        "ein": "474262060"
    }
}
```

### Not Public Charity
```json
{
    "data": {
        "ein": "1",
        "public_charity": false
    }
}
```
<!-- tabs-close -->

