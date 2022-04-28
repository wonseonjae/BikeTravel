package kopo.poly.controller;

import kopo.poly.dto.UserDTO;
import kopo.poly.service.ILoginService;
import kopo.poly.service.impl.LoginService;
import kopo.poly.util.UseSha256;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
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
        log.info(String.valueOf(map));

        try {
            if (map.get("userid") == null || map.get("userpwd") == null) {
                log.info("로그인 에러1");
                model.addAttribute("msg", "아이디 또는 비밀번호를 입력해주세요");
                return "error/error";
            }
            UserDTO rDTO = loginService.login(map);
            if (rDTO != null) {
                session.setAttribute("user", rDTO);
                String valeu = String.valueOf(session.getAttribute("user"));
                log.info(valeu);

            } else {
                log.info("로그인 에러2");
                model.addAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
                return "error/error";
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.info("로그인 에러3");
            model.addAttribute("msg", "로그인 중 문제가 발생했습니다.");
            return "error/error";
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
}
