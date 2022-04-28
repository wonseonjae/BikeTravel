package kopo.poly.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardDTO {
    private int board_no;
    private String coursename;
    private String title;
    private String contents;
    private String imglink;
    private String regdate;
    private int user_no;
    private String user_name;
}
