package kopo.poly.mapper;

import kopo.poly.dto.WeatherDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface IWeatherMapper {
    List<WeatherDTO> selectArea(Map<String, String> params);

    WeatherDTO selectCoordinate(WeatherDTO pDTO);

    WeatherDTO getArea(WeatherDTO pDTO);
}
