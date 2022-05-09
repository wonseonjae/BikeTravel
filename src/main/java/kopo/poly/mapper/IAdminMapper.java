package kopo.poly.mapper;

import kopo.poly.dto.BoardDTO;
import kopo.poly.dto.UserDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IAdminMapper {

    //회원 리스트 호출
    List<UserDTO> getUserList();

    //회원 정보 호출
    UserDTO getUserInfo(UserDTO pDTO) throws Exception;

    //회원 작성글 목록
    List<BoardDTO> getUserBoard(UserDTO pDTO);

    //회원 작성글 상세보기
    BoardDTO getBoardInfo(UserDTO pDTO) throws Exception;

    //회원 작성글 삭제
    void boardDelete(UserDTO pDTO) throws Exception;

    //회원 정보 삭제
    void deleteUser(UserDTO pDTO) throws Exception;

    //회원 비밀번호 체크
    int pwCheck(UserDTO pDTO);

    //회원 비밀번호 변경
    void chgPw(UserDTO pDTO) throws Exception;

    //회원 비밀번호 변경
    void chgName(UserDTO pDTO) throws Exception;


}
