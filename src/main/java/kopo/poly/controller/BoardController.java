package kopo.poly.controller;

import kopo.poly.dto.BoardDTO;
import kopo.poly.service.impl.BoardService;
import kopo.poly.service.impl.S3Service;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
public class BoardController {

    @Autowired
    private BoardService boardService;

    @Autowired
    private S3Service s3Service;


    @GetMapping("/board/boardWrite")
    public String WriteBoard() {
        log.info(this.getClass().getName() + ".WriteBoard Form");
        return "/board/boardWrite";
    }
    @PostMapping("/upload")
    public String execWrite(MultipartHttpServletRequest request) throws IOException {
        log.info(this.getClass().getName() + ".execWrite start");
        String title = CmmUtil.nvl(request.getParameter("title"));
        String coursename = CmmUtil.nvl(request.getParameter("coursename"));
        String contents = CmmUtil.nvl(request.getParameter("contents"));
        MultipartFile file = request.getFile("file");
        log.info(String.valueOf(file));
        String imgPath = s3Service.upload(file);
        String imglink = "https://d1y3hanryj5vy8.cloudfront.net/"+file;
        Integer user_no = Integer.valueOf(CmmUtil.nvl(request.getParameter("user_no")));
        log.info(title);
        log.info(coursename);
        log.info(contents);
        log.info(imglink);
        log.info(String.valueOf(user_no));

        BoardDTO pDTO = new BoardDTO();
        pDTO.setTitle(title);
        pDTO.setCoursename(coursename);
        pDTO.setContents(contents);
        pDTO.setUser_no(user_no);
        pDTO.setImglink(imglink);
        boardService.Upload(pDTO);

        return "/board/boardList";

    }

    @GetMapping("/board/boardList")
    public String BoardList(ModelMap model) throws Exception {
        log.info(this.getClass().getName() + ".BoardList start!");

        // 공지사항 리스트 가져오기
        List<BoardDTO> rList = boardService.getBoardList();

        if (rList == null) {
            rList = new ArrayList<>();

        }

        // 조회된 리스트 결과값 넣어주기
        model.addAttribute("rList", rList);

        log.info(String.valueOf(rList));

        // 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".BoardList end!");

        // 함수 처리가 끝나고 보여줄 JSP 파일명(/WEB-INF/view/notice/NoticeList.jsp)
        return "/board/boardList";
    }
    @GetMapping(value = "board/boardInfo")
    public String NoticeInfo(HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".boardInfo start!");

        

        try {
            /*
             * 게시판 글 등록되기 위해 사용되는 form객체의 하위 input 객체 등을 받아오기 위해 사용함
             */
            String bNo = CmmUtil.nvl(request.getParameter("bNo")); // 공지글번호(PK)

            /*
             * ####################################################################################
             * 반드시, 값을 받았으면, 꼭 로그를 찍어서 값이 제대로 들어오는지 파악해야함 반드시 작성할 것
             * ####################################################################################
             */
            log.info("bNo : " + bNo);

            /*
             * 값 전달은 반드시 DTO 객체를 이용해서 처리함 전달 받은 값을 DTO 객체에 넣는다.
             */
            BoardDTO pDTO = new BoardDTO();
            pDTO.setBoard_no(Integer.parseInt(bNo));

            // 공지사항 상세정보 가져오기
            BoardDTO rDTO = boardService.getBoardInfo(pDTO);

            if (rDTO == null) {
                rDTO = new BoardDTO();

            }

            log.info("getBoardInfo success");

            // 조회된 리스트 결과값 넣어주기
            model.addAttribute("rDTO", rDTO);


        } catch (Exception e) {

            // 저장이 실패되면 사용자에게 보여줄 메시지
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeInsert end!");

        }

        log.info(this.getClass().getName() + ".boardInfo end!");

        return "/board/boardInfo";
    }

}
