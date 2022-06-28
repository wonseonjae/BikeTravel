package kopo.poly.mapper;

import kopo.poly.dto.CertificationDTO;
import kopo.poly.dto.CourseDTO;
import kopo.poly.dto.ImageDTO;

import java.util.List;

public interface ICourseMapper {

    List<CourseDTO> getCourse(String colNm) throws Exception;

    List<CertificationDTO> getCertification(String colNm) throws Exception;

    CourseDTO getIntroByName(String colNm, String pName) throws Exception;

    CertificationDTO getCertificationByChk(String colNm, String pName) throws Exception;

    int deleteCourse(String pColNm, String pSinger) throws Exception;

    int deleteCertification(String pColNm, String pSinger) throws Exception;

    int insertCourse(CourseDTO pDTO, String colNm) throws Exception;

    int insertCertificate(CertificationDTO pDTO, String colNm) throws Exception;
}
