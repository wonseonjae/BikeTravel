package kopo.poly.service;

import kopo.poly.dto.BikeCertificateDTO;
import kopo.poly.dto.BikeDistanceDTO;
import kopo.poly.dto.CourseReviewDTO;

import java.util.List;

public interface IBIkeService {
    void insertCertificate(BikeCertificateDTO pDTO) throws Exception;

    List<BikeCertificateDTO> selectCertificate(BikeCertificateDTO pDTO)throws Exception;

    // 종주코스 별점후기
    void insertReview(CourseReviewDTO pDTO) throws Exception;

    List<CourseReviewDTO> selectReview(CourseReviewDTO pDTO) throws Exception;

    void updateReview(CourseReviewDTO pDTO)throws Exception;

    void deleteReview(CourseReviewDTO pDTO) throws Exception;

    //내가 탄 자전거 거리 계산
    void insertDistance(BikeDistanceDTO pDTO) throws Exception;

    List<BikeDistanceDTO> selectDistance(BikeDistanceDTO pDTO) throws Exception;
}
