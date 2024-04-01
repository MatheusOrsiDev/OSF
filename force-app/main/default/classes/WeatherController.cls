public with sharing class WeatherController {
    @AuraEnabled(cacheable=true)
    public static WeatherWrapper getWeather(String lat, String lon) {

        try{

            String apiKey = 'a7b5f1c8f58b997bf986d8d2ebb64d81';
            String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?lat=' + lat + '&lon=' + lon + '&appid=' + apiKey + '&units=metric';

            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(apiUrl);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            
            if(response.getStatusCode() == 200) {

                WeatherWrapper weatherWrapper = (WeatherWrapper)JSON.deserialize(response.getBody(), WeatherWrapper.class);

                system.debug(weatherWrapper.weather[0].description);
                system.debug(weatherWrapper.main.temp);

                return weatherWrapper;
            }
            
        } catch(Exception e) {
            throw new AuraHandledException(e.getMessage());
            //System.debug('The following exception has occurred: ' + e.getMessage());
        }   
        return null;
    }
}
