package kopo.poly.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CourseReviewDTO {
    private int distance_no;
    private int user_no;
    private String text;
    private long starpoint;
    private String reg_dt;
    private String course_name;
    private String user_name;
}
