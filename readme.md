# Charityapi.org Documentation

A simple API that allows you to quickly check if a given charity (by tax ID number/EIN) is listed
on the IRS' list of charities. The IRS publishes the data in large .csv files about once a month. Charityapi.org retrieves and parses these csv files, then makes them available over an API. Charityapi.org is relied upon by tech-forward charities and companies that need to quickly check charitable status.

[Charity API: Charityapi.org on Medium](https://medium.com/@grantmnelsn/charity-api-charityapi-org-723931738774)


## Getting Started

Create an account at <https://www.charityapi.org>, grab your API keys.
The live API keys start with "live-" and the test ones begin with "test-".

## Authentication

The API expects an HTTP header of apikey="yourkeyhere" and requests of type "Application/JSON"


# Examples

## Simple Charity Check Plan / Endpoint
[Ruby](https://github.com/Grantimus9/charityapidocs#ruby)

[Elixir](https://github.com/Grantimus9/charityapidocs#elixir)


### Ruby

```ruby
  # using HTTParty Gem
  # set environment variable CHARITYAPIORG_APIKEY to your provided API key
 def is_public_charity?(tax_id_number:)
   response =
    JSON.parse(
      HTTParty.get(
        "https://www.charityapi.org/api/public_charity_check/" + tax_id_number.to_s,
        :headers => {
          "apikey" => ENV['CHARITYAPIORG_APIKEY']
        }
      ).body)

    result = response.dig "data", "public_charity"
    result ? result : false # Return true only if the API returned true.
 end
```

### Elixir

```elixir
  # Using HTTPoison hex package and Jason hex package.
  # Call MyAwesomeApp.CharityCheck.is_public_charity?(tax_id_here) to get response
defmodule MyAwesomeApp.CharityCheck do

  def is_public_charity?(tax_id_number) when is_integer(tax_id_number), do: {:error, "Must be a string because tax ID numbers can have leading zeros and are not of uniform length."}
  def is_public_charity?(tax_id_number) when is_binary(tax_id_number) do
    # Retrieve key from ENV; this example works for Heroku.
    apikey = System.get_env("CHARITYAPIORG_APIKEY")

    headers = [apikey: apikey, "Content-Type": "Application/json"]

    url = "https://www.charityapi.org/api/public_charity_check/" <> tax_id_number
    case HTTPoison.get(url, headers) do
      {:ok, response} ->
        # success
        handle_response(response)

      {:error, error} ->
        {:error, error}
    end
  end

  def handle_response(response) do
    {:ok, decoded_body} = response.body |> Jason.decode()
    case Map.has_key?(decoded_body, "data") do
      true ->
        decoded_body["data"]["public_charity"]

      false ->
        case Map.has_key?(decoded_body, "errors") do
          true ->
            {:error, decoded_body["errors"]}

          _ ->
            {:error, "Malformed Response From Charityapi Server"}
        end
    end
  end

end
```
