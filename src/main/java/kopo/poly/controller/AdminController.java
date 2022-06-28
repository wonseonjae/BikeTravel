package kopo.poly.controller;

import kopo.poly.dto.*;
import kopo.poly.service.IAdminService;
import kopo.poly.service.ILoginService;
import kopo.poly.service.IUserService;
import kopo.poly.service.impl.BoardService;
import kopo.poly.service.impl.ClubService;
import kopo.poly.service.impl.S3Service;
import kopo.poly.util.CmmUtil;
import kopo.poly.util.UseSha256;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Slf4j
@Controller
public class AdminController {
    @Autowired
    private IAdminService adminService;

    @Autowired
    private BoardService boardService;

    @Autowired
    private ClubService clubService;

    @GetMapping(value = "/admin")
    public String admin(HttpServletRequest request,Model model,Criteria nCri, Criteria uCri, ClubCriteria cri) throws Exception {
        int cNo = 1;
        int uNo = 1;
        int tNo = 1;
        if (request.getParameter("cNo") != null) {
            log.info("열로 들어왔지롱");
            cNo = Integer.parseInt(request.getParameter("cNo"));
            List<ClubListDTO> rList = clubService.getClubList(cNo);
            model.addAttribute("cList", rList);
            int total = clubService.totalCount();
            ClubPageMakeDTO pageMake = new ClubPageMakeDTO(cri, total);
            model.addAttribute("ClubPageMaker", pageMake);
        }
        model.addAttribute("cList", clubService.getClubList(cNo));
        int total = clubService.totalCount();
        ClubPageMakeDTO pageMake = new ClubPageMakeDTO(cri, total);
        model.addAttribute("ClubPageMaker", pageMake);
        if (request.getParameter("uNo") != null) {
            log.info("열로 들어왔지롱");
            uNo = Integer.parseInt(request.getParameter("uNo"));
            List<UserDTO> uList = adminService.getUserPaging(uNo);
            model.addAttribute("uList", uList);
            int res = adminService.userTotalCount(uCri);
            PageMakeDTO userPageMake = new PageMakeDTO(uCri, res);
            model.addAttribute("userPageMake", userPageMake);
        }
        model.addAttribute("uList", adminService.getUserPaging(uNo));
        int res = adminService.userTotalCount(uCri);
        PageMakeDTO userPageMake = new PageMakeDTO(uCri, res);
        model.addAttribute("userPageMake", userPageMake);

        if (request.getParameter("tNo") != null) {
            log.info("열로 들어왔지롱");
            tNo = Integer.parseInt(request.getParameter("tNo"));
            List<NoticeDTO> nList = adminService.getNoticePaging(tNo);
            model.addAttribute("nList", nList);
            int result = adminService.userTotalCount(nCri);
            PageMakeDTO noticePageMake = new PageMakeDTO(nCri, result);
            model.addAttribute("noticePageMake", noticePageMake);
        }
        model.addAttribute("nList", adminService.getNoticePaging(tNo));
        int result = adminService.noticeTotalCount(nCri);
        PageMakeDTO noticePageMake = new PageMakeDTO(nCri, result);
        model.addAttribute("noticePageMake", noticePageMake);

        return "/admin/adminPage";
    }
    @GetMapping(value = "/noticeDetail")
    public String noticeDetail(HttpServletRequest request,Model model){
        int bNo = Integer.parseInt(request.getParameter("bNo"));
        NoticeDTO pDTO = new NoticeDTO();
        pDTO.setNotice_no(bNo);
        NoticeDTO rDTO = adminService.noticeDetail(pDTO);
        model.addAttribute("rDTO", rDTO);
        return "/noticeDetail";
    }

    @GetMapping(value = "/noticeDelete")
    public String noticeDelete(HttpServletRequest request, Model model){
        int notice_no = Integer.parseInt(request.getParameter("nSeq"));
        NoticeDTO pDTO = new NoticeDTO();
        pDTO.setNotice_no(notice_no);
        adminService.deleteNotice(pDTO);
        model.addAttribute("msg","공지가 삭제되었습니다.");
        return "/club/MsgToClose";
    }

    @GetMapping(value = "/admin/noticeInsertForm")
    public String noticeInsertForm(){
        return "/admin/noticeWrite";
    }

    @PostMapping(value="/noticeReg")
    public String noticeReg(HttpServletRequest request, Model model){
        String title = request.getParameter("title");
        String contents = request.getParameter("contents");
        String adminName = request.getParameter("adminName");
        NoticeDTO pDTO = new NoticeDTO();
        pDTO.setAdminname(adminName);
        pDTO.setContents(contents);
        pDTO.setTitle(title);
        adminService.insertNotice(pDTO);
        model.addAttribute("msg","공지작성이 완료되었습니다.");
        return "/admin/MsgToAdmin";
    }

    @GetMapping(value = "/userDetail")
    public String userInfo(HttpServletRequest request, Model model,Criteria cri) throws Exception {
        log.info(this.getClass().getName()+".userInfo start!");
        int user_no = Integer.parseInt(request.getParameter("bNo"));
        UserDTO pDTO = new UserDTO();
        pDTO.setUser_no(user_no);
        UserDTO rDTO = adminService.getUserInfo(pDTO);
        List<BoardDTO> rList = adminService.getUserBoard(pDTO);
        model.addAttribute("rDTO",rDTO);
        model.addAttribute("rList", rList);

        return "admin/userInfo";
    }

