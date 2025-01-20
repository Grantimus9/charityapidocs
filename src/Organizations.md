## List Nonprofit Organizations

### HTTP Request

`GET https://api.charityapi.org/api/organizations?since=YYYY-MM-DD`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
since | N/A | Required. You can query for all organizations that have been added to the IRS Publication 78 Business Master File since a given date by providing the date in the "since" query param. The parameter must be an iso8601 formatted date in the format YYYY-MM-DD. For example, use "2025-01-30" to query all organizations added after January 30th, 2025. Because the IRS updates date only once a month, we recommend only querying for new updates once a week and a lookback period of a month to ensure your database receives all incremental additions. Each new monthly publication includes approximately 7,000 new organizations, but each month varies. 

Examples: 

<!-- tabs-open -->

### curl

```shell
curl "https://api.charityapi.org/api/organizations?since=2025-01-01" \
  -H "apikey: apikeyhere"
```

<!-- tabs-close -->

Responses: 
<!-- tabs-open -->

### Success

```json
{
  "data": [{
     "zip": "20006-1631",
     "tax_period": 201712,
     "subsection": 3,
     "street": "1629 K ST NW STE 300",
     "status": 1,
     "state": "DC",
     "sort_name": null,
     "ruling": 201602,
     "revenue_amt": 81553,
     "pf_filing_req_cd": 0,
     "organization": 1,
     "ntee_cd": "K30",
     "name": "MEANS DATABASE INC",
     "income_cd": 3,
     "income_amt": 81553,
     "ico": "% MARIA ROSE BELDING",
     "group": 0,
     "foundation": 15,
     "filing_req_cd": 1,
     "ein": "474262060",
     "deductibility": 1,
     "classification": 1000,
     "city": "WASHINGTON",
     "asset_cd": 3,
     "asset_amt": 31245,
     "affiliation": 3,
     "activity": 0,
     "acct_pd": 12
  }, 
  {
     "zip": "20006-1631",
     "tax_period": 201712,
     "subsection": 3,
     "street": "123 Main Street",
     "status": 1,
     "state": "DC",
     "sort_name": null,
     "ruling": 201602,
     "revenue_amt": 81553,
     "pf_filing_req_cd": 0,
     "organization": 1,
     "ntee_cd": "K30",
     "name": "Fake Organization",
     "income_cd": 3,
     "income_amt": 81553,
     "ico": "% Executive Director Name",
     "group": 0,
     "foundation": 15,
     "filing_req_cd": 1,
     "ein": "123456789",
     "deductibility": 1,
     "classification": 1000,
     "city": "WASHINGTON",
     "asset_cd": 3,
     "asset_amt": 31245,
     "affiliation": 3,
     "activity": 0,
     "acct_pd": 12
  }
  ]
}  
```

### No Results

```json
{
    "data": []
}
```

<!-- tabs-close -->

## Get Nonprofit Organization By EIN

This endpoint retrieves a single nonprofit entry from the currently listed nonprofits in the IRS's Business Master File, indicating they are a nonprofit. This will return both charities and other nonprofits, like political organizations and insurance organizations. If a request for an EIN returns no results, that means the EIN is not a currently valid nonprofit with the IRS. 

### HTTP Request

`GET https://api.charityapi.org/api/organizations/:ein`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
ein | N/A | The Tax ID number / Employer Identification Number

<!-- tabs-open -->

### curl
```shell
curl "https://api.charityapi.org/api/organizations/:ein" \
  -H "apikey: apikeyhere"
```

<!-- tabs-close -->

If the EIN / tax ID number matches a nonprofit that's currently listed in the IRS database, it will be returned:

Responses
<!-- tabs-open -->

### Success

