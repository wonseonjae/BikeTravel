package kopo.poly.dto;


import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

@JsonInclude(JsonInclude.Include.NON_DEFAULT)
@Getter
@Setter
public class CertificationDTO {
    private String certificationNo;
    private String courseName;
    private String checkPoint;
    private String address;
    private String autoCkeck;
    private String phoneNum;
    private String operateTime;

}