    @GetMapping(value = "/admin/clubDetail")
    public String clubInfo(HttpServletRequest request, Model model) throws Exception{
        int cNo = Integer.parseInt(request.getParameter("cNo"));
        log.info(String.valueOf(cNo));
        ClubListDTO pDTO = new ClubListDTO();
        pDTO.setClub_no(cNo);
        ClubListDTO rDTO = clubService.getClubDetail(pDTO);
        List<ClubDTO> rList = clubService.getClubMemberNum(pDTO);
        model.addAttribute("rDTO", rDTO);
        model.addAttribute("rList",rList);
        return "/admin/clubDetail";
    }

    @GetMapping(value="/admin/clubDelete")
    public String clubDetail(HttpServletRequest request, Model model) throws Exception {
        int cNo = Integer.parseInt(request.getParameter("cNo"));
        ClubListDTO pDTO = new ClubListDTO();
        pDTO.setClub_no(cNo);
        clubService.deleteClub(pDTO);
        model.addAttribute("msg","동호회가 삭제되었습니다.");
        return "/admin/MsgToAdmin";
    }

    @GetMapping(value = "/adminDeleteUser")
    public String deleteUser(HttpSession session, HttpServletRequest request, Model model) throws Exception {
        log.info(this.getClass().getName()+".adminDeleteUser start!");
        int user_no = Integer.parseInt(CmmUtil.nvl(request.getParameter("bNo")));
        UserDTO pDTO = new UserDTO();
        pDTO.setUser_no(user_no);

        adminService.deleteUser(pDTO);

        model.addAttribute("msg", "회원삭제가 완료되었습니다");
        log.info(this.getClass().getName()+".adminDeleteUser end!");

        return "/admin/MsgToAdmin";
    }

    @GetMapping(value = "/userBoardDetail")
    public String userBoardDetail(HttpServletRequest request, Model model) throws Exception {
        log.info(request.getParameter("bNo"));
        int user_no = Integer.valueOf(CmmUtil.nvl(request.getParameter("bNo")));
        BoardDTO pDTO = new BoardDTO();
        pDTO.setBoard_no(user_no);
        BoardDTO rDTO = adminService.userBoardDetail(pDTO);
        CommentDTO cDTO = new CommentDTO();
        cDTO.setBoard_no(user_no);
        List<CommentDTO> rList = boardService.getComment(cDTO);

        model.addAttribute("rDTO", rDTO);
        model.addAttribute("rList",rList);

        return "/admin/userBoardDetail";
    }

    @GetMapping(value = "/userBoardDelete")
    public String userBoardDelete(HttpServletRequest request, Model model)throws Exception{
        log.info(CmmUtil.nvl(request.getParameter("bNo")));
        int board_no = Integer.valueOf(CmmUtil.nvl(request.getParameter("bNo")));
        BoardDTO pDTO = new BoardDTO();
        pDTO.setBoard_no(board_no);
        adminService.boardDelete(pDTO);

        model.addAttribute("msg","글이 삭제되었습니다.");

        return "/admin/MsgToAdmin";
    }

    @PostMapping(value= "/admin/pwCheck")
    public String pwCheck(HttpServletRequest request, Model model) {
        String user_pw = UseSha256.encrypt(request.getParameter("user_pw"));
        log.info(user_pw);
        int user_no = Integer.parseInt(request.getParameter("user_no"));
        log.info(String.valueOf(user_no));
        UserDTO pDTO = new UserDTO();
        pDTO.setUser_pw(user_pw);
        pDTO.setUser_no(user_no);
        int result = adminService.pwCheck(pDTO);

        if (result == 1) {
            return "/signUp/chgPW";
        }else {
            String msg = "비밀번호가 틀렸습니다";
            model.addAttribute("msg", msg);
            return "/signUp/MsgToMain";
        }

    }

    @GetMapping(value = "/admin/chgName")
    public String chgNameForm() {
        return "/signUp/chgName";
    }

    @PostMapping(value = "/admin/chgName")
    public String chgName(HttpServletRequest request, Model model, HttpSession session) throws Exception {
        String user_name = request.getParameter("user_name");
        int user_no = Integer.valueOf(request.getParameter("user_no"));
        UserDTO pDTO = new UserDTO();
        pDTO.setUser_name(user_name);
        pDTO.setUser_no(user_no);
        adminService.chgName(pDTO);
        session.invalidate();
        model.addAttribute("msg","닉네임이 변경되었습니다. 다시 로그인 해주시기 바랍니다.");

        return "/signUp/popupclose";

    }

    @PostMapping(value = "/admin/chgPw")
    public String chgPw(HttpServletRequest request, Model model, HttpSession session) throws Exception {
        String pw = UseSha256.encrypt(request.getParameter("pw"));
        int user_no = Integer.parseInt(request.getParameter("user_no"));
        UserDTO pDTO = new UserDTO();
        pDTO.setUser_pw(pw);
        pDTO.setUser_no(user_no);
        int res =  adminService.chgPw(pDTO);
        session.invalidate();
        String msg = "비밀번호가 변경되었습니다. 다시 로그인 해주세요";
        model.addAttribute("msg",msg);
        return "/signUp/popupclose";

    }

}
