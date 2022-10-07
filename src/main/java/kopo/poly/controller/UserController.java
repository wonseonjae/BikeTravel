package kopo.poly.controller;

import kopo.poly.dto.*;
import kopo.poly.service.IBIkeService;
import kopo.poly.service.IWeatherService;
import kopo.poly.service.impl.AdminService;
import kopo.poly.service.impl.CourseService;
import kopo.poly.service.impl.UserService;
import kopo.poly.service.impl.WeatherService;
import kopo.poly.util.CmmUtil;
import kopo.poly.util.UseSha256;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
public class UserController {

    @Autowired
    private CourseService courseService;

    @Resource(name = "WeatherService")
    private IWeatherService weatherService;

    @Autowired
    UserService userService;
    @Autowired
    AdminService adminService;

    @Autowired
    IBIkeService bikeService;

    //메인화면
    @GetMapping("/main")
    public String MainPage(HttpServletRequest request, Model model, Criteria nCri) throws Exception {
        int tNo = 1;
        if (request.getParameter("tNo") != null) {
            log.info("열로 들어왔지롱");
            tNo = Integer.parseInt(request.getParameter("tNo"));
            List<NoticeDTO> nList = adminService.getNoticePaging(tNo);
            model.addAttribute("rList", nList);
            int result = adminService.userTotalCount(nCri);
            PageMakeDTO noticePageMake = new PageMakeDTO(nCri, result);
            model.addAttribute("noticePageMake", noticePageMake);
        }
        model.addAttribute("rList", adminService.getNoticePaging(tNo));
        int result = adminService.noticeTotalCount(nCri);
        List<BikeRentalDTO> rList = weatherService.getBikeRental();
        PageMakeDTO noticePageMake = new PageMakeDTO(nCri, result);
        model.addAttribute("noticePageMake", noticePageMake);
        return "/main";
    }

    //회원가입
    @GetMapping("/signUp")
    public String signUpForm() {
        log.info(this.getClass().getName() + ".SignUpForm start");
        return "signUp/signUp";
    }

    @GetMapping("/myPage")
    public String Mypage(HttpSession session, Model model) throws Exception {
        log.info(this.getClass().getName() + ".SignUpForm start");
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        BikeDistanceDTO dDTO = new BikeDistanceDTO();
        dDTO.setUser_no(uDTO.getUser_no());
        BikeCertificateDTO cDTO = new BikeCertificateDTO();
        cDTO.setUser_no(uDTO.getUser_no());
        List<BikeCertificateDTO> cList = bikeService.selectCertificate(cDTO);
        List<CertificationDTO> rList = courseService.getCertification();
        List<BikeDistanceDTO> dList = bikeService.selectDistance(dDTO);

        model.addAttribute("cList", cList);
        model.addAttribute("rList", rList);
        return "/signUp/myPage";
    }


    @PostMapping("/signUpReg")
    public String signUp(HttpServletRequest request, Model model) {

        log.info(this.getClass().getName() + ".SingUpReg start");

        String msg = "";

        try {

            String userId = CmmUtil.nvl(request.getParameter("user_id"));
            String userPwd = CmmUtil.nvl(request.getParameter("user_pw"));
            String userName = CmmUtil.nvl(request.getParameter("user_name"));
            String userMailid = CmmUtil.nvl(request.getParameter("user_mailid"));
            String userMaildomain = CmmUtil.nvl(request.getParameter("user_maildomain"));
            String certificationYN = CmmUtil.nvl(request.getParameter("certificationYN"));

            String userPw = UseSha256.encrypt(userPwd);

            log.info("userId : " + userId);
            log.info("userPw : " + userPw);
            log.info("userName : " + userName);
            log.info(userMailid + "@" + userMaildomain);
            log.info(certificationYN);

            UserDTO pDTO = new UserDTO();

            pDTO.setUser_id(userId);
            pDTO.setUser_pw(userPw);
            pDTO.setUser_name(userName);
            pDTO.setUser_mailid(userMailid);
            pDTO.setUser_maildomain(userMaildomain);

            userService.InsertUserInfo(pDTO);


            // 저장이 완료되면 사용자에게 보여줄 메시지
            msg = "등록되었습니다.";


        } catch (Exception e) {

            // 저장이 실패되면 사용자에게 보여줄 메시지
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".signUpReg end!");


        }
        model.addAttribute("msg","회원가입이 완료되었습니다.");
        return "/signUp/popupclose";
    }
    //아이디 중복체크
    @ResponseBody
    @PostMapping(value = "/idCheck")
    public int idCheck(HttpServletRequest request) throws Exception {
        log.info(this.getClass().getName() + ".idCheck start!");
        String msg = "";


            String userId = CmmUtil.nvl(request.getParameter("user_id"));

            log.info("userId : " + userId);

            UserDTO pDTO = new UserDTO();

            pDTO.setUser_id(userId);

           int result = userService.idCheck(pDTO);

        return result;
    }

    //닉네임 중복체크
    @ResponseBody
    @RequestMapping(value = "/nameCheck", method = RequestMethod.POST)
    public int nameCheck(UserDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".nameCheck start!");
        int res = userService.nameCheck(pDTO);
        log.info(String.valueOf(res));
        log.info(this.getClass().getName() + ".nameCheck end!");
        return res;
    }

    //메일 중복체크
    @ResponseBody
    @RequestMapping(value = "/mailCheck", method = RequestMethod.POST)
    public int mailCheck(UserDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".mailCheck start!");
        int res = userService.mailCheck(pDTO);
        log.info(this.getClass().getName() + ".mailCheck end!");
        return res;
    }

}
