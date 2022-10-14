package kopo.poly.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BikeRentalDTO {
    //대여소 이름
    private String bcyclLendNm;
    //유인, 무인
    private String bcyclLendSe;
    //대여소 도로명 주소
    private String rdnmadr;
    //대여소 지번 주소
    private String lnmadr;
    //대여소 x좌표
    private String latitude;
    //대여소 y좌표
    private String longitude;
    //오픈시간
    private String operOpenHm;
    //닫는 시간
    private String operCloseHm;
    //연휴일
    private String rstde;
    //금액
    private String bcyclUseCharge;
    //전화번호
    private String phoneNumber;
}
