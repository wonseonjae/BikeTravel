package kopo.poly.controller;


import kopo.poly.dto.*;
import kopo.poly.service.impl.ClubService;
import kopo.poly.service.impl.S3Service;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;


@Slf4j
@Controller
public class ClubController {

    @Autowired
    private ClubService clubService;

    @Autowired
    private S3Service s3Service;

    @GetMapping(value = "club/MsgToList")
    public String MsgToList() {
        return "/club/MsgToList";
    }

    @GetMapping(value = "club/list")
    public String getClubList(Model model, HttpServletRequest request, ClubCriteria cri) throws Exception {
        int pNo = 1;
        if (request.getParameter("pNo") != null) {
            log.info("열로 들어왔지롱");
            pNo = Integer.parseInt(request.getParameter("pNo"));

            List<ClubListDTO> rList = clubService.getClubList(pNo);
            model.addAttribute("list", rList);
            int total = clubService.totalCount();

            ClubPageMakeDTO pageMake = new ClubPageMakeDTO(cri, total);

            model.addAttribute("pageMaker", pageMake);
            log.info(request.getParameter("pNo"));
            return "/club/list";

        }

        model.addAttribute("list", clubService.getClubList(pNo));
        int total = clubService.totalCount();

        ClubPageMakeDTO pageMake = new ClubPageMakeDTO(cri, total);

        model.addAttribute("pageMaker", pageMake);
        log.info("페이지 번호 없음");
        return "/club/list";
    }

    @GetMapping(value = "club/listByRange")
    public String listByRange(HttpServletRequest request, Model model,ClubCriteria cri) throws Exception{
        String range = request.getParameter("s1");
        log.info(range);
        ClubListDTO pDTO = new ClubListDTO();
        pDTO.setClubrange(range);
        int pNo = 1;
        if (request.getParameter("cNo") != null) {
            pNo = Integer.parseInt(request.getParameter("cNo"));

            List<ClubListDTO> rList = clubService.getClubListByRange(pNo,pDTO);
            model.addAttribute("list", rList);
            int total = clubService.totalCountByRange(pDTO);

            ClubPageMakeDTO pageMake = new ClubPageMakeDTO(cri, total);

            model.addAttribute("pageMaker", pageMake);
            log.info(request.getParameter("cNo"));
            return "/club/list";

        }

        model.addAttribute("list", clubService.getClubListByRange(pNo,pDTO));
        int total = clubService.totalCountByRange(pDTO);

        ClubPageMakeDTO pageMake = new ClubPageMakeDTO(cri, total);

        model.addAttribute("pageMaker", pageMake);
        log.info("페이지 번호 없음");

        return "/club/list";
    }

    @GetMapping(value = "club/newClub")
    public String newClub() {

        return "/club/newClub";
    }

