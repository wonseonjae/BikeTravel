package kopo.poly.service.impl;

import kopo.poly.dto.BikeCertificateDTO;
import kopo.poly.dto.BikeDistanceDTO;
import kopo.poly.dto.CourseReviewDTO;
import kopo.poly.mapper.IBikeMapper;
import kopo.poly.service.IBIkeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

@Slf4j
@Service
public class BikeService implements IBIkeService {

    @Autowired
    private IBikeMapper bikeMapper;


    public void insertCertificate(BikeCertificateDTO pDTO) throws Exception {
        bikeMapper.regCertificate(pDTO);

    }
    public List<BikeCertificateDTO> selectCertificate(BikeCertificateDTO pDTO) throws Exception {
        return bikeMapper.getCertificate(pDTO);
    }

    @Override
    public void insertReview(CourseReviewDTO pDTO) throws Exception {
        bikeMapper.insertReview(pDTO);
    }

    @Override
    public List<CourseReviewDTO> selectReview(CourseReviewDTO pDTO) throws Exception {
        return bikeMapper.selectReview(pDTO);
    }

    @Override
    public void updateReview(CourseReviewDTO pDTO) throws Exception {
        bikeMapper.updateReview(pDTO);

    }

    @Override
    public void deleteReview(CourseReviewDTO pDTO) throws Exception {
        bikeMapper.deleteReview(pDTO);

    }

    @Override
    public void insertDistance(BikeDistanceDTO pDTO) throws Exception {
        bikeMapper.insertDistance(pDTO);
    }

    @Override
    public List<BikeDistanceDTO> selectDistance(BikeDistanceDTO pDTO) throws Exception {
        return bikeMapper.selectDistance(pDTO);
    }
}
