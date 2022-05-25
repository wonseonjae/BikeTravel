package kopo.poly.dto;


import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class CommentDTO {
    private int comment_no;
    private String comment_text;
    private String regdate;
    private int user_no;
    private int board_no;
    private String user_name;
    private int repCnt;
}
