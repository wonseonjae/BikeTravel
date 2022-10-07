package kopo.poly.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import kopo.poly.dto.BikeRentalDTO;
import kopo.poly.dto.WeatherDTO;
import kopo.poly.dto.WeatherDailyDTO;
import kopo.poly.service.IWeatherService;
import kopo.poly.util.CmmUtil;
import kopo.poly.util.DateUtil;
import kopo.poly.util.NetworkUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.URLEncoder;
import java.util.*;

@Slf4j
@Service("WeatherService")
public class WeatherService implements IWeatherService {
    @Value("${weather.api.key}")
    private String apiKey;


    @Override
    public WeatherDTO getWeather(WeatherDTO pDTO) throws Exception {

        String lat = CmmUtil.nvl(pDTO.getLat());
        String lon = CmmUtil.nvl(pDTO.getLon());

        String apiParam = "?lat=" + lat + "&lon=" + lon + "&appid=" + apiKey + "&units=metric" + "&lang=kr";

        String json = NetworkUtil.get(IWeatherService.apiURL + apiParam);

        Map<String, Object> rMap = new ObjectMapper().readValue(json, LinkedHashMap.class);

        Map<String, Double> current = (Map<String, Double>) rMap.get("current");


        double currentTemp = current.get("temp");

        List<Map<String, Object>> dailyList = (List<Map<String, Object>>) rMap.get("daily");



        List<WeatherDailyDTO> pList = new LinkedList<>();
        for (Map<String, Object> dailyMap : dailyList) {
            String day = DateUtil.getLongDateTime(dailyMap.get("dt"), "yyyy-MM-dd");

            WeatherDailyDTO wdDTO = new WeatherDailyDTO();
            String uvi = String.valueOf(dailyMap.get("uvi"));
            String humidity = String.valueOf(dailyMap.get("humidity"));
            String pop = String.valueOf(dailyMap.get("pop"));
            String wind = String.valueOf(dailyMap.get("wind_speed"));
            List<Map<String, Object>> weather = (List<Map<String, Object>>) dailyMap.get("weather");
            for (Map<String, Object> weatherMap : weather){
                String icon = String.valueOf(weatherMap.get("icon"));
                String description = String.valueOf(weatherMap.get("description"));

                log.info(description);
                wdDTO.setIcon(icon);
                wdDTO.setDescription(description);
            }
            wdDTO.setWind(wind);
            wdDTO.setUvi(uvi);
            wdDTO.setHumidity(humidity);
            wdDTO.setPop(pop);

            String sunrise = DateUtil.getLongDateTime(dailyMap.get("sunrise")).substring(11, 16);
            String sunset = DateUtil.getLongDateTime(dailyMap.get("sunset")).substring(11, 16);

            Map<String, Double> dailyTemp = (Map<String, Double>) dailyMap.get("temp");
            String dayTemp = String.valueOf(dailyTemp.get("day"));
            String dayTempMax = String.valueOf(dailyTemp.get("max")).substring(0,2);
            String dayTempMin = String.valueOf(dailyTemp.get("min")).substring(0,2);
            wdDTO.setDay(day);
            wdDTO.setSunrise(sunrise);
            wdDTO.setSunset(sunset);
            wdDTO.setDayTemp(dayTemp);
            wdDTO.setDayTempMax(dayTempMax);
            wdDTO.setDayTempMin(dayTempMin);
            pList.add(wdDTO);
            wdDTO = null;
        }

            WeatherDTO rDTO = new WeatherDTO();
            rDTO.setLat(lat);
            rDTO.setLon(lon);
            rDTO.setDailyList(pList);
            rDTO.setCurrentTemp(currentTemp);

        return rDTO;
    }

    @Override
    public List<BikeRentalDTO> getBikeRental() throws Exception {

        String apiParam = "http://api.data.go.kr/openapi/tn_pubr_public_bcycl_lend_api" + "?" + URLEncoder.encode("serviceKey", "UTF-8") + "=7EpF3TCkgMENfaz3eaLHbldfYrPuDMZRi2IEbYu1fGqnoUxT5ZB6xm28C3Xv6TB2IegtMlKzIlLLNExhFq1FsQ%3D%3D" + /*Service Key*/
                "&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8") + /*페이지 번호*/
                "&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("500", "UTF-8") + /*한 페이지 결과 수*/
                "&" + URLEncoder.encode("type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"); /*XML/JSON 여부*/

        String json = NetworkUtil.get(apiParam);



        Map<String, Object> rMap = new ObjectMapper().readValue(json, LinkedHashMap.class);


        Map<String, Object> response = (Map<String, Object>) rMap.get("response");

        Map<String, Object> body = (Map<String, Object>) response.get("body");



        List<Map<String, Object>> dailyList = (List<Map<String, Object>>) body.get("items");

        List<BikeRentalDTO> pList = new LinkedList<>();
        for (Map<String, Object> hash : dailyList) {
            String bcyclLendNm = String.valueOf(hash.get("bcyclLendNm"));
            String bcyclLendSe = String.valueOf(hash.get("bcyclLendSe"));
            String lnmadr = String.valueOf(hash.get("lnmadr"));
            String rdnmadr = String.valueOf(hash.get("rdnmadr"));
            String latitude = String.valueOf(hash.get("latitude"));
            String longitude = String.valueOf(hash.get("longitude"));
            String operOpenHm = String.valueOf(hash.get("operOpenHm"));
            String operCloseHm = String.valueOf(hash.get("operCloseHm"));
            String rstde = String.valueOf(hash.get("rstde"));
            String bcyclUseCharge = String.valueOf(hash.get("bcyclUseCharge"));
            String phoneNumber = String.valueOf(hash.get("phoneNumber"));

            BikeRentalDTO rDTO = new BikeRentalDTO();
            rDTO.setBcyclLendNm(bcyclLendNm);
            rDTO.setBcyclLendSe(bcyclLendSe);
            rDTO.setLnmadr(lnmadr);
            rDTO.setLatitude(latitude);
            rDTO.setLongitude(longitude);
            rDTO.setOperOpenHm(operOpenHm);
            rDTO.setOperCloseHm(operCloseHm);
            rDTO.setRstde(rstde);
            rDTO.setBcyclUseCharge(bcyclUseCharge);
            rDTO.setPhoneNumber(phoneNumber);
            pList.add(rDTO);
            rDTO = null;
        }

        return pList;
    }

}
