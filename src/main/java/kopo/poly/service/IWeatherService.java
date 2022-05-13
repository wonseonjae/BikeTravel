package kopo.poly.service;

import kopo.poly.dto.WeatherDTO;

import java.util.List;
import java.util.Map;

public interface IWeatherService {
    List<WeatherDTO> getArea(Map<String, String> params);

    WeatherDTO getCoordinate(WeatherDTO pDTO);
}
