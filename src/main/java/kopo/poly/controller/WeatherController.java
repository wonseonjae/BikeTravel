package kopo.poly.controller;

import kopo.poly.dto.WaitDTO;
import kopo.poly.dto.WeatherDTO;
import kopo.poly.service.IWeatherService;
import kopo.poly.util.ApiParse;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.IOException;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping(value = "weather")
public class WeatherController {

    @Resource(name = "WeatherService")
    private IWeatherService weatherService;

    @GetMapping(value = "getWeather")
    public WeatherDTO getWeather(HttpServletRequest request)throws Exception{
        String lat = CmmUtil.nvl(request.getParameter("lat"));
        String lon = CmmUtil.nvl(request.getParameter("lon"));

        WeatherDTO pDTO = new WeatherDTO();

        pDTO.setLat(lat);
        pDTO.setLon(lon);

        WeatherDTO rDTO = weatherService.getWeather(pDTO);

        if (rDTO == null){
            rDTO = new WeatherDTO();
        }

        return rDTO;
    }



}
