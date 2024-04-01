import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getWeather from '@salesforce/apex/WeatherController.getWeather';


import ACCOUNT_LAT_FIELD from '@salesforce/schema/Account.BillingLatitude';
import ACCOUNT_LON_FIELD from '@salesforce/schema/Account.BillingLongitude';

export default class WeatherComponent extends LightningElement {
    @api recordId;
    weatherData;
    weatherIconUrl;
    weatherDescription;

    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_LAT_FIELD, ACCOUNT_LON_FIELD] })
    account;

    @wire(getWeather, { lat: '$account.data.fields.BillingLatitude.value', lon: '$account.data.fields.BillingLongitude.value'})
    wiredWeather({ error, data }) {
        if (data) {

            this.weatherData = data;
            this.weatherDescription = data.weather[0].description;
            
            this.weatherIconUrl = 'https://openweathermap.org/img/wn/' + data.weather[0].icon + '@2x.png';

        } else if (error) {
            console.error('Error fetching weather data:', error);
        }
    }
}
