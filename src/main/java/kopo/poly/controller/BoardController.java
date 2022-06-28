package kopo.poly.controller;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import kopo.poly.dto.*;
import kopo.poly.service.impl.BoardService;
import kopo.poly.service.impl.S3Service;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Slf4j
@Controller
public class BoardController {

    private final BoardService boardService;

    private final S3Service s3Service;

    public BoardController(BoardService boardService, S3Service s3Service) {
        this.boardService = boardService;
        this.s3Service = s3Service;
    }


    @GetMapping("/board/boardWrite")
    public String WriteBoard() {
        log.info(this.getClass().getName() + ".WriteBoard Form");
        return "/board/boardWrite";
    }
    @PostMapping("/upload")
    public String execWrite(MultipartHttpServletRequest request, Model model) throws IOException {
        log.info(this.getClass().getName() + ".execWrite start");
        String title = CmmUtil.nvl(request.getParameter("title"));
        String coursename = CmmUtil.nvl(request.getParameter("s2"));
        String contents = CmmUtil.nvl(request.getParameter("contents"));
        if(!Objects.requireNonNull(request.getFile("file")).isEmpty()) {
            MultipartFile file = request.getFile("file");
            String imgPath = s3Service.upload(file);
            String imglink = "https://d1y3hanryj5vy8.cloudfront.net/" + imgPath;
            Integer user_no = Integer.parseInt(request.getParameter("user_no"));
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
            String msg = "글이 작성되었습니다.";
            model.addAttribute("msg", msg);
        }else{
            int user_no = Integer.parseInt(request.getParameter("user_no"));
            BoardDTO pDTO = new BoardDTO();
            pDTO.setTitle(title);
            pDTO.setCoursename(coursename);
            pDTO.setContents(contents);
            pDTO.setUser_no(user_no);
            boardService.Upload(pDTO);
            String msg = "글이 작성되었습니다.";
            model.addAttribute("msg", msg);

        }
        return "/board/MsgToList";

    }

    @ResponseBody
    @PostMapping("/commentReg")
    public void commentReg(@RequestBody List<Map<String, Object>> params, HttpSession session) throws Exception {
        /*ObjectMapper objectMapper = new ObjectMapper();
        List<Map<String, Object>> param = objectMapper.convertValue(params, new TypeReference<List<Map<String, Object>>>(){});*/
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        for (Map<String, Object> list : params) {
            String comment = (String) list.get("comment");
            Integer bNo = (Integer) list.get("board_no");
            CommentDTO pDTO = new CommentDTO();
            pDTO.setUser_no(uDTO.getUser_no());
            pDTO.setBoard_no(bNo);
            pDTO.setComment_text(comment);
            boardService.insertComment(pDTO);
        }
    }

    @ResponseBody
    @PostMapping("/commentUpdate")
    public void commentUpdate(@RequestBody List<Map<String, Object>> params) throws Exception {
        /*ObjectMapper objectMapper = new ObjectMapper();
        List<Map<String, Object>> param = objectMapper.convertValue(params, new TypeReference<List<Map<String, Object>>>(){});*/

        for (Map<String, Object> list : params) {
            String comment = (String) list.get("comment_text");
            int comment_no = (int) list.get("comment_no");
            CommentDTO pDTO = new CommentDTO();
            pDTO.setComment_text(comment);
            pDTO.setComment_no(comment_no);
            boardService.commentUpdate(pDTO);
        }
    }

    @ResponseBody
    @PostMapping(value = "repDelete")
    public int repDelete(@RequestBody List<Map<String, Object>> params) {
        for (Map<String, Object> list : params) {
            String comment_no = (String) list.get("comment_no");
            int cNo = Integer.parseInt(comment_no);
            CommentDTO pDTO = new CommentDTO();
            pDTO.setComment_no(cNo);
            boardService.repDelete(pDTO);
        }
        return 1;
    }

    @GetMapping(value = "board/boardInfo")
    public String NoticeInfo(HttpServletRequest request, ModelMap model, Criteria cri) {

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

            CommentDTO cDTO = new CommentDTO();
            cDTO.setBoard_no(Integer.parseInt(bNo));
            List<CommentDTO> rList = boardService.getComment(cDTO);
            int res = boardService.getRepCnt(cDTO);

            log.info("getBoardInfo success");

            // 조회된 리스트 결과값 넣어주기
            model.addAttribute("rDTO", rDTO);
            model.addAttribute("rList", rList);
            model.addAttribute("res", res);

        } catch (Exception e) {
            // 저장이 실패되면 사용자에게 보여줄 메시지
            log.info(e.toString());
            e.printStackTrace();
        } finally {
            log.info(this.getClass().getName() + ".boardInfo end!");

        }

        log.info(this.getClass().getName() + ".boardInfo end!");

