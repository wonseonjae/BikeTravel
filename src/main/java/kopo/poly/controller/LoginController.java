package kopo.poly.controller;

import kopo.poly.dto.UserDTO;
import kopo.poly.service.ILoginService;
import kopo.poly.service.impl.LoginService;
import kopo.poly.util.CmmUtil;
import kopo.poly.util.UseSha256;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.aggregation.ArithmeticOperators;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

@Slf4j
@Controller
public class LoginController {

    @Autowired
    LoginService loginService;

    //로그인
    @GetMapping("LoginPage")
    public String LoginPage(){

        return "signUp/Login";
    }

    @PostMapping("login")
    public String login(@RequestParam Map<String, String> map, Model model, HttpSession session) {
        log.info(this.getClass().getName() + ".login start!");
        log.info(String.valueOf(map));
        String userpwd = UseSha256.encrypt(map.get("userpwd"));
        log.info(userpwd);
        map.put("userpwd", userpwd);


        try {
            if (map.get("userid") == null || map.get("userpwd") == null) {
                log.info("로그인 에러1");
                model.addAttribute("msg", "아이디 또는 비밀번호를 입력해주세요");
                return "/signUp/MsgToMain";
            }
            UserDTO rDTO = loginService.login(map);
            if (rDTO != null) {
                session.setAttribute("user", rDTO);
                log.info("로그인 세션생성 완료");

            } else {
                log.info("로그인 에러2");
                model.addAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
                return "/signUp/MsgToMain";
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.info("로그인 에러3");
            model.addAttribute("msg", "로그인 중 문제가 발생했습니다.");
            return "/signUp/MsgToMain";
        }
        log.info(this.getClass().getName() + ".login end");
        return "/main";
    } // end of PostMapping("login")


    @RequestMapping(value = "/logOut", method = RequestMethod.GET)
    public String logOutPost( HttpSession session){

        log.info("입장");
        session.invalidate();
        log.info("로그아웃 완료");

        return "/main";
    }

    @GetMapping(value = "/findIdPw")
    public String findIdPw() {
        log.info(this.getClass().getName()+ ".findIdPw 시작");

        return "/signUp/find";
    }

    @PostMapping(value = "/findId")
    public String findId(HttpServletRequest request, Model model) throws Exception {
        log.info(this.getClass().getName()+".findID 시작");
        String mailid = CmmUtil.nvl(request.getParameter("user_mailid"));
        String maildomain= CmmUtil.nvl(request.getParameter("user_maildomain"));
        log.info("이메일 : " + mailid + "@" + maildomain);
        UserDTO pDTO = new UserDTO();
        pDTO.setUser_mailid(mailid);
        pDTO.setUser_maildomain(maildomain);
        UserDTO rDTO = loginService.findByemail(pDTO);
        if(loginService.findIdCheck(pDTO)==0) {
            model.addAttribute("msg", "이메일을 확인해주세요");
            return "/signUp/find";
        }else {
            String userid = rDTO.getUser_id();
            model.addAttribute("userid", userid);
            log.info(this.getClass().getName()+".findId 끝");
            return "/signUp/findIdResult";

        }
    }
    @GetMapping(value = "/findPw")
    public String findPwView() throws Exception{


        return "/signUp/findPw";
    }

    @GetMapping(value = "/pwCheck")
    public String pwCheck() {

        return "/signUp/pwCheck";
    }

    @GetMapping(value = "/deleteUser")
    public String deleteUser(HttpSession session, HttpServletRequest request, Model model) throws Exception {
        log.info(this.getClass().getName()+".deleteUser start!");
        int user_no = Integer.valueOf(CmmUtil.nvl(request.getParameter("user_no")));
        UserDTO pDTO = new UserDTO();
        pDTO.setUser_no(user_no);

        loginService.deleteUser(pDTO);
        session.invalidate();

        model.addAttribute("msg", "회원탈퇴가 완료되었습니다");
        log.info(this.getClass().getName()+".deleteUser end!");

        return "/signUp/MsgToMain";
    }
}
