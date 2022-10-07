package kopo.poly.controller;

import kopo.poly.dto.*;
import kopo.poly.service.IBIkeService;
import kopo.poly.util.CmmUtil;
import kopo.poly.util.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Slf4j
@Controller
public class BikeController {

    @Autowired
    private IBIkeService bikeService;

    @ResponseBody
    @GetMapping("/bike/regCertificate")
    public int regCertificate(HttpServletRequest request, HttpSession session) throws Exception{

        int res = 0;

        String checkPoint = CmmUtil.nvl(request.getParameter("checkPoint"));
        log.info(checkPoint);
        BikeCertificateDTO pDTO = new BikeCertificateDTO();
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        log.info(String.valueOf(uDTO.getUser_no()));
        pDTO.setCertificate(checkPoint);
        pDTO.setUser_no(uDTO.getUser_no());
        pDTO.setReg_dt(DateUtil.getDateTime("yyyy-MM-dd hh:mm"));

        bikeService.insertCertificate(pDTO);

        return res;
    }

    @GetMapping("/bike/getCertificate")
    public List<BikeCertificateDTO> getCertificate(HttpServletRequest request, Model model) throws Exception{

        BikeCertificateDTO pDTO = new BikeCertificateDTO();

        List<BikeCertificateDTO> rList = bikeService.selectCertificate(pDTO);

        return rList;
    }

    @ResponseBody
    @GetMapping("/bike/insertReview")
    public void insertReview(HttpServletRequest request, HttpSession session) throws Exception{
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        String text = request.getParameter("text");
        long starpoint = Long.parseLong(request.getParameter("starpoint"));
        String course_name = request.getParameter("course_name");

        CourseReviewDTO pDTO = new CourseReviewDTO();
        pDTO.setUser_no(uDTO.getUser_no());
        pDTO.setCourse_name(course_name);
        pDTO.setText(text);
        pDTO.setStarpoint(starpoint);
        pDTO.setReg_dt(DateUtil.getDateTime("yyyy-MM-dd hh:mm:ss"));
        bikeService.insertReview(pDTO);
    }

    @ResponseBody
    @GetMapping("/bike/updateReview")
    public void updateReview(HttpServletRequest request, HttpSession session) throws Exception{
        int distance_no = Integer.parseInt(request.getParameter("distance_no"));
        String text = request.getParameter("content");
        long starpoint = Long.parseLong(request.getParameter("starPoint"));
        CourseReviewDTO pDTO = new CourseReviewDTO();
        pDTO.setDistance_no(distance_no);
        pDTO.setText(text);
        pDTO.setStarpoint(starpoint);
        pDTO.setReg_dt(DateUtil.getDateTime("yyyy-MM-dd hh:mm:ss"));
        bikeService.updateReview(pDTO);
    }

    @ResponseBody
    @GetMapping("/bike/deleteReview")
    public void deleteReview(HttpServletRequest request, HttpSession session) throws Exception{

        int distance_no = Integer.parseInt(request.getParameter("distance_no"));
        CourseReviewDTO pDTO = new CourseReviewDTO();
        pDTO.setDistance_no(distance_no);
        bikeService.deleteReview(pDTO);
    }

    @ResponseBody
    @GetMapping("/bike/regDistance")
    public void regDistance(HttpServletRequest request, HttpSession session) throws Exception{
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.KOREA);

        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        String startdate = request.getParameter("startDate")+"Z";
        log.info(startdate);
        String enddate = request.getParameter("endDate")+"Z";
        log.info(enddate);
        int distance = Integer.parseInt(request.getParameter("distance"));
        LocalDateTime startDate = LocalDateTime.parse(startdate, dateTimeFormatter);
        LocalDateTime endDate = LocalDateTime.parse(enddate, dateTimeFormatter);
        BikeDistanceDTO pDTO = new BikeDistanceDTO();
        pDTO.setEnddate(String.valueOf(endDate));
        pDTO.setStartdate(String.valueOf(startDate));
        pDTO.setDistance(distance);
        pDTO.setUser_no(uDTO.getUser_no());
        bikeService.insertDistance(pDTO);
    }

    @ResponseBody
    @GetMapping("/bike/selectDistance")
    public List<Map<String, Object>> selectDistance(HttpSession session) throws Exception{
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        BikeDistanceDTO pDTO = new BikeDistanceDTO();
        pDTO.setUser_no(uDTO.getUser_no());
        List<BikeDistanceDTO> rList = bikeService.selectDistance(pDTO);
        JSONObject jsonObj = new JSONObject();
        JSONArray jsonArr = new JSONArray();
        HashMap<String, Object> hash = new HashMap<>();


        for (BikeDistanceDTO bikeDistanceDTO : rList) {
                hash.put("title", bikeDistanceDTO.getDistance()+"m");
                hash.put("start", bikeDistanceDTO.getStartdate());
                hash.put("end", bikeDistanceDTO.getEnddate());
                hash.put("time", bikeDistanceDTO.getStartdate()+" ~ "+bikeDistanceDTO.getEnddate());
                hash.put("cal_no", bikeDistanceDTO.getReg_no());
                jsonObj = new JSONObject(hash);
                jsonArr.add(jsonObj);
        }
            return jsonArr;
    }

    @GetMapping("/bike/getDistanceForm")
    public String getDistanceForm(){

        return "/course/getDistanceForm";
    }

}
