# API Keys

## Get Current Key

Returns information about the API key making the request. Use it to check which key an integration is running with and how many requests that key has made.

### HTTP Request

`GET https://api.charityapi.org/api/keys/self`

This endpoint takes no parameters and requires an API key. It is not available with OAuth tokens.

<!-- tabs-open -->

### curl

```shell
curl "https://api.charityapi.org/api/keys/self" \
  -H "Authorization: Bearer apikeyhere"
```

<!-- tabs-close -->

Responses:

<!-- tabs-open -->

### Success

```json
{
  "data": {
    "identifier": "live-********************************************************************hH1X5eRc",
    "request_count": 1042
  }
}
```

<!-- tabs-close -->

Field | Description
----- | -----------
identifier | Your API key, masked. Only the first five and last eight characters are shown, so the full key is never echoed back.
request_count | The number of requests made with this key.
