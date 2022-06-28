package kopo.poly.service;

import kopo.poly.dto.CertificationDTO;
import kopo.poly.dto.CourseDTO;
import kopo.poly.dto.ImageDTO;

import java.util.List;

public interface ICourseService {
    List<CourseDTO> getCourse() throws Exception;

    List<CertificationDTO> getCertification() throws Exception;

    CourseDTO getCourseByName(String pName) throws Exception;

    CertificationDTO getCertificationByName(String pName) throws Exception;

    int deleteCourse(String pSinger) throws Exception;

    int deleteCertification(String pSinger) throws Exception;

    int insertCourse(CourseDTO pDTO) throws Exception;

    int insertCertificate(CertificationDTO pDTO) throws Exception;

}
