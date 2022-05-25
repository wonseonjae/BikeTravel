package kopo.poly.service.impl;


import kopo.poly.dto.BoardDTO;
import kopo.poly.dto.CommentDTO;
import kopo.poly.dto.Criteria;
import kopo.poly.mapper.IBoardMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Slf4j
@Service
public class BoardService {

    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    Date time = new Date();
    String localTime = format.format(time);

    @Autowired
    IBoardMapper iBoardMapper;

    //게시글 등록
   public void Upload(BoardDTO pDTO){
       log.info(this.getClass().getName() + ".upload start");
       log.info(String.valueOf(pDTO));
       log.info(this.getClass().getName() + ".upload end");
       pDTO.setRegdate(localTime);
       iBoardMapper.Upload(pDTO);

   }

   //게시글 목록 호출
   public List<BoardDTO> getBoardList() throws Exception {
       log.info(this.getClass().getName() + ".getBoardList start");
       log.info(this.getClass().getName() + ".getBoardList end");
        return iBoardMapper.getBoardList();

   }

   //게시글 코스로 검색하기
    public List<BoardDTO> getBoardListByCourse(BoardDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".getBoardList start");
        log.info(this.getClass().getName() + ".getBoardList end");

        return iBoardMapper.getBoardListByCourse(pDTO);
    }

    //게시글 총갯수 조회
    public int totalCount(Criteria cri) throws Exception {

       return iBoardMapper.totalCount(cri);
    }

    public int totalCountByCourse(BoardDTO pDTO) throws Exception {

        return iBoardMapper.totalCountByCourse(pDTO);
    }

    //게시판 상세보기
    public BoardDTO getBoardInfo(BoardDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".getBoardInfo start!");


        return iBoardMapper.getBoardInfo(pDTO);

    }

    //게시글 수정
    public void boardUpdate(BoardDTO pDTO) throws Exception{
       log.info(this.getClass().getName() + ".boardUpdate start!");
       pDTO.setRegdate(localTime);
       iBoardMapper.boardUpdate(pDTO);
    }

    //게시글 삭제
    public void boardDelete(BoardDTO pDTO) throws Exception{
       log.info(this.getClass().getName()+".boardDelete start!");
       iBoardMapper.boardDelete(pDTO);
    }

    public List<BoardDTO> getListPaging(int pNo) {
       Criteria cri = new Criteria();
       cri.setPageNum(pNo);
        return iBoardMapper.getListPaging(cri);
    }

    public List<BoardDTO> getListPagingByCourse(int pNo, BoardDTO pDTO) {
        HashMap<String, Object> hMap = new HashMap();
        Criteria cri = new Criteria();
        cri.setPageNum(pNo);
        hMap.put("skip", cri.getSkip());
        hMap.put("amount", cri.getAmount());
        hMap.put("coursename", pDTO.getCoursename());

        return iBoardMapper.getListPagingByCourse(hMap);
    }

    public int insertComment(CommentDTO pDTO) throws Exception {
       int res = 0;
       pDTO.setRegdate(localTime);
       iBoardMapper.insertComment(pDTO);
       res = 1;
       return res;
    }

    public List<CommentDTO> getComment(CommentDTO pDTO) {

        return iBoardMapper.getComment(pDTO);
    }

    public int getRepCnt(CommentDTO pDTO) {
       return iBoardMapper.getRepCnt(pDTO);
    }

    public int repDelete(CommentDTO pDTO) {
       iBoardMapper.repDelete(pDTO);
       return 0;
    }

}
