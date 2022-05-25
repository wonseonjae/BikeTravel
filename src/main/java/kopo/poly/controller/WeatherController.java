package kopo.poly.controller;

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
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
public class WeatherController {

    @Autowired
    private IWeatherService weatherService;

    @GetMapping("/weather/Form")
    public String RestAPI() {
        log.info(this.getClass().getName() + " API TEST");
        return "/weather/weatherForm";
    }



    @PostMapping(value = "/weatherStep")
    @ResponseBody
    public List<WeatherDTO> getAreaStep(@RequestParam Map<String, String> params) {

        log.info(String.valueOf(params));
        log.info(this.getClass().getName() + ".getArea start");

        return weatherService.getArea(params);

    }

    @PostMapping(value = "/getCoordinate")
    @ResponseBody
    public HashMap<String, String> getCoordinate(HttpServletRequest request) throws Exception {
        log.info(this.getClass().getName() + ".getCoordinate start");
        WeatherDTO pDTO = new WeatherDTO();
        String areacode = CmmUtil.nvl(request.getParameter("AR"));
        log.info(areacode);
        pDTO.setAreacode(areacode);

        WeatherDTO rDTO = weatherService.getCoordinate(pDTO);
        HashMap<String, String> rMap =  new HashMap<>();
        rMap.put("gridX", rDTO.getGridx());
        rMap.put("gridY", rDTO.getGridy());
        return rMap;

    }

    @GetMapping(value = "/weatherReg")
    public String weeatherReg(HttpServletRequest request, Model model) throws IOException, ParseException {
        String areaCode = CmmUtil.nvl(request.getParameter("sido"));
        WeatherDTO pDTO = new WeatherDTO();
        pDTO.setAreacode(areaCode);
        WeatherDTO rDTO = weatherService.getArea(pDTO);
        String day = CmmUtil.nvl(request.getParameter("datePick"));
        String time = CmmUtil.nvl(request.getParameter("time"));
        String gridX = CmmUtil.nvl(request.getParameter("gridX"));
        String gridY = CmmUtil.nvl(request.getParameter("gridY"));
        StringBuilder res =  ApiParse.main(day, time, gridX, gridY);
        String data = res.toString();
        JSONParser parser = new JSONParser();
        JSONObject obj = (JSONObject) parser.parse(data);
        JSONObject obj1 = (JSONObject) obj.get("response");
        JSONObject obj2 = (JSONObject) obj1.get("body");
        JSONObject obj3 = (JSONObject) obj2.get("items");
        JSONArray obj4 = (JSONArray) obj3.get("item");
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < obj4.size(); i++) {
            JSONObject obj5 = (JSONObject) obj4.get(i);
            String content = (String) obj5.get("obsrValue");
            sb.append(content+",");
        }
        String[] result = sb.toString().split(",");
        String pty = result[0];
        String reh = result[1];
        String rn = result[2];
        String tH = result[3];
        String uuu = result[4];
        String vec = result[5];
        String vvv = result[6];
        String wsd = result[7];

        String sido = rDTO.getStep1();
        String gungu = rDTO.getStep2();
        String dong = rDTO.getStep3();
        model.addAttribute("time",time);
        model.addAttribute("sido", sido);
        model.addAttribute("gungu", gungu);
        model.addAttribute("dong", dong);
        model.addAttribute("pty", pty);
        model.addAttribute("reh", reh);
        model.addAttribute("t1h", tH);
        model.addAttribute("vec", vec);
        model.addAttribute("wsd", wsd);

        return "/weather/result";
    }

}
