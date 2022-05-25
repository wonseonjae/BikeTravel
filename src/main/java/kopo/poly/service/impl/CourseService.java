package kopo.poly.service.impl;
import kopo.poly.dto.CertificationDTO;
import kopo.poly.dto.CourseDTO;
import kopo.poly.mapper.ICourseMapper;
import kopo.poly.service.ICourseService;
import kopo.poly.util.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.LinkedList;
import java.util.List;

@Slf4j
@Service
public class CourseService implements ICourseService {
    @Resource(name = "CourseMapper")
    private ICourseMapper courseMapper;

    @Override
    public List<CourseDTO> getCourse() throws Exception {
        log.info(this.getClass().getName() + ".getCourse Start!");

        String colNm = "BikeCourse";

        List<CourseDTO> rList = new LinkedList<>();

        log.info("mongodb data");
        rList = courseMapper.getCourse(colNm);


        if (rList == null) {
            rList = new LinkedList<>();
        }
        log.info(this.getClass().getName() + ".getCourse End!");

        return rList;
    }

    @Override
    public List<CertificationDTO> getCertification() throws Exception {
            log.info(this.getClass().getName() + ".getCertification Start!");

            String colNm = "BikeCertification";

            List<CertificationDTO> rList = new LinkedList<>();

            rList = courseMapper.getCertification(colNm);


            if (rList == null) {
                rList = new LinkedList<>();
            }
            log.info(this.getClass().getName() + ".getCertification End!");

            return rList;
    }

    @Override
    public CourseDTO getCourseByName(String pName) throws Exception {
        log.info(this.getClass().getName() + ".getCourse Start!");

        String colNm = "BikeCourse";

        CourseDTO rDTO = courseMapper.getIntroByName(colNm, pName);

        if (rDTO == null) {
            rDTO = new CourseDTO();
        }
        log.info(this.getClass().getName() + ".getCourse End!");

        return rDTO;
    }

    @Override
    public CertificationDTO getCertificationByName(String pName) throws Exception {

        String colNm = "BikeCertification";

        CertificationDTO rDTO = courseMapper.getCertificationByChk(colNm, pName);

        if (rDTO == null) {
            rDTO = new CertificationDTO();
        }
        return rDTO;
    }
}
