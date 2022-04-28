package kopo.poly.service.impl;

import kopo.poly.dto.UserDTO;
import kopo.poly.mapper.ILoginMapper;

import kopo.poly.service.ILoginService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Slf4j
@Service
public class LoginService implements ILoginService {
    @Autowired
    private ILoginMapper userMapper;

    @Override
    public UserDTO login(Map<String, String> map) throws Exception {
        log.info(this.getClass().getName()+".login start");
        log.info(String.valueOf(map));

        return userMapper.login(map);
    }
}
