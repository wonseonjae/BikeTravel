package kopo.poly.service;

import kopo.poly.dto.UserDTO;

public interface IUserService {

    //회원가입
    void InsertUserInfo(UserDTO pDTO) throws Exception;

    //아이디 중복체크
    int idCheck(UserDTO pDTO);

    //닉네임 중복체크
    int nameCheck(UserDTO pDTO);

    //메일 중복체크
    int mailCheck(UserDTO pDTO);


}
