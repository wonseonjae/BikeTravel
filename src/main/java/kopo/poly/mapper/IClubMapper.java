package kopo.poly.mapper;

import kopo.poly.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface IClubMapper {

    //동호회 목록 호출
    List<ClubListDTO> getClubList(ClubCriteria cri) ;

    //범위로 동호회 목록 호출
    List<ClubListDTO> getClubListByRange(HashMap<String , Object> pMap) ;

    //동호회 등록
    int insertClub(ClubListDTO pDTO) throws Exception;

    //동호회 삭제
    int deleteClub(ClubListDTO pDTO) throws Exception;

    //동호회 수정
    int updateClub(ClubListDTO pDTO) throws Exception;

    //동호회 상세보기
    ClubListDTO getClubDetail(ClubListDTO pDTO) throws Exception;

    //동호회 승인대기 목록
    List<WaitDTO> getWaitList(ClubListDTO pDTO) throws Exception;

    //가입신청 데이터 호출
    WaitDTO getWaitMember(WaitDTO pDTO) throws Exception;

    //동호회명 중복체크
    ClubListDTO nameChk(ClubListDTO pDTO);

    //클럽 멤버 회원번호 호출
    List<ClubDTO> getClubMemberNum(ClubListDTO pDTO);
    //동호회 가입 신청
    int joinWaiting(WaitDTO pDTO) throws Exception;

    //동호회 가입신청 승인
    int joinAccept(ClubDTO pDTO) throws Exception;

    //동호회 가입신청 거절
    int deleteJoin(WaitDTO pDTO) throws Exception;

    //동호회 총갯수
    int totalCount() throws Exception;

    //동호회 총갯수 지역으로 찾기
    int totalCountByRange(ClubListDTO pDTO) throws Exception;

    //동호회 일정 호출
    List<CalendarDTO> getCalendarList(CalendarDTO pDTO) throws Exception;

    //동호회 일정 추가
    int insertCalendar(CalendarDTO pDTO) throws Exception;

    //동호회 일정 삭제
    int deleteCalendar(CalendarDTO pDTO) throws Exception;




}
