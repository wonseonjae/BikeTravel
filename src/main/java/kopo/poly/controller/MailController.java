package kopo.poly.controller;

import kopo.poly.service.impl.MailService;
import kopo.poly.util.CmmUtil;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@Slf4j
@AllArgsConstructor
public class MailController {
    private MailService mailService;

    //이메일 인증번호 발송
    @ResponseBody
    @PostMapping(value = "/mailSend")
    private int sendEmail(HttpServletRequest request){
        String userEmail = CmmUtil.nvl(request.getParameter("userEmail"));
        int res = 0;
        log.info(this.getClass().getName() + ".sendEmail start");

        HttpSession session = request.getSession();

        mailService.sendEmail(session, userEmail);
        log.info(this.getClass().getName() + ".sendEmail end");
        res = 1;
        return res;

    }

    //이메일 인증번호 진위여부 확인
    @ResponseBody
    @PostMapping(value = "/mailReg")
    private boolean emailCertification(HttpServletRequest request, String userEmail,String inputCode){
        System.out.println(inputCode);
        log.info(this.getClass().getName() + ".emailCertification start");
        HttpSession session = request.getSession();
        boolean result = mailService.emailCertification(session, userEmail, Integer.parseInt(inputCode));
        log.info(this.getClass().getName() + ".emailCertification end");
        log.info(String.valueOf(result));
        return result;

    }
}
