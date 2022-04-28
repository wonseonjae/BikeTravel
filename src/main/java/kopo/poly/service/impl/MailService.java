package kopo.poly.service.impl;


import kopo.poly.handler.MailHandler;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;

import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.Random;

@Slf4j
@Service("mailService")
public class MailService {

    @Autowired
    private JavaMailSender javaMailSender;

    @Value("${spring.mail.username}")
    String sendFrom;



   //인증번호 발송 코드
    public void sendEmail(HttpSession session, String userEmail){
        log.info(this.getClass().getName() + ".sendEmail start!");
        try{
            MailHandler mailHandler = new MailHandler(javaMailSender);
            Random random = new Random(System.currentTimeMillis());
            long start = System.currentTimeMillis();

            int result = 100000 + random.nextInt(900000);

            //받는사람
            mailHandler.setTo(userEmail);
            //보내는 사람
            log.info(sendFrom);
            mailHandler.setFrom(sendFrom);
            //제목
            mailHandler.setSubject("자전거 여행 이메일 인증번호입니다.");
            // HTML Layout
            String htmlContent = "<p>인증번호 : + " + result + "<p>";
            mailHandler.setText(htmlContent,true);

            mailHandler.send();

            long end = System.currentTimeMillis();
            session.setAttribute(""+userEmail, result);

            log.info(this.getClass().getName() + ".sendEmail end!");
      }
        catch (Exception e){
            e.printStackTrace();
        }
   }

   //인증번호 대조 코드
   public boolean emailCertification(HttpSession session, String userEmail, int inputCode){
        try {
            int generationCode = (int) session.getAttribute(userEmail);


            if (generationCode == inputCode) {
                return true;
            }else {
                return false;
            }
        }catch (Exception e){
            throw e;
        }
   }

}
