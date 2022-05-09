package kopo.poly.service;

import kopo.poly.dto.BoardDTO;
import kopo.poly.dto.UserDTO;

import java.util.List;

public interface IAdminService {

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
    int chgPw(UserDTO pDTO) throws Exception;

    //회원 비밀번호 변경
    int chgName(UserDTO pDTO) throws Exception;


}
