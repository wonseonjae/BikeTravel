package kopo.poly.service.impl;

import kopo.poly.dto.BoardDTO;
import kopo.poly.dto.UserDTO;
import kopo.poly.mapper.IAdminMapper;
import kopo.poly.service.IAdminService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
public class AdminService implements IAdminService {

    @Autowired
    private IAdminMapper adminMapper;

    @Transactional
    @Override
    public List<UserDTO> getUserList() {
        log.info(this.getClass().getName()+".getUserList start");
        return adminMapper.getUserList();
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





