package kopo.poly.mapper;

import kopo.poly.controller.Criteria;
import kopo.poly.dto.BoardDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.ui.Model;

import java.util.List;

@Mapper
public interface IBoardMapper {
    int Upload(BoardDTO pDTO);

    List<BoardDTO> getBoardList() throws Exception;

    List<BoardDTO> getBoardListByCourse(BoardDTO pDTO) throws Exception;

    int totalCount() throws Exception;

    BoardDTO getBoardInfo(BoardDTO pDTO) throws Exception;

    int boardUpdate(BoardDTO pDTO) throws Exception;

    int boardDelete(BoardDTO pDTO) throws Exception;
}