    @ResponseBody
    @RequestMapping(value = "/nameChk", method = RequestMethod.POST)
    public int nameCheck(ClubListDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".nameCheck start!");
        int res = clubService.nameChk(pDTO);
        log.info(String.valueOf(res));
        log.info(this.getClass().getName() + ".nameCheck end!");
        return res;
    }

    @PostMapping(value = "club/clubReg")
    public String clubReg(HttpServletRequest request, Model modl) throws Exception {
        String clubName = CmmUtil.nvl(request.getParameter("club_name"));
        String userName = CmmUtil.nvl(request.getParameter("user_name"));
        log.info(userName);
        String range = CmmUtil.nvl(request.getParameter("s1"));
        String uNo = request.getParameter("user_no");
        log.info(String.valueOf(uNo));
        int user_no = Integer.parseInt(uNo);
        String clubIntro = request.getParameter("clubintro");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phonenumber");
        ClubListDTO pDTO = new ClubListDTO();
        pDTO.setClub_name(clubName);
        pDTO.setPresident_num(user_no);
        pDTO.setClub_president(userName);
        pDTO.setClubrange(range);
        pDTO.setClub_intro(clubIntro);
        pDTO.setPresident_phonenum(phoneNumber);
        int re = clubService.insertClub(pDTO);
        int res =pDTO.getClub_no();
        log.info(String.valueOf(res));
        ClubDTO cDTO = new ClubDTO();
        cDTO.setClub_no(res);
        cDTO.setName(userName);
        cDTO.setPhonenum(phoneNumber);
        cDTO.setAddress(address);
        cDTO.setUser_no(user_no);
        clubService.joinAccept(cDTO);

        modl.addAttribute("msg","동호회 개설이 완료되었습니다");
        return "/club/MsgToList";
    }

    @GetMapping(value = "/club/clubUpdateForm")
    public String clubUpdateForm(HttpServletRequest request, Model model) throws Exception{
        int club_no = Integer.parseInt(request.getParameter("cNo"));
        ClubListDTO pDTO = new ClubListDTO();
        pDTO.setClub_no(club_no);
        ClubListDTO rDTO = clubService.getClubDetail(pDTO);
        model.addAttribute("rDTO", rDTO);

        return "/club/clubUpdateForm";
    }

    @PostMapping(value="/club/updateReg")
    public String updateReg(MultipartHttpServletRequest request, Model model) throws Exception{
        int club_no = Integer.parseInt(request.getParameter("club_no"));
        String range = request.getParameter("s1");
        String intro = request.getParameter("contents");
        if(!Objects.requireNonNull(request.getFile("file")).isEmpty()) {
            MultipartFile file = request.getFile("file");
            String imgPath = s3Service.upload(file);
            String imglink = "https://d1y3hanryj5vy8.cloudfront.net/"+imgPath;
            log.info(imglink);
            ClubListDTO pDTO = new ClubListDTO();
            pDTO.setClub_no(club_no);
            pDTO.setImgLink(imglink);
            pDTO.setClubrange(range);
            pDTO.setClub_intro(intro);
            clubService.updateClub(pDTO);
            String msg = "동호회 내용이 수정되었습니다.";
            model.addAttribute("msg", msg);
        }else{
            ClubListDTO pDTO = new ClubListDTO();
            pDTO.setClub_no(club_no);
            pDTO.setClubrange(range);
            pDTO.setClub_intro(intro);
            clubService.updateClub(pDTO);
            String msg = "동호회 내용이 수정되었습니다.";
            model.addAttribute("msg", msg);
        }

        return "/club/MsgToList";
    }

    @GetMapping(value="/club/joinApply")
    public String joinApply(HttpServletRequest request, Model model) throws Exception{
        String clubNum = request.getParameter("club_no");
        log.info(clubNum);
        model.addAttribute("clubNo", clubNum);
        return "/club/joinApply";
    }

    @PostMapping(value="/club/joinReg")
    public String joinReg(HttpServletRequest request, Model model) throws Exception{
        String user_name = request.getParameter("user_name");
        String address = request.getParameter("address");
        String phoneNum = request.getParameter("phonenumber");
        String clubNum = request.getParameter("club_no");
        String userNum = request.getParameter("user_no");
        String greeting = request.getParameter("greeting");
        int club_no = Integer.parseInt(clubNum);
        int user_no = Integer.parseInt(userNum);
        WaitDTO rDTO = new WaitDTO();
        rDTO.setClub_no(club_no);
        rDTO.setName(user_name);
        rDTO.setPhonenum(phoneNum);
        rDTO.setAddress(address);
        rDTO.setUser_no(user_no);
        rDTO.setGreeting(greeting);
        clubService.joinWaiting(rDTO);
        model.addAttribute("msg","가입신청이 완료되었습니다. 승인될때까지 기다려주세요");
        return "/club/MsgToList";
    }

    @GetMapping(value = "/club/joinAcceptList")
    public String joinAcceptList(HttpServletRequest request, Model model) throws Exception{
        String clubNum = request.getParameter("cNo");
        int club_no = Integer.parseInt(clubNum);
        ClubListDTO pDTO = new ClubListDTO();
        pDTO.setClub_no(club_no);
        List<WaitDTO> rList = clubService.getWaitList(pDTO);
        model.addAttribute("rList", rList);
        return "/club/joinAcceptList";
    }

    @GetMapping(value = "/club/joinAccept")
    public String joinAccept(HttpServletRequest request, Model model) throws Exception{
        String wNo = request.getParameter("wNo");
        int wait_no = Integer.parseInt(wNo);
        String chk = request.getParameter("chk");
        log.info(chk);
        WaitDTO pDTO = new WaitDTO();
        pDTO.setWait_no(wait_no);
        if (Objects.equals(chk, "Y")) {
            WaitDTO wDTO = clubService.getWaitMember(pDTO);
            ClubDTO cDTO = new ClubDTO();
            cDTO.setUser_no(wDTO.getUser_no());
            cDTO.setClub_no(wDTO.getClub_no());
            cDTO.setName(wDTO.getName());
            cDTO.setAddress(wDTO.getAddress());
            cDTO.setPhonenum(wDTO.getPhonenum());
            clubService.joinAccept(cDTO);
            clubService.deleteJoin(pDTO);
            model.addAttribute("msg","승인완료");
        }else{
            clubService.deleteJoin(pDTO);
            model.addAttribute("msg", "거절 완료");
        }
        return "/club/MsgToClose";


    }

    @GetMapping(value = "/club/clubInfo")
    public String clubInfo(HttpServletRequest request, Model model, HttpSession session) throws Exception{
        int cNo = Integer.parseInt(request.getParameter("cNo"));
        log.info(String.valueOf(cNo));
        ClubListDTO pDTO = new ClubListDTO();
        pDTO.setClub_no(cNo);
        ClubListDTO rDTO = clubService.getClubDetail(pDTO);
        List<ClubDTO> rList = clubService.getClubMemberNum(pDTO);
        model.addAttribute("rDTO", rDTO);
        model.addAttribute("rList",rList);
        return "/club/clubInfo";
    }

    @ResponseBody
    @GetMapping(value = "/club/getClubCalendar")
    public List<Map<String, Object>> clubCalendar(CalendarDTO pDTO) throws Exception{
        log.info(String.valueOf(pDTO.getClub_no()));
        List<CalendarDTO> rList = clubService.getCalendarList(pDTO);
        JSONObject jsonObj = new JSONObject();
        JSONArray jsonArr = new JSONArray();

        HashMap<String, Object> hash = new HashMap<>();

        for (int i = 0; i < rList.size(); i++) {
            hash.put("title", rList.get(i).getTitle());
            hash.put("start", rList.get(i).getStartdate());
            hash.put("end",rList.get(i).getEnddate());
            hash.put("time",  rList.get(i).getEnddate());
            hash.put("cal_no", rList.get(i).getCal_no());
            jsonObj = new JSONObject(hash);
            jsonArr.add(jsonObj);
        }
        log.info("jsonArrCheck: {}", jsonArr);
        return jsonArr;

    }

    @ResponseBody
    @PostMapping(value = "/club/insertCalendar")
    public String insertCalendar(@RequestBody List<Map<String, Object>> param) throws Exception {
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.KOREA);

        for (Map<String, Object> list : param) {
            String eventName = (String) list.get("title"); // 이름 받아오기
            String startDateString = (String) list.get("start");
            log.info(startDateString);
            String endDateString = (String) list.get("end");
            log.info(endDateString);
            LocalDateTime startDate = LocalDateTime.parse(startDateString, dateTimeFormatter);
            LocalDateTime endDate = LocalDateTime.parse(endDateString, dateTimeFormatter);
            int club_no = (Integer) list.get("club_no");
            //시작시간, 종료시간을 한국 시간으로 변환
            System.out.println("=================================");
            System.out.println("startDate = " + String.valueOf(startDate));
            System.out.println("eventName = " + eventName);
            CalendarDTO pDTO = new CalendarDTO();
            pDTO.setTitle(eventName);
            pDTO.setStartdate(String.valueOf(startDate));
            pDTO.setEnddate(String.valueOf(endDate));
            pDTO.setClub_no(club_no);
            clubService.insertCalendar(pDTO);

        }
        return "/club/getClubCalendar";
    }

    @ResponseBody
    @DeleteMapping(value = "/club/deleteCalendar")
    public String deleteCalendar(@RequestBody List<Map<String, Object>> param) throws Exception{

        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.KOREA);

        for (Map<String, Object> list : param) {

            String title = (String) list.get("title"); // 이름 받아오기
            String startDateString = (String) list.get("start");
            String endDateString = (String) list.get("end");
            int club_no = (Integer) list.get("club_no");
            System.out.println("startDateString = " + startDateString);
            LocalDateTime startDate = LocalDateTime.parse(startDateString, dateTimeFormatter);
            LocalDateTime endDate = LocalDateTime.parse(endDateString, dateTimeFormatter);

            System.out.println("startDate = " + startDate);

            CalendarDTO pDTO = new CalendarDTO();
            pDTO.setClub_no(club_no);
            pDTO.setStartdate(String.valueOf(startDate));
            pDTO.setEnddate(String.valueOf(endDate));
            pDTO.setTitle(title);
            clubService.deleteCalendar(pDTO);

        }

        return "/club/getClubCalendar";
    }

}
