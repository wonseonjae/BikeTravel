package kopo.poly.service;

import kopo.poly.dto.*;

import java.util.List;

public interface IAdminService {

    //회원 리스트 호출
    List<UserDTO> getUserPaging(int uNo);

    //회원 리스트 페이징
    int userTotalCount(Criteria cri) throws Exception;

    //회원 리스트 호출
    List<NoticeDTO> getNoticePaging(int uNo);

    //회원 리스트 페이징
    int noticeTotalCount(Criteria cri) throws Exception;

    //공지 작성
    int insertNotice(NoticeDTO pDTO);

    //공지 삭제
    int deleteNotice(NoticeDTO pDTO);

    //공지 상세보기
    NoticeDTO noticeDetail(NoticeDTO pDTO);

    //회원 정보 호출
    UserDTO getUserInfo(UserDTO pDTO) throws Exception;

    //회원 작성글 목록
    List<BoardDTO> getUserBoard(UserDTO pDTO);

    //회원 작성글 상세보기
    BoardDTO userBoardDetail(BoardDTO pDTO) throws Exception;

    //회원 작성글 삭제
    void boardDelete(BoardDTO pDTO) throws Exception;

    //회원 정보 삭제
    void deleteUser(UserDTO pDTO) throws Exception;

    //회원 비밀번호 체크
    int pwCheck(UserDTO pDTO);

    //회원 비밀번호 변경
    int chgPw(UserDTO pDTO) throws Exception;

    //회원 비밀번호 변경
    int chgName(UserDTO pDTO) throws Exception;


}
