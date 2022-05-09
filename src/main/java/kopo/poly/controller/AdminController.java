package kopo.poly.controller;

import kopo.poly.dto.BoardDTO;
import kopo.poly.dto.UserDTO;
import kopo.poly.service.IAdminService;
import kopo.poly.service.ILoginService;
import kopo.poly.service.IUserService;
import kopo.poly.service.impl.BoardService;
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

    @GetMapping(value = "/admin")
    public String admin(Model model) {

        List<UserDTO> rList = adminService.getUserList();

        model.addAttribute("rList", rList);
        return "/admin/adminPage";
    }

    @GetMapping(value = "/admin/userInfo")
    public String userInfo(HttpServletRequest request, Model model) {
        log.info(this.getClass().getName()+".userInfo start!");

        int user_no = Integer.valueOf(CmmUtil.nvl(request.getParameter("bNo")));
        UserDTO pDTO = new UserDTO();
        pDTO.setUser_no(user_no);



        return "admin/userInfo";
    }


    @GetMapping(value = "/adminDeleteUser")
    public String deleteUser(HttpSession session, HttpServletRequest request, Model model) throws Exception {
        log.info(this.getClass().getName()+".adminDeleteUser start!");
        int user_no = Integer.valueOf(CmmUtil.nvl(request.getParameter("user_no")));
        UserDTO pDTO = new UserDTO();
        pDTO.setUser_no(user_no);

        adminService.deleteUser(pDTO);

        model.addAttribute("msg", "회원삭제가 완료되었습니다");
        log.info(this.getClass().getName()+".adminDeleteUser end!");

        return "/admin";
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
    public String chgName(HttpServletRequest request) throws Exception {
        String user_name = request.getParameter("user_name");
        int user_no = Integer.valueOf(request.getParameter("user_no"));
        UserDTO pDTO = new UserDTO();
        pDTO.setUser_name(user_name);
        pDTO.setUser_no(user_no);
        adminService.chgName(pDTO);

        return "/myPage";

    }

    @PostMapping(value = "/admin/chgPw")
    public String chgPw(HttpServletRequest request, Model model, HttpSession session) throws Exception {
        String pw = UseSha256.encrypt(request.getParameter("pw"));
        int user_no = Integer.valueOf(request.getParameter("user_no"));
        UserDTO pDTO = new UserDTO();
        pDTO.setUser_pw(pw);
        pDTO.setUser_no(user_no);
        adminService.chgPw(pDTO);

        session.invalidate();


        String msg = "비밀번호가 변경되었습니다. 다시 로그인 해주세요";
        model.addAttribute("msg",msg);
        return "/signUp/MsgToMain";

    }

}
