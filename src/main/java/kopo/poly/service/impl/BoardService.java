package kopo.poly.service.impl;


import kopo.poly.controller.Criteria;
import kopo.poly.dto.BoardDTO;
import kopo.poly.mapper.IBoardMapper;
import kopo.poly.util.BoardPager;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class BoardService {

    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    Date time = new Date();
    String localTime = format.format(time);

    @Autowired
    IBoardMapper iBoardMapper;

   public void Upload(BoardDTO pDTO){
       log.info(this.getClass().getName() + ".upload start");
       log.info(String.valueOf(pDTO));
       log.info(this.getClass().getName() + ".upload end");
       pDTO.setRegdate(localTime);
       iBoardMapper.Upload(pDTO);

   }

   public List<BoardDTO> getBoardList() throws Exception {
       log.info(this.getClass().getName() + ".getBoardList start");
       log.info(this.getClass().getName() + ".getBoardList end");
        return iBoardMapper.getBoardList();

   }

    public List<BoardDTO> getBoardListByCourse(BoardDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".getBoardList start");
        log.info(this.getClass().getName() + ".getBoardList end");

        return iBoardMapper.getBoardListByCourse(pDTO);
    }

    public int totalCount() throws Exception {
       return iBoardMapper.totalCount();
    }


    public BoardDTO getBoardInfo(BoardDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".getBoardInfo start!");


        return iBoardMapper.getBoardInfo(pDTO);

    }

    public void boardUpdate(BoardDTO pDTO) throws Exception{
       log.info(this.getClass().getName() + ".boardUpdate start!");
       pDTO.setRegdate(localTime);
       iBoardMapper.boardUpdate(pDTO);
    }

    public void boardDelete(BoardDTO pDTO) throws Exception{
       log.info(this.getClass().getName()+".boardDelete start!");
       iBoardMapper.boardDelete(pDTO);
    }
}
