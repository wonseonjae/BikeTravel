package kopo.poly.dto;


import lombok.Getter;
import lombok.Setter;

//동호회 목록
@Getter
@Setter
public class ClubListDTO {
    private int club_no;
    private String club_name;
    private String club_intro;
    private String club_president;
    private int president_num;
    private String regdate;
    private String clubrange;
    private String president_phonenum;
    private String imgLink;
    private int memberCnt;
    private String name_exists;
}
