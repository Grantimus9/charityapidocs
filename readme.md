# Charityapi.org Documentation

## These Docs Are Not Complete

These docs are not quite stable yet.

## Getting Started

Create an account at <https://www.charityapi.org>, grab your API keys.

## Authentication

The API expects an HTTP header of apikey="yourkeyhere" and requests of type "Application/JSON"


# Examples

## Simple Charity Check Plan / Endpoint
[Ruby](###ruby)
[Elixir](###elixir)


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
