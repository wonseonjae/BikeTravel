package kopo.poly.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticeDTO {
    private int notice_no;
    private String title;
    private String contents;
    private String regdate;
    private String adminname;
}
