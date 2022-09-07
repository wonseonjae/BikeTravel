package kopo.poly.controller;

import kopo.poly.dto.PapagoDTO;
import kopo.poly.service.IPapagoService;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping(value ="papago")
@Slf4j

public class PapagoController {

    @Resource(name = "PapagoService")
    private IPapagoService papagoService;

    @GetMapping(value = "detectLangs")
    public PapagoDTO detectLangs(HttpServletRequest request)throws Exception{
        String text = CmmUtil.nvl(request.getParameter("text"));
        log.info(text);
        PapagoDTO pDTO = new PapagoDTO();
        pDTO.setText(text);
        PapagoDTO rDTO = papagoService.detectLangs(pDTO);
        log.info(rDTO.getLangCode());
        if (rDTO == null){
            rDTO = new PapagoDTO();
        }

        return rDTO;
    }


}