```json
{
  "data": {
     "zip": "20006-1631",
     "tax_period": 201712,
     "subsection": 3,
     "street": "1629 K ST NW STE 300",
     "status": 1,
     "state": "DC",
     "sort_name": null,
     "ruling": 201602,
     "revenue_amt": 81553,
     "pf_filing_req_cd": 0,
     "organization": 1,
     "ntee_cd": "K30",
     "name": "MEANS DATABASE INC",
     "income_cd": 3,
     "income_amt": 81553,
     "ico": "% MARIA ROSE BELDING",
     "group": 0,
     "foundation": 15,
     "filing_req_cd": 1,
     "ein": "474262060",
     "deductibility": 1,
     "classification": 1000,
     "city": "WASHINGTON",
     "asset_cd": 3,
     "asset_amt": 31245,
     "affiliation": 3,
     "activity": 0,
     "acct_pd": 12
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


## Organization Schema

The special `/api/organizations/schema` endpoint returns a minimal data dictionary, or field explanation for the organization attributes. This endpoint is designed to make it a little easier to integrate and understand the data elements as a developer, but is not suitable for displaying information to users in production. This data is straight from the [IRS explanation](https://www.irs.gov/pub/irs-soi/eo_info.pdf). 

### HTTP Request

`GET https://api.charityapi.org/api/organizations/schema`

<!-- tabs-open -->

### curl 

```shell
curl "https://api.charityapi.org/api/organizations/schema" \
  -H "apikey: apikeyhere"
```

<!-- tabs-close -->

Responses: 

<!-- tabs-open -->

### Success 

