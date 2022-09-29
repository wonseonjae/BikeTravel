package kopo.poly.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WeatherDailyDTO {
    private String day;
    private String sunrise;
    private String sunset;
    private String dayTemp;
    private String dayTempMax;
    private String dayTempMin;
    private String uvi;
    private String humidity;
    private String clouds;
    private String pop;
    private String wind;
    private String icon;
    private String description;
}
