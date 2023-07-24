defmodule AtlasSpider do
  use Crawly.Spider
  import Meeseeks.CSS

  @impl Crawly.Spider
  def base_url do
    "http://www.burpple.com"
  end

  @impl Crawly.Spider
  def init() do
    [
      start_urls: [
        "https://www.burpple.com/neighbourhoods/sg/chinatown"
      ]
    ]
  end

  @impl Crawly.Spider
  def parse_item(response) do
    document = Meeseeks.parse(response.body)
    url = "https://www.burpple.com"

    style = Meeseeks.one(document, css("#load-more-reviews"))

    review_list =
      Meeseeks.all(document, css(".food.card.feed-item"))
      |> data_to_list(url)

    %Crawly.ParsedItem{:items => review_list, :requests => []}

  end

  defp data_to_list(reviews, url) do
    items = []
    reviews
    |> Enum.map(fn review ->

      shop_name = Meeseeks.one(review, css(".food-venue-detail--title")) |> Meeseeks.text()
      shop_address = Meeseeks.one(review, css(".food-venue-detail--address")) |> Meeseeks.text()
      review_title = Meeseeks.one(review, css(".food-description-title")) |> Meeseeks.text()
      review_description = Meeseeks.one(review, css(".food-description-body")) |> Meeseeks.text()
      review_link =  "#{url}#{Meeseeks.one(review, css(".food-image")) |> Meeseeks.one(css("a")) |> Meeseeks.attr("href")}"

      item =
      %{
        shop_name => %{
          "address" => shop_address,
          "title" => review_title,
          "description" => review_description,
          "link" => review_link
        }
      }

      [ item | items ]

      end)

    |> List.flatten()

  end

  # defp load_more_request(offset) do
  #   xhr = "https://www.burpple.com/foods/load_more?area_id=18&city_id=1&offset=#{offset}"

  #   %Crawly.Request{
  #     url: xhr,
  #     callback: &parse_item/1,
  #     meta: %{}
  #   }
  # end

end
