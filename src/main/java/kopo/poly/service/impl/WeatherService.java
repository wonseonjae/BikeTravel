package kopo.poly.service.impl;

import kopo.poly.dto.WeatherDTO;
import kopo.poly.mapper.IWeatherMapper;
import kopo.poly.service.IWeatherService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class WeatherService implements IWeatherService {

        @Autowired
        private IWeatherMapper weatherMapper;

        @Override
        public List<WeatherDTO> getArea(Map<String, String> params)
        {
            log.info(this.getClass().getName() + ".getArea start");

            return this.weatherMapper.selectArea(params);
        }

    @Override
    public List<WeatherDTO> getCoordinate(WeatherDTO pDTO)
    {
        log.info(this.getClass().getName() + ".getCoordinate start");

        return this.weatherMapper.selectCoordinate(pDTO);
    }
}
