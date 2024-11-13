defmodule Finix.IdentitiesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "create a identity for a buyer" do
    test "create a identity for a buyer" do
      use_cassette "identities/create" do
        {:ok, response} =
          Finix.Identities.create(%{
            tags: %{
              key: "value"
            },
            entity: %{
              phone: "7145677613",
              first_name: "Bob",
              last_name: "Diaz",
              email: "therocktest@gmail.com",
              personal_address: %{
                city: "San Mateo",
                country: "USA",
                region: "CA",
                line2: "Apartment 7",
                line1: "741 Douglass St",
                postal_code: "94114"
              }
            }
          })

        refute response == %{}
        refute response[:id] == nil
      end
    end
  end
end
