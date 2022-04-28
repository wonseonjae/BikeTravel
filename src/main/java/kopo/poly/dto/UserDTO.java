package kopo.poly.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDTO{
    private int user_no;
    private String user_id;
    private String user_pw;
    private String user_name;
    private String user_mailid;
    private String user_maildomain;
    private String regdate;
    private String authority;
    private String uses_exists;
}