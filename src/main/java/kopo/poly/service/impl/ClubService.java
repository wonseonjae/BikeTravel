package kopo.poly.service.impl;

import kopo.poly.dto.*;
import kopo.poly.mapper.IClubMapper;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
@Slf4j
public class ClubService {

    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    Date time = new Date();
    String localTime = format.format(time);

    @Autowired
    private IClubMapper clubMapper;

    public List<ClubListDTO> getClubList(int pNo) {
        log.info("들어왔다");
        ClubCriteria cri = new ClubCriteria();
        cri.setPageNum(pNo);
        return clubMapper.getClubList(cri);
    }

    public List<ClubListDTO> getClubListByRange(int pNo, ClubListDTO pDTO) throws Exception{
        HashMap<String, Object> hMap = new HashMap<>();
        ClubCriteria cri = new ClubCriteria();
        cri.setPageNum(pNo);
        hMap.put("skip", cri.getSkip());
        hMap.put("amount", cri.getAmount());
        hMap.put("clubrange", pDTO.getClubrange());

        return clubMapper.getClubListByRange(hMap);
    }

    public int insertClub(ClubListDTO pDTO) throws Exception{
        pDTO.setRegdate(localTime);
       return clubMapper.insertClub(pDTO);
    }

    public void deleteClub(ClubListDTO pDTO) throws Exception{
        clubMapper.deleteClub(pDTO);
    }

    public void updateClub(ClubListDTO pDTO) throws Exception{
        clubMapper.updateClub(pDTO);
    }

    public ClubListDTO getClubDetail(ClubListDTO pDTO) throws Exception{
        return clubMapper.getClubDetail(pDTO);
    }
    public List<WaitDTO> getWaitList(ClubListDTO pDTO) throws Exception{
        return clubMapper.getWaitList(pDTO);
    }

    public WaitDTO getWaitMember(WaitDTO pDTO) throws Exception{
        return clubMapper.getWaitMember(pDTO);
    }

    public List<ClubDTO> getClubMemberNum(ClubListDTO pDTO) throws Exception{
        return clubMapper.getClubMemberNum(pDTO);
    }

    public int nameChk(ClubListDTO pDTO) throws Exception{
        log.info(this.getClass().getName() + ".nameCheck start");

        int res = 0;
        String club_name = CmmUtil.nvl(pDTO.getClub_name());
        log.info(club_name);

        ClubListDTO rDTO = clubMapper.nameChk(pDTO);

        if (rDTO == null) {
            rDTO = new ClubListDTO();
        }

        if (CmmUtil.nvl(rDTO.getName_exists()).equals("Y")){
            res = 1;
        }else{
            res = 0;

        }

        log.info(String.valueOf(res));
        log.info(this.getClass().getName() + ".idCheck end");
        return res;

    }

    public void joinWaiting(WaitDTO pDTO) throws Exception{
        pDTO.setRegdate(localTime);
        clubMapper.joinWaiting(pDTO);
    }

    public void joinAccept(ClubDTO pDTO) throws Exception{
        pDTO.setRegdate(localTime);
        clubMapper.joinAccept(pDTO);
    }
    public void deleteJoin(WaitDTO pDTO) throws Exception{
        clubMapper.deleteJoin(pDTO);
    }

    public int totalCount() throws Exception{
        return clubMapper.totalCount();
    }

    public int totalCountByRange(ClubListDTO pDTO) throws Exception{
        return clubMapper.totalCountByRange(pDTO);
    }

    public List<CalendarDTO> getCalendarList(CalendarDTO pDTO) throws Exception{
        return clubMapper.getCalendarList(pDTO);
    }

    public void insertCalendar(CalendarDTO pDTO) throws Exception{
        clubMapper.insertCalendar(pDTO);
    }

    public void deleteCalendar(CalendarDTO pDTO) throws Exception{
        clubMapper.deleteCalendar(pDTO);
    }
}
