package kopo.poly.controller;

import kopo.poly.dto.CertificationDTO;
import kopo.poly.dto.CourseDTO;
import kopo.poly.service.impl.CourseService;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
public class CourseController {

    @Autowired
    private CourseService courseService;

    @GetMapping(value = "course/index")
    public String courseIndex(Model model) throws Exception {
        List<CourseDTO> rList = courseService.getCourse();
        List<CertificationDTO> cList = courseService.getCertification();
        model.addAttribute("rList", rList);
        model.addAttribute("cList", cList);
        return "course/indexPage";
    }

    @GetMapping(value = "course/courseDetail")
    public String courseDetail(HttpServletRequest request, Model model) throws Exception {

        String coursename = CmmUtil.nvl(request.getParameter("coursename"));
        log.info(coursename);
        CourseDTO pDTO = new CourseDTO();
        pDTO.setCourseName(coursename);
        CourseDTO rDTO = courseService.getCourseByName(coursename);
        model.addAttribute("rDTO", rDTO);

        return "/course/courseDetail";
    }

    @GetMapping(value = "course/certificateDetail")
    public String certificationDetail(HttpServletRequest request, Model model) throws Exception {

        String checkPoint = CmmUtil.nvl(request.getParameter("checkPoint"));
        log.info(checkPoint);
        CertificationDTO rDTO = courseService.getCertificationByName(checkPoint);
        model.addAttribute("rDTO", rDTO);
        return "/course/certificationDetail";
    }
    /*
    @GetMapping(value = "mongoTest")
    @ResponseBody
    public List<CertificationDTO> mongoTest() throws Exception {

        return courseService.getCertification();
    }
    */
}
