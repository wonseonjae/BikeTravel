package kopo.poly.dto;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BikeDistanceDTO {
    private int reg_no;
    private String startdate;
    private String enddate;
    private int distance;
    private int user_no;
}
