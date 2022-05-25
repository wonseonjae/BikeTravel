package kopo.poly.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonInclude(JsonInclude.Include.NON_DEFAULT)
public class CourseDTO {
    private String courseDiv;
    private String courseName;
    private String startPoint;
    private String endPoint;
    private String timeHour;
    private String timeMinute;
    private String courseIntro;
}
