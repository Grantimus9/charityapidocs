# Introduction

Welcome to the CharityAPI.org API Reference!

Here you'll find the full reference for the CharityAPI.org API, including authentication, [error handling](errors.html), and
links to more information where interesting. If you have any questions or requests for API support, please feel free to [reach out](https://www.charityapi.org/contact).

Base URL: `https://api.charityapi.org`

Authentication: Required; send your key as `Authorization: Bearer <key>`. The legacy `apikey` header is also accepted. See [Authentication](authentication.html).

[Contact](https://www.charityapi.org/contact)

## For AI Agents and Tools

- [MCP Server](mcp.html): connect Claude and other MCP-compatible agents directly to CharityAPI.
- [OpenAPI specification](https://docs.charityapi.org/openapi.yaml): machine-readable description of the REST API.
- [llms.txt](https://docs.charityapi.org/llms.txt): a short index of these docs for language models.

## Rate Limits

Limits are applied per key on a rolling basis.

Access | Limit
------ | -----
Free API key | 200 requests/hour
Paid API key | 10,000 requests/hour by default
OAuth / MCP access | 100 requests/minute per user

OAuth access, used by [MCP](mcp.html) clients, is limited per user rather than per key, and is separate from your API key limits. Requests over the limit receive a `429` with the code `RATE_LIMITED`; see [Errors](errors.html).
