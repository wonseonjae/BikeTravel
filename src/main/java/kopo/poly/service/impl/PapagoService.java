package kopo.poly.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import kopo.poly.dto.PapagoDTO;
import kopo.poly.service.IPapagoService;
import kopo.poly.util.CmmUtil;
import kopo.poly.util.NetworkUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Objects;

@Service("PapagoService")
@Slf4j
public class PapagoService implements IPapagoService {

    @Value("${naver.papago.clientId}")
    private String clientId;


    @Value("${naver.papago.clientSecret}")
    private String clientSecret;

    private Map<String, String> setNaverInfo(){

        Map<String, String> requestHeader = new HashMap<>();
        requestHeader.put("X-Naver-Client-Id", clientId);
        requestHeader.put("X-Naver-Client-Secret", clientSecret);

        return requestHeader;
    }

    @Override
    public PapagoDTO detectLangs(PapagoDTO pDTO) throws Exception {

        String text = CmmUtil.nvl(pDTO.getText());

        String param = "query=" + URLEncoder.encode(text, "UTF-8");
        String json = NetworkUtil.post(IPapagoService.detectLangsApiURL, this.setNaverInfo(), param);
        log.info(json);
        PapagoDTO rDTO = new ObjectMapper().readValue(json, PapagoDTO.class);
        rDTO.setText(text);

        return rDTO;
    }

    @Override
    public PapagoDTO translate(PapagoDTO pDTO) throws Exception {
        PapagoDTO rDTO = this.detectLangs(pDTO);
        String langCode = CmmUtil.nvl(rDTO.getLangCode());

        rDTO = null;
        String source = "";
        String target = "";
        if (langCode.equals("ko")){
            source = "ko";
            target = "en";
        }else if (langCode.equals("en")){
            source = "en";
            target = "ko";
        }else {
            new Exception(("한국어, 영어만 번역됩니다."));
        }
        String text = CmmUtil.nvl(pDTO.getText());
        String postParam = "source=" + source + "&target=" + target + "&text=" + URLEncoder.encode(text,"UTF-8");

        String json = NetworkUtil.post(IPapagoService.translateApiURL, this.setNaverInfo(), postParam);

        Map<String, Object> rMap = new ObjectMapper().readValue(json, LinkedHashMap.class);
        Map<String, Object> messageMap = (Map<String, Object>) rMap.get("message");
        Map<String, String> resultMap = (Map<String, String>) messageMap.get("result");

        String srcLangType = CmmUtil.nvl(resultMap.get("srcLangType"));
        String tarLangType = CmmUtil.nvl(resultMap.get("tarLangType"));
        String translatedText = CmmUtil.nvl(resultMap.get("translatedText"));
        log.info(tarLangType);
        rDTO = new PapagoDTO();
        rDTO.setTranslatedText(translatedText);
        rDTO.setScrLangType(srcLangType);
        rDTO.setTarLangType(tarLangType);
        rDTO.setText(text);
        resultMap = null;
        messageMap = null;
        rMap = null;
        return rDTO;
    }
}
