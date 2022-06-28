package kopo.poly.service.impl;

import kopo.poly.dto.*;
import kopo.poly.mapper.IAdminMapper;
import kopo.poly.service.IAdminService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class AdminService implements IAdminService {
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    Date time = new Date();
    String localTime = format.format(time);

    @Autowired
    private IAdminMapper adminMapper;

    @Override
    public List<UserDTO> getUserPaging(int uNo) {
        Criteria cri = new Criteria();
        cri.setPageNum(uNo);
        return adminMapper.getUserPaging(cri);
    }

    @Override
    public int userTotalCount(Criteria cri) throws Exception {
        return adminMapper.userTotalCount(cri);
    }

    @Override
    public List<NoticeDTO> getNoticePaging(int uNo) {
        Criteria cri = new Criteria();
        cri.setPageNum(uNo);
        return adminMapper.getNoticePaging(cri);
    }

    @Override
    public int noticeTotalCount(Criteria cri) throws Exception {
        return adminMapper.NoticeTotalCount(cri);
    }

    @Override
    public int insertNotice(NoticeDTO pDTO) {
        int res = 0;
        pDTO.setRegdate(localTime);
        adminMapper.insertNotice(pDTO);
        res = 1;
        return res;
    }

    @Override
    public int deleteNotice(NoticeDTO pDTO) {
        adminMapper.deleteNotice(pDTO);

        return 0;
    }

    @Override
    public NoticeDTO noticeDetail(NoticeDTO pDTO) {
        return adminMapper.noticeDetail(pDTO);
    }

    @Override
    public UserDTO getUserInfo(UserDTO pDTO) throws Exception {

        log.info(this.getClass().getName()+".getUserInfo start");
        return adminMapper.getUserInfo(pDTO);
    }

    @Override
    public List<BoardDTO> getUserBoard(UserDTO pDTO) {
        log.info(this.getClass().getName()+".getUserBoard start");

        return adminMapper.getUserBoard(pDTO);
    }

    @Override
    public BoardDTO userBoardDetail(BoardDTO pDTO) throws Exception {
        return adminMapper.userBoardDetail(pDTO);
    }

    @Override
    public void boardDelete(BoardDTO pDTO) throws Exception {
        log.info(this.getClass().getName()+".boardDelete start");
        adminMapper.boardDelete(pDTO);
    }

    @Override
    public void deleteUser(UserDTO pDTO) throws Exception {
        log.info(this.getClass().getName()+".deleteUser start");
        adminMapper.deleteUser(pDTO);

    }

    @Override
    public int pwCheck(UserDTO pDTO) {
        log.info(this.getClass().getName()+".pwCheck start");
        return adminMapper.pwCheck(pDTO);


    }

    @Override
    public int chgPw(UserDTO pDTO) throws Exception {
        adminMapper.chgPw(pDTO);
        return 0;
    }

    @Override
    public int chgName(UserDTO pDTO) throws Exception {
        adminMapper.chgName(pDTO);
        return 0;
    }


}





