# Authentication

CharityAPI.org expects all API requests to be authenticated by passing your API key in the http 'apikey' header. 

Example: 

<!-- tabs-open -->
### curl
```shell
curl "https://api.charityapi.org/api/organizations/search/food" \
  -H "apikey: keyhere"
```

<!-- tabs-close -->


HTTP Header | Value
---------- | -------
apikey | Your API Key

When you [register](https://api.charityapi.org/signup) you will receive 2 API Keys; one live (prefixed with `live-`) and one test (prefixed with `test-`). Calls with the test key will return validly-shaped but bogus data; you can use it in development but we don't recommend using it for your test suite or CI. For your test suite, please mock or stub out the responses from this API.

API Key Examples:

Key Type | Example Value
---------- | -------
Live | live-PKDv6IZSgxXEJzGnQLIdDsObIpr1PpA5NQd0VbKh2JZaaTkxsH1X5eRcbsyEiOVhPWOOYVoD3zTrXVyO
Test | test-aaRkxsH1X5eRcbsyEiOVhPWOOYVoD3zTrXVyOPKDv6IZSgxXEJzGnQLIdDsObIpr0PpA5NQz0VbQh2JZ