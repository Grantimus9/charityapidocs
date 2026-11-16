# Errors

When a request fails, the API responds with a non-2xx HTTP status and a JSON body in a consistent envelope:

```json
{
  "error": {
    "message": "Human-readable description of what went wrong",
    "code": "MACHINE_READABLE_CODE",
    "details": {}
  }
}
```

Field | Description
----- | -----------
message | A human-readable explanation. Suitable for logs, not for showing to end users; wording may change.
code | A stable, machine-readable identifier. Branch on this, not on `message`.
details | Optional. Extra context for some codes, such as the offending parameter. Omitted when there is nothing to add.

## Error Codes

### Authentication

These are returned with HTTP status `401`. See [Authentication](authentication.html).

Code | Meaning
---- | -------
MISSING_AUTHENTICATION | No key was sent. Provide `Authorization: Bearer <key>` or the legacy `apikey` header.
INVALID_API_KEY | The key sent in the `apikey` header is not recognized.
INVALID_BEARER_TOKEN | The key sent as a Bearer token is not recognized.
INVALID_BEARER_FORMAT | The `Authorization` header is present but is not in the form `Bearer <key>`.
INVALID_OAUTH_TOKEN | The OAuth access token is invalid or expired. Refresh it or start the OAuth flow again.
OAUTH_AUTHORIZATION_REVOKED | The user revoked this OAuth authorization. Re-authorize to continue.
REFRESH_TOKEN_NOT_ALLOWED | A refresh token was sent as a Bearer token. Use the access token instead.

### Permissions and limits

Code | HTTP status | Meaning
---- | ----------- | -------
INSUFFICIENT_PERMISSIONS | 403 | The key is valid but is not allowed to use this endpoint, for example autocomplete on a free account.
RATE_LIMITED | 429 | You exceeded your rate limit. See [Rate Limits](main.html#rate-limits).

### Request errors

Code | HTTP status | Meaning
---- | ----------- | -------
MISSING_REQUIRED_PARAMETER | | A required parameter was not supplied. `details.parameter` names it and `details.expected_format` describes what to send.
INVALID_FORMAT | 422 | A parameter was malformed, for example a date that is not in the `YYYY-MM-DD` format.
VALIDATION_ERROR | 422 | The request failed validation. `details.validation_errors` maps each field to its messages.
FORBIDDEN_ORIGIN | | The request's origin is not allowed to call this API.
GENERIC_ERROR | | A failure without a more specific code.

### Not found and server errors

Responses that do not match a code above use a code of the form `HTTP_<status>`, for example `HTTP_404` or `HTTP_500`.

A `404` also includes `"data": null` alongside the error, so clients written against the older response shape keep working:

```json
{
  "error": {
    "message": "Not Found",
    "code": "HTTP_404"
  },
  "data": null
}
```

Looking up an EIN that is not a currently listed nonprofit is not an error. It returns `200` with `{"data": null}`; see [Organizations](organizations.html).

## MCP errors

The [MCP server](mcp.html) returns the same error codes inside tool results, and standard JSON-RPC error objects for protocol-level failures.
