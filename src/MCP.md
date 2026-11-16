# MCP Server

CharityAPI.org runs a [Model Context Protocol](https://modelcontextprotocol.io) (MCP) server so Claude and other MCP-compatible agents can look up US nonprofit data directly, without you writing any glue code. MCP support is in alpha.

Endpoint: `POST https://api.charityapi.org/mcp`

The server speaks JSON-RPC 2.0 over HTTP and implements MCP protocol version `2024-11-05`. It supports the `initialize`, `tools/list` and `tools/call` methods. `GET /mcp` returns `405`; the endpoint is POST-only.

## Connecting

### Claude Code with OAuth

```shell
claude mcp add --transport http charityapi https://api.charityapi.org/mcp
```

Claude Code opens your browser to authorize access to your CharityAPI account. Click "Authorize" once; tokens refresh automatically after that. Restart Claude Code and the tools are available. You need a free [CharityAPI account](https://api.charityapi.org/signup).

### Claude Code with an API key

If your agent cannot open a browser, authenticate with a key instead. There is no authorization step.

```shell
claude mcp add --transport http charityapi https://api.charityapi.org/mcp \
  --header "Authorization: Bearer YOUR_API_KEY"
```

Keep the key out of shared configuration and treat it like a password.

### Other clients

Any client that supports remote (Streamable HTTP) MCP servers can connect to `https://api.charityapi.org/mcp`, either with an `Authorization: Bearer` header or through the OAuth flow below.

## OAuth

The server supports OAuth 2.0 authorization code flow with PKCE and dynamic client registration, so compliant clients can connect with no manual setup.

Purpose | URL
------- | ---
Authorization server metadata (RFC 8414) | `https://api.charityapi.org/.well-known/oauth-authorization-server`
Protected resource metadata (RFC 9728) | `https://api.charityapi.org/.well-known/oauth-protected-resource`
Dynamic client registration (RFC 7591) | `POST https://api.charityapi.org/mcp/register_client`
Authorization endpoint | `https://api.charityapi.org/mcp/authorize`
Token endpoint | `POST https://api.charityapi.org/mcp/token`

Setting | Value
------- | -----
Grant types | `authorization_code`, `refresh_token`
Response types | `code`
PKCE | Required; `S256`
Scopes | `api:read`, `api:write`
Token endpoint authentication | `none`, `client_secret_post`, `client_secret_basic`
Access token lifetime | 1 hour
Refresh token lifetime | 90 days

Access tokens start with `cat_` and refresh tokens with `crt_`. Send the access token as `Authorization: Bearer cat_...`. A refresh token sent as a Bearer token is rejected with `REFRESH_TOKEN_NOT_ALLOWED`. A user can revoke an authorization at any time, after which requests fail with `OAUTH_AUTHORIZATION_REVOKED`. See [Errors](errors.html).

OAuth access is rate limited to 100 requests/minute per user; see [Rate Limits](main.html#rate-limits).

## Tools

The server exposes 11 tools. Each maps to a REST endpoint and returns the same data.

Tool | Arguments | REST equivalent
---- | --------- | ---------------
get_organizations_since | `since` (required, `YYYY-MM-DD`) | [List Nonprofit Organizations](organizations.html)
get_organization_by_ein | `ein` (required, 9 digits) | [Get Nonprofit Organization By EIN](organizations.html)
get_organization_schema | none | [Organization Schema](organizations.html)
search_organizations | `term` (required), `state`, `city`, `cache` | [Search](organizations.html)
search_organizations_empty | none | Returns a single null result; useful for testing a connection
autocomplete_organizations | `term` (required), `cache` | [Autocomplete](organizations.html)
check_public_charity_status | `ein` | [Public Charity Check](public_charity_check.html)
get_ntee_code | `code` (required, e.g. `A01`) | [NTEE Codes](ntee_codes.html)
list_ntee_codes | none | [NTEE Codes](ntee_codes.html)
get_dataimport_status | `id` (required; an import ID or `recent`) | [Data Imports](data_imports.html)
get_current_key_info | none | [API Keys](keys.html)

Set `cache` to `"false"` on the search tools to bypass the cache.

## Example

Calling a tool directly over HTTP:

<!-- tabs-open -->
### curl
```shell
curl -X POST "https://api.charityapi.org/mcp" \
  -H "Authorization: Bearer keyhere" \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "tools/call",
    "params": {
      "name": "check_public_charity_status",
      "arguments": { "ein": "474262060" }
    }
  }'
```
<!-- tabs-close -->

## Try it out

Once connected, ask your agent things like:

- "Is EIN 47-4262060 a registered public charity?"
- "Find food banks in Phoenix, AZ."
- "What does NTEE code K30 mean?"
