package kopo.poly.controller;

import kopo.poly.dto.BikeCertificateDTO;
import kopo.poly.service.impl.BikeService;
import kopo.poly.util.CmmUtil;
import kopo.poly.util.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Slf4j
public class BikeCertificateController {


    @Autowired
    private BikeService bikeCertificateService;

 /*   @GetMapping("/bike/regCertificate")
    public int regCertificate(HttpServletRequest request, HttpSession session) throws Exception{

        int res = 0;

        String checkPoint = CmmUtil.nvl(request.getParameter("checkPoint"));
        log.info(checkPoint);
        BikeCertificateDTO pDTO = new BikeCertificateDTO();
        int user_no = (int) session.getAttribute("USER_NO");
        log.info(String.valueOf(user_no));
        pDTO.setCertificate(checkPoint);
        pDTO.setUser_no(user_no);
        pDTO.setReg_dt(DateUtil.getDateTime("yyyy-MM-dd"));

        bikeCertificateService.insertCertificate(pDTO);

        return res;
    }

    @GetMapping("/bike/getCertificate")
    public List<BikeCertificateDTO> getCertificate(HttpServletRequest request, Model model) throws Exception{

        BikeCertificateDTO pDTO = new BikeCertificateDTO();

        List<BikeCertificateDTO> rList = bikeCertificateService.selectCertificate(pDTO);

        return rList;
    }*/
}
