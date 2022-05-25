package kopo.poly.controller;
import kopo.poly.dto.BoardDTO;
import kopo.poly.dto.CommentDTO;
import kopo.poly.dto.Criteria;
import kopo.poly.dto.PageMakeDTO;
import kopo.poly.service.impl.BoardService;
import kopo.poly.service.impl.S3Service;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Objects;

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
    public String execWrite(MultipartHttpServletRequest request, Model model) throws IOException {
        log.info(this.getClass().getName() + ".execWrite start");
        String title = CmmUtil.nvl(request.getParameter("title"));
        String coursename = CmmUtil.nvl(request.getParameter("s2"));
        String contents = CmmUtil.nvl(request.getParameter("contents"));
        if(!Objects.requireNonNull(request.getFile("file")).isEmpty()) {
            MultipartFile file = request.getFile("file");
            String imgPath = s3Service.upload(file);
            String imglink = "https://d1y3hanryj5vy8.cloudfront.net/" + imgPath;
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
            String msg = "글이 작성되었습니다.";
            model.addAttribute("msg", msg);
        }else{
            int user_no = Integer.parseInt(CmmUtil.nvl(request.getParameter("user_no")));
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
    @PostMapping("/commentReg")
    public String commentReg(HttpServletRequest request, Model model) throws Exception {
        int bNo = Integer.parseInt(CmmUtil.nvl(request.getParameter("board_no")));
        String comment =CmmUtil.nvl(request.getParameter("comment"));
        int uNo = Integer.parseInt(CmmUtil.nvl(request.getParameter("user_no")));
        CommentDTO pDTO = new CommentDTO();
        pDTO.setUser_no(uNo);
        pDTO.setBoard_no(bNo);
        pDTO.setComment_text(comment);
        boardService.insertComment(pDTO);
        model.addAttribute("bNo", String.valueOf(bNo));
        model.addAttribute("msg","댓글이 등록되었습니다.");

        return "/board/MsgToBoardInfo";
    }

    @GetMapping(value = "repDelete")
    public String repDelete(HttpServletRequest request, Model model) {

        int cNo = Integer.parseInt(request.getParameter("cNo"));
        String bNo = CmmUtil.nvl(request.getParameter("bNo"));
        log.info(String.valueOf(cNo));
        CommentDTO pDTO = new CommentDTO();
        pDTO.setComment_no(cNo);
        int res = boardService.repDelete(pDTO);
        model.addAttribute("msg", "댓글이 삭제되었습니다");
        model.addAttribute("bNo", bNo);
        return "/board/MsgToBoardInfo";
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
    public String BoardEditInfo(HttpServletRequest request, ModelMap model) {
        log.info(this.getClass().getName() + ".BoardEditInfo start!");

        String msg = "";

        try {

            String nSeq = CmmUtil.nvl(request.getParameter("nSeq")); // 공지글번호(PK)

            log.info("nSeq : " + nSeq);

            BoardDTO pDTO = new BoardDTO();

            pDTO.setBoard_no(Integer.parseInt(nSeq));

            /*
             * ####################################################### 공지사항 수정정보 가져오기(상세보기
             * 쿼리와 동일하여, 같은 서비스 쿼리 사용함)
             * #######################################################
             */
            BoardDTO rDTO = boardService.getBoardInfo(pDTO);

            if (rDTO == null) {
                rDTO = new BoardDTO();

            }

            // 조회된 리스트 결과값 넣어주기
            model.addAttribute("rDTO", rDTO);

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".BoardUpdate end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        log.info(this.getClass().getName() + ".BoardEditInfo end!");


        return "/board/boardEditInfo";
    }

    @PostMapping(value = "/boardUpdate")
    public String boardUpdate(HttpServletRequest request, Model model) throws Exception {
        String title = CmmUtil.nvl(request.getParameter("title"));
        String coursename = CmmUtil.nvl(request.getParameter("s2"));
        String contents = CmmUtil.nvl(request.getParameter("contents"));
        String imgLink = CmmUtil.nvl(request.getParameter("imgLink"));
        int board_no = Integer.parseInt(CmmUtil.nvl(request.getParameter("nSeq")));
        BoardDTO pDTO = new BoardDTO();
        pDTO.setTitle(title);
        pDTO.setCoursename(coursename);
        pDTO.setContents(contents);
        pDTO.setImglink(imgLink);
        pDTO.setBoard_no(board_no);
        boardService.boardUpdate(pDTO);

        String msg = "글이 수정되었습니다.";
        model.addAttribute("msg", msg);
        return "/board/MsgToList";

    }

    @GetMapping(value = "/boardDelete")
    public String boardDelete(HttpServletRequest request, Model model) throws Exception{
        int board_no = Integer.parseInt(CmmUtil.nvl(request.getParameter("nSeq")));

        BoardDTO pDTO = new BoardDTO();
        pDTO.setBoard_no(board_no);
        boardService.boardDelete(pDTO);
        String msg = "게시글이 삭제 되었습니다.";
        model.addAttribute("msg",msg);
        return "/board/MsgToList";


    }

    @GetMapping("/board/list")
    public void boardListGET(HttpServletRequest request, Model model, Criteria cri) throws Exception {
        int pNo = 1;
        if (request.getParameter("pNo") != null) {
            pNo = Integer.valueOf(request.getParameter("pNo"));

            log.info("cri : " + cri);

            model.addAttribute("list", boardService.getListPaging(pNo));

            int total = boardService.totalCount(cri);

            PageMakeDTO pageMake = new PageMakeDTO(cri, total);

            model.addAttribute("pageMaker", pageMake);

        }
        log.info("boardListGET");

        log.info("cri : " + cri);

        model.addAttribute("list", boardService.getListPaging(pNo));

        int total = boardService.totalCount(cri);

        PageMakeDTO pageMake = new PageMakeDTO(cri, total);

        model.addAttribute("pageMaker", pageMake);

    }

    @GetMapping("/board/listByCourse")
    public void boardListByCourseName(HttpServletRequest request, Model model, Criteria cri) throws Exception {
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

        }

        log.info("cri : " + cri);

        model.addAttribute("list", boardService.getListPagingByCourse(pNo, pDTO));

        int total = boardService.totalCountByCourse(pDTO);

        PageMakeDTO pageMake = new PageMakeDTO(cri, total);

        model.addAttribute("pageMaker", pageMake);
        model.addAttribute("s1",courseDiv);
        model.addAttribute("s2",courseName);

    }

}
