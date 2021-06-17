![weather_Be](https://user-images.githubusercontent.com/72950188/122404437-d862a000-cf44-11eb-94fa-24f94010aaac.png)
<div align="center">
  <p>With this Sinatra based webapp, you can easily check the weather from an API OpenWeatherMap and few other stuff.</p>
</div>

# Hello 

Welcome to Weather Be! 

This Sinatra based webapp was built to give you a quick update of the weather on your location and also in any city you ask for. It will provide headlines of BBC news as a plus and some Photos from unsplash API. 

So what can I do with this gem: 

- Check the current weather at your location and Forecast for the next 6 days 
- Check the current weather and Forecast for the next 6 days at any city you name in the world.

-  It gives you 1 unit system: 
  - Metric (temperatures in Celsius)
  

- Read and open in your browser the latest world headlines from BBC News. 
- Read the lastest weather news Worldwide.
- You will be able to register and create your own profile, add locations, update and delete them. 

## Important information 

Before running the App is important to: 

- Sign up for a API key on [OPENWEATHERMAP](https://openweathermap.org/). It's free
- Sign up for a API key on [NEWSAPI](https://newsapi.org/). Also Free. 
- Sign up for a API key on [Unsplash](https://unsplash.com/developers).
- Sign up for a API key on [Flickr](https://www.flickr.com/services/api/).
- Sign up for a API key on [Google API](https://console.cloud.google.com/apis/dashboard). For your location on Google Maps

Please don't forget to create a `.env` for the root of the project. This will hide your API Keys and avoid being published on your repository in case you fork it. 

Inside the `.env` file add the following 3 lines of code:

```cassandraql
API_KEY = YOURKEY
API_NEWS = YOURKEY
etc........ 
```

"Voila" you are ready to check the weather,news and photos. 

## Getting Started

- Clone the repo: git clone https://github.com/JcBonassin/Weather_real.git
- Install gems bundle install
- Run migrations rake db:migrate
- Start the server Shotgun
- Navigate to your local server http://127.0.0.1:9393/


## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are greatly appreciated.

- Fork the Project
- Create your Feature Branch (git checkout -b feature/AmazingFeature)
- Commit your Changes (git commit -m 'Add some AmazingFeature')
- Push to the Branch (git push origin feature/AmazingFeature)
- Open a Pull Request

Bug reports and pull requests are welcome on GitHub at https://github.com/<github username>/weather_today. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/<github username>/weather_today/blob/master/CODE_OF_CONDUCT.md).

## Copyright and License

This project is licensed under the terms of the [MIT License](https://opensource.org/licenses/MIT).
Copyright (c) 2021, [Jc Bonassin](https://www.jcbonassin.net/).


