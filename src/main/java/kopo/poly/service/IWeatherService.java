package kopo.poly.service;

import kopo.poly.dto.BikeRentalDTO;
import kopo.poly.dto.WeatherDTO;

import java.util.List;
import java.util.Map;

public interface IWeatherService {

    String apiURL = "https://api.openweathermap.org/data/3.0/onecall";
    WeatherDTO getWeather(WeatherDTO pDTO) throws Exception;

    List<BikeRentalDTO> getBikeRental() throws Exception;


}