```json
{
    "acct_pd": "Accounting Period.\n        This designates the accounting period or fiscal year ending date (Jan - Dec) of the organization (MM).",
    "activity": "Description Not Available",
    "affiliation": "Organization Grouping, based on the following split:\n        1: Central - This code is used if the organization is a central type organization (no group exemption) of a National,\n        Regional or Geographic grouping of organizations.\n        2: Intermediate - This code is used if the organization is an intermediate organization (no group exemption) of a\n        National, Regional or Geographic grouping of organizations (such as a state headquarters of a national\n        organization).\n        3: Independent - This code is used if the organization is an independent organization or an independent auxiliary\n        (i.e., not affiliated with a National, Regional, or Geographic grouping of organizations).\n        6: Central - This code is used if the organization is a parent (group ruling) and is not a church or 501(c)(1)\n        organization.\n        7: Intermediate - This code is used if the organization is a group exemption intermediate organization of a National,\n        Regional or Geographic grouping of organizations.\n        8: Central - This code is used if the organization is a parent (group ruling) and is a church or 501(c)(1) organization.\n        9: Subordinate - This code is used if the organization is a subordinate in a group ruling.",
    "asset_amt": "Asset Amount.\n        Asset Amount is an amount from the most recent Form 990 series return filed by the organization. Asset Amount is the\n        Book Value Total Assets End of Year - PART X Balance Sheet Line 16 Col. (B) shown on the Form 990. This field is also\n        from PART II, Line 25, Col. (B) EOY on Form 990EZ and PART II, Line 16, Col. (b) on Form 990PF. This field is dollars\n        only.",
    "asset_cd": "Asset Codes relate to the book value amount of assets shown on the most recent Form 990 series return filed by the\n        organization.\n        ASSET CODE/INCOME CODE TABLE\n        Code Description($)\n        0 0\n        1 1 to 9,999\n        2 10,000 to 24,999\n        3 25,000 to 99,999\n        4 100,000 to 499,999\n        5 500,000 to 999,999\n        6 1,000,000 to 4,999,999\n        7 5,000,000 to 9,999,999\n        8 10,000,000 to 49,999,999\n        9 50,000,000 to greater",
    "city": "city",
    "classification": "Subsection Codes are the codes shown under section 501(c) of the Internal Revenue Code of 1986, which define the\n        category under which an organization may be exempt. A table of subsection and classification codes (which reflects a\n        further breakdown of the Internal Revenue Code subsections) can be found in the section entitled 'Table of EO Subsection\n        and Classification Codes' (https://www.irs.gov/pub/irs-soi/eo_info.pdf). One to four different classification codes may be present.",
    "deductibility": "Deductibility Code signifies whether contributions made to an organization are deductible.\n        1: Contributions are deductible.\n        2: Contributions are not deductible.\n        4: Contributions are deductible by treaty (foreign organizations).",
    "ein": "Employer Identification Number, or Tax ID Number",
    "filing_req_cd": "This indicates the primary return(s) the organization is required to file.\n        01 990 (all other) or 990EZ return\n        02 990 - Required to file Form 990-N - Income less than $25,000 per year\n        03 990 - Group return\n        04 990 - Required to file Form 990-BL, Black Lung Trusts\n        06 990 - Not required to file (church)\n        07 990 - Government 501(c)(1)\n        13 990 - Not required to file (religious organization)\n        14 990 - Not required to file (instrumentalities of states or political subdivisions)\n        00 990 - Not required to file (all other)",
    "foundation": "Foundation Code.\n        00 All organizations except 501(c)(3)\n        02 Private operating foundation exempt from paying excise taxes on investment income\n        03 Private operating foundation (other)\n        04 Private non-operating foundation\n        09 Suspense\n        10 Church 170(b)(1)(A)(i)\n        11 School 170(b)(1)(A)(ii)\n        12 Hospital or medical research organization 170(b)(1)(A)(iii)\n        13 Organization which operates for benefit of college or university and is owned or operated by a governmental\n        unit 170(b)(1)(A)(iv)\n        14 Governmental unit 170(b)(1)(A)(v)\n        15 Organization which receives a substantial part of its support from a governmental unit or the general public\n        170(b)(1)(A)(vi)\n        16 Organization that normally receives no more than one-third of its support from gross investment income and\n        unrelated business income and at the same time more than one-third of its support from\n        contributions, fees, and gross receipts related to exempt purposes. 509(a)(2)\n        17 Organizations operated solely for the benefit of and in conjunction with organizations described in 10 through\n        16 above. 509(a)(3)\n        18 Organization organized and operated to test for public safety 509(a)(4)\n        21 509(a)(3) Type I\n        22 509(a)(3) Type II\n        23 509(a)(3) Type III functionally integrated\n        24 509(a)(3) Type III not functionally integrated",
    "group": "This is a four-digit IRS-internal number assigned to central/parent organizations holding group exemption letters.",
    "ico": "In Care Of - the person to whom correspondence should be addressed.",
    "income_amt": "Income Amount is a computer generated amount from the most recent Form 990 series return filed by the organization.\n        Income Amount is computer generated using PART I, Total Revenue Line 12 and adding 'back in' the expense items, i.e.\n        Line 6b (Rental Expenses) shown on the Form 990 return. On Form 990EZ it is generated using PART I, Line 9 and\n        adding 'back in' the expense items, i.e. Line 5b (Cost or Other Basis Expenses). Income Amount for Form 990PF is\n        generated using Part I, Line 10b (Cost of Goods) and adding Part I, Line 12, Col. (A) (Total Revenue Col. A) and Part IV,\n        Line 1, Col. (G) (Cost or Other Basis). This field is dollars only.",
    "income_cd": "Income Codes relate to the amount of income shown on the most recent Form 990 series return filed by the organization.\n        ASSET CODE/INCOME CODE TABLE\n        Code Description($)\n        0 0\n        1 1 to 9,999\n        2 10,000 to 24,999\n        3 25,000 to 99,999\n        4 100,000 to 499,999\n        5 500,000 to 999,999\n        6 1,000,000 to 4,999,999\n        7 5,000,000 to 9,999,999\n        8 10,000,000 to 49,999,999\n        9 50,000,000 to greater",
    "name": "The name of the organization",
    "ntee_cd": "National Taxonomy of Exempt Entities Code.",
    "organization": "  This defines the type of organization as follows:\n        Code Description\n        1 Corporation\n        2 Trust\n        3 Co-operative\n        4 Partnership\n        5 Association",
    "pf_filing_req_cd": "1 990-PF return\n        0 No 990-PF return",
    "revenue_amt": "Amount from Form 990, Part 1, Line 12, or Part 1, Line 9, of Form 990EZ.",
    "ruling": "This is the month and year (YYYYMM) on a ruling or determination letter recognizing the organization's exempt status.",
    "sort_name": "Sort Name Line is another name under which the organization does business. Also used for trade names, chapter names,\n        or local numbers for subordinate organizations of group rulings. Check this field in addition to the name field when confirming identity.",
    "state": "state",
    "status": "The EO Status Code defines the type of exemption held by the organization. The following is a list of EO status codes and\n        their definitions included in these files:\n         Code Description\n        01 Unconditional Exemption\n        02 Conditional Exemption\n        12 Trust described in section 4947(a)(2) of the IR Code\n        25 Organization terminating its private foundation status under section 507(b)(1)(B) of the Code",
    "street": "Street Address Line 1",
    "subsection": "Subsection Codes are the codes shown under section 501(c) of the Internal Revenue Code of 1986, which define the category under which an organization may be exempt. A table of subsection and classification codes (which reflects a further breakdown of the Internal Revenue Code subsections) can be found in the section entitled 'Table of EO Subsection and Classification Codes' (https://www.irs.gov/pub/irs-soi/eo_info.pdf). One to four different classification codes may be present.",
    "tax_period": "This is the tax period of the latest return filed (YYYYMM).",
    "zip": "zip code"
}

```

