package kopo.poly.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import kopo.poly.dto.WeatherDTO;
import kopo.poly.service.IWeatherService;
import kopo.poly.service.impl.WeatherService;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
public class WeatherController {

    @Autowired
    private IWeatherService weatherService;

    @GetMapping("/weather")
    public String RestAPI() {
        log.info(this.getClass().getName() + " API TEST");
        return "test";
    }

    @PostMapping(value = "/weatherStep")
    @ResponseBody
    public List<WeatherDTO> getAreaStep(@RequestParam Map<String, String> params) {

        log.info(String.valueOf(params));
        log.info(this.getClass().getName() + ".getArea start");

        return this.weatherService.getArea(params);

    }

    @PostMapping(value = "/getCoordinate")
    public List<WeatherDTO> getCoordinate(HttpServletRequest request) throws Exception {
        log.info(this.getClass().getName() + ".getCoordinate start");
        WeatherDTO pDTO = new WeatherDTO();
        String areacode = CmmUtil.nvl(request.getParameter("AR"));
        log.info(areacode);
        pDTO.setAreacode(areacode);

        return this.weatherService.getCoordinate(pDTO);
       

    }

}
