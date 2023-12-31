# Scraper with Elixir & Hound    
An Elixir-based crawler using Hound and Floki, with a webdriver. This scraper ran well with Elixir 1.4.1 and Erlang/OTP 25, on Arch Linux.

## Getting a webdriver
Since we need to interact with the page a little, you'll need to install a webdriver.
### For Burpple Hound
1. Download and install a chromedriver here (make sure it supports your Google Chrome version): [Versions 115 & later](https://googlechromelabs.github.io/chrome-for-testing/#stable), [Older Versions](https://chromedriver.chromium.org/downloads)
2. Run in terminal: `chromedriver`

### For Lemon8, Explorest & GMaps Hound
1. Download and install a Selenium webdriver here (make sure you have java installed): [Selenium Driver](https://selenium-release.storage.googleapis.com/index.html?path=3.9/)
2. Run the webdriver with`java -jar selenium-server-standalone-3.9.1.jar`
## Run the scraper
1. Run in terminal: `mix deps.get`
2. Run in terminal:
   - `iex -S mix run -e "Burpple.Hound.run"` for Burpple
   - `iex -S mix run -e "Lemon8.Hound.run"` for Lemon8
   - `iex -S mix run -e "Explorest.Hound.run"` for Explorest
   - `iex -S mix run -e "GMaps.Hound.run"` for Google Maps
   
## Configuring the scraper
### config.exs
For burpple, the config should be: `config :hound, driver: "chrome_driver", browser: "chrome_headless", server: true` <br/>
For lemon8 or explorest, the config should be: `config :hound, host: "http://localhost", port: 4444, path_prefix: "wd/hub/"`

### burpple_hound.ex
`@neighbourhood`: Sets the neighbourhood to be scraped. Ensure that it's available on Burpple. <br/>
`@limit`: Sets when to stop scraping (default 4000)
`@file_path`: Sets the file path to save data in

### lemon8_hound.ex
`@url`: Sets the url to be scraped, currently scraping #singaporefood page of Lemon8. </br>
`@file_path`: Sets the file path to save data in

### explorest_hound.ex
`@neighbourhood`: Sets the neighbourhood to be scraped. Ensure that it's available on Explorest. <br/>
`@file_path`: Sets the file path to save data in

### gmaps_hound.ex
`@search_term`: Sets the search term to input into Google Maps <br/>
`@file_path`: Sets the file path to save data in <br/>
`@limit`: Sets when to stop scraping (default 100) <br/>
`@panels_skip`: Sets the number of panels to skip (to avoid clicking ads; see photo below) <br/>
![image](https://github.com/faezlatiff/Midas/assets/113258483/b41fe428-4b25-43d2-8994-5619a53790d8)


