package kopo.poly.service.impl;

import kopo.poly.dto.UserDTO;
import kopo.poly.mapper.IUserMapper;
import kopo.poly.service.IUserService;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class UserService implements IUserService {

    @Autowired
    private final IUserMapper userMapper;



    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    Date time = new Date();
    String localTime = format.format(time);

    @Autowired
    public UserService(IUserMapper userMapper) {

        this.userMapper = userMapper;
    }

    @Transactional
    @Override
    public void InsertUserInfo(UserDTO userdto) throws Exception {
        log.info(this.getClass().getName() + "start!");
        userdto.setAuthority("USER");
        userdto.setRegdate(localTime);

        userMapper.saveUser(userdto);

        log.info(this.getClass().getName() + "end!");
    }

    @Override
    public int idCheck(UserDTO pDTO) {
        log.info(this.getClass().getName() + ".idCheck start");

        int res = 0;
        String user_id = CmmUtil.nvl(pDTO.getUser_id());
        log.info(user_id);

        UserDTO rDTO = userMapper.idCheck(pDTO);

        if (rDTO == null) {
            rDTO = new UserDTO();
        }

        if (CmmUtil.nvl(rDTO.getUses_exists()).equals("Y")){
            res = 1;
        }else{
            res = 0;

        }
        log.info(this.getClass().getName() + ".idCheck end");
        return res;
    }

    @Override
    public int nameCheck(UserDTO pDTO) {
        log.info(this.getClass().getName() + ".nameCheck start");

        int res = 0;
        String user_name = CmmUtil.nvl(pDTO.getUser_name());
        log.info(user_name);

        UserDTO rDTO = userMapper.nameCheck(pDTO);

        if (rDTO == null) {
            rDTO = new UserDTO();
        }

        if (CmmUtil.nvl(rDTO.getUses_exists()).equals("Y")){
            res = 1;
        }else{
            res = 0;

        }

        log.info(String.valueOf(res));
        log.info(this.getClass().getName() + ".idCheck end");
        return res;
    }

    @Override
    public int mailCheck(UserDTO pDTO) {
        int res = 0;
        String user_mailid = CmmUtil.nvl(pDTO.getUser_mailid());
        String user_maildomain = CmmUtil.nvl(pDTO.getUser_maildomain());
        log.info(user_mailid+"@"+user_maildomain);

        UserDTO rDTO = userMapper.nameCheck(pDTO);

        if (rDTO == null) {
            rDTO = new UserDTO();
        }

        if (CmmUtil.nvl(rDTO.getUses_exists()).equals("Y")) {
            res = 1;
        } else {
            res = 0;

        }

        log.info(String.valueOf(res));
        log.info(this.getClass().getName() + ".idCheck end");
        return res;
    }




}





