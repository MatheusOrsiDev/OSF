public class WeatherWrapper {

    @AuraEnabled
    public List<Weather> weather;

    @AuraEnabled
    public Main main;
    
    public class Weather{

        @AuraEnabled
        public String description;

        @AuraEnabled
        public String icon;
    }

    public class Main{

        @AuraEnabled
        public Decimal temp;
    }
}
