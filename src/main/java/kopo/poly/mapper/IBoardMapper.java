package kopo.poly.mapper;

import kopo.poly.dto.BoardDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IBoardMapper {
    int Upload(BoardDTO pDTO);

    List<BoardDTO> getBoardList() throws Exception;

    BoardDTO getBoardInfo(BoardDTO pDTO) throws Exception;
}