<!-- tabs-close -->

## Search Nonprofits and Charities

Search the ~ 2 million public charities by search term. This endpoint requires at least 3 characters to return results, and will return the top results ordered by relevance and charity size. 

This searches the nonprofit "name" and "sort_name" fields. Organizations whose charitable status has lapsed will not appear in search results.

You may optionally filter results further by providing "city" and "state" parameters. 

### HTTP Request

`GET https://api.charityapi.org/api/organizations/search/:term`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
term | N/A | Search term. URL-encoded.
city | null | Filter results to only this city. This field is mildly typo tolerant, and requires at least two characters be provided. 
state | null | Filter results to only this state code, e.g. "AZ" or "IA". Use "PR" for Puerto Rico.

<!-- tabs-open -->
### curl
```shell
curl "https://api.charityapi.org/api/organizations/search/:term" \
  -H "apikey: apikeyhere"
```
<!-- tabs-close -->

Responses: 

<!-- tabs-open -->
### Success
```json
{
    "data": [
        {
         "zip": "20006-1631",
         "tax_period": 201712,
         "subsection": 3,
         "street": "1629 K ST NW STE 300",
         "status": 1,
         "state": "DC",
         "sort_name": null,
         "ruling": 201602,
         "revenue_amt": 81553,
         "pf_filing_req_cd": 0,
         "organization": 1,
         "ntee_cd": "K30",
         "name": "MEANS DATABASE INC",
         "income_cd": 3,
         "income_amt": 81553,
         "ico": "% MARIA ROSE BELDING",
         "group": 0,
         "foundation": 15,
         "filing_req_cd": 1,
         "ein": "474262060",
         "deductibility": 1,
         "classification": 1000,
         "city": "WASHINGTON",
         "asset_cd": 3,
         "asset_amt": 31245,
         "affiliation": 3,
         "activity": 0,
         "acct_pd": 12
       },
       {},
       {}
    ]
}
```
### No Results

```json
{
    "data": []
}
```

<!-- tabs-close -->

## Autocomplete

> #### Notice {: .neutral}
>
> The autocomplete endpoint is only available to paying accounts.

The autocomplete endpoint is designed to power your autocomplete (typeahead) features. This endpoint searches only the name field of all organizations, and is typo-tolerant, making it perfect for enabling your users to search for a charity by name.

You must provide at least 3 characters before results will be returned.

If you require more information about a charity, use the organizations endpoint: `GET https://api.charityapi.org/api/organizations/:ein`


### HTTP Request

`GET https://api.charityapi.org/api/organizations/autocomplete/:term`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
term | N/A | Search term. URL-encoded.

<!-- tabs-open -->
### curl
```shell
curl "https://api.charityapi.org/api/organizations/autocomplete/:term" \
  -H "apikey: apikeyhere"
```

<!-- tabs-close -->

Responses: 

<!-- tabs-open -->
### Success
```json
{
    "data": [
        {
         "name": "MEANS DATABASE INC",
         "ein": "474262060"
       },
       {
        "name": "MEANS OF GRACE",
        "ein": "825057778"
       },
       {}
    ]
}
```

### No Results

```json
{
    "data": []
}
```
<!-- tabs-close -->