# Authentication

CharityAPI.org authenticates every API request with your API key. The recommended method is the standard `Authorization: Bearer` header.

Example:

<!-- tabs-open -->
### curl
```shell
curl "https://api.charityapi.org/api/organizations/search/food" \
  -H "Authorization: Bearer keyhere"
```

<!-- tabs-close -->

HTTP Header | Value | Status
---------- | ------- | ------
Authorization | `Bearer <your API key>` | Recommended
apikey | Your API key | Legacy; still supported

Both headers accept the same keys and behave identically. New integrations should use `Authorization: Bearer`. If you send both, the `Authorization` header is used. Requests with no key, a malformed `Authorization` header or an unknown key are rejected with a `401`; see [Errors](errors.html) for the codes.

When you [register](https://api.charityapi.org/signup) you will receive 2 API Keys; one live (prefixed with `live-`) and one test (prefixed with `test-`). Calls with the test key will return validly-shaped but bogus data; you can use it in development but we don't recommend using it for your test suite or CI. For your test suite, please mock or stub out the responses from this API.

API Key Examples:

Key Type | Example Value
---------- | -------
Live | live-PKDv6IZSgxXEJzGnQLIdDsObIpr1PpA5NQd0VbKh2JZaaTkxsH1X5eRcbsyEiOVhPWOOYVoD3zTrXVyO
Test | test-aaRkxsH1X5eRcbsyEiOVhPWOOYVoD3zTrXVyOPKDv6IZSgxXEJzGnQLIdDsObIpr0PpA5NQz0VbQh2JZ

## OAuth for AI agents

AI agents that connect through the [MCP server](mcp.html) can authenticate with OAuth 2.0 instead of a key. Tokens obtained this way are accepted on the REST API as well, as `Authorization: Bearer <access token>`. See [MCP Server](mcp.html) for the flow and its separate rate limit.