        return "/board/boardInfo";
    }
    @GetMapping(value = "/board/boardEditInfo")
    public String BoardEditInfo(HttpServletRequest request, ModelMap model) throws Exception {
        log.info(this.getClass().getName() + ".BoardEditInfo start!");
            String msg = "";
            String nSeq = CmmUtil.nvl(request.getParameter("nSeq")); // 글번호(PK)
            log.info("nSeq : " + nSeq);
            BoardDTO pDTO = new BoardDTO();
            pDTO.setBoard_no(Integer.parseInt(nSeq));
            BoardDTO rDTO = boardService.getBoardInfo(pDTO);
            if (rDTO == null) {
                rDTO = new BoardDTO();
            }
            model.addAttribute("rDTO", rDTO);
        log.info(this.getClass().getName() + ".BoardEditInfo end!");
        return "/board/boardEditInfo";
    }

    @PostMapping(value = "/boardUpdate")
    public String boardUpdate(MultipartHttpServletRequest request, Model model) throws Exception {
        String title = CmmUtil.nvl(request.getParameter("title"));
        String coursename = CmmUtil.nvl(request.getParameter("s2"));
        String contents = CmmUtil.nvl(request.getParameter("contents"));
        int board_no = Integer.parseInt(CmmUtil.nvl(request.getParameter("nSeq")));
        String imgLink = CmmUtil.nvl(request.getParameter("imgLink"));
        if(!Objects.requireNonNull(request.getFile("file")).isEmpty()) {
            s3Service.deleteS3(imgLink);
            MultipartFile file = request.getFile("file");
            String imgPath = s3Service.upload(file);
            String imglink = "https://d1y3hanryj5vy8.cloudfront.net/" + imgPath;
            log.info(title);
            log.info(coursename);
            log.info(contents);
            log.info(imglink);
            BoardDTO pDTO = new BoardDTO();
            pDTO.setTitle(title);
            pDTO.setCoursename(coursename);
            pDTO.setContents(contents);
            pDTO.setBoard_no(board_no);
            pDTO.setImglink(imglink);
            boardService.boardUpdate(pDTO);
            String msg = "글이 수정되었습니다.";
            model.addAttribute("msg", msg);
        }else{
            BoardDTO pDTO = new BoardDTO();
            pDTO.setTitle(title);
            pDTO.setCoursename(coursename);
            pDTO.setContents(contents);
            pDTO.setBoard_no(board_no);
            pDTO.setImglink(imgLink);
            boardService.boardUpdate(pDTO);
            String msg = "글이 수정되었습니다.";
            model.addAttribute("msg", msg);
        }
        return "/board/MsgToList";

    }

    @GetMapping(value = "/boardDelete")
    public String boardDelete(HttpServletRequest request, Model model) throws Exception{
        int board_no = Integer.parseInt(CmmUtil.nvl(request.getParameter("nSeq")));
        BoardDTO pDTO = new BoardDTO();
        pDTO.setBoard_no(board_no);
        BoardDTO rDTO = boardService.getBoardInfo(pDTO);
        if (rDTO.getImglink() != null) {
            String[] fileName = rDTO.getImglink().split("/");
            s3Service.deleteS3(fileName[3]);
            boardService.boardDelete(pDTO);
            String msg = "게시글이 삭제 되었습니다.";
            model.addAttribute("msg",msg);
            return "/board/MsgToList";
        }else {
            boardService.boardDelete(pDTO);
            String msg = "게시글이 삭제 되었습니다.";
            model.addAttribute("msg",msg);
            return "/board/MsgToList";
        }
    }

    @GetMapping("/board/list")
    public String boardListGET(HttpServletRequest request, Model model, Criteria cri) throws Exception {
        int pNo = 1;
        if (request.getParameter("pNo") != null) {
            pNo = Integer.valueOf(request.getParameter("pNo"));

            log.info("cri : " + cri);

            model.addAttribute("list", boardService.getListPaging(pNo));

            int total = boardService.totalCount(cri);

            PageMakeDTO pageMake = new PageMakeDTO(cri, total);

            model.addAttribute("pageMaker", pageMake);
            return "/board/list";
        }
        log.info("boardListGET");

        log.info("cri : " + cri);

        model.addAttribute("list", boardService.getListPaging(pNo));

        int total = boardService.totalCount(cri);

        PageMakeDTO pageMake = new PageMakeDTO(cri, total);

        model.addAttribute("pageMaker", pageMake);
        return "/board/list";
    }

    @GetMapping("/board/listByCourse")
    public String boardListByCourseName(HttpServletRequest request, Model model, Criteria cri) throws Exception {
        int pNo = 1;
        String courseDiv = CmmUtil.nvl(request.getParameter("s1"));
        String courseName = CmmUtil.nvl(request.getParameter("s2"));
        log.info(courseName);
        BoardDTO pDTO = new BoardDTO();
        pDTO.setCoursename(courseName);

        if (request.getParameter("pNo") != null) {
            pNo = Integer.valueOf(request.getParameter("pNo"));

            log.info("cri : " + cri);

            model.addAttribute("list", boardService.getListPagingByCourse(pNo, pDTO));
            model.addAttribute("s1",courseDiv);
            model.addAttribute("s2",courseName);

            int total = boardService.totalCountByCourse(pDTO);
            cri.setPageNum(pNo);
            PageMakeDTO pageMake = new PageMakeDTO(cri, total);

            model.addAttribute("pageMaker", pageMake);

            return "/board/list";
        }

        log.info("cri : " + cri);

        model.addAttribute("list", boardService.getListPagingByCourse(pNo, pDTO));

        int total = boardService.totalCountByCourse(pDTO);

        PageMakeDTO pageMake = new PageMakeDTO(cri, total);

        model.addAttribute("pageMaker", pageMake);
        model.addAttribute("s1",courseDiv);
        model.addAttribute("s2",courseName);
        return "/board/list";

    }

}
