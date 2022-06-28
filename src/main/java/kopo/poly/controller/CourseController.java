package kopo.poly.controller;

import kopo.poly.dto.CertificationDTO;
import kopo.poly.dto.CourseDTO;
import kopo.poly.dto.ImageDTO;
import kopo.poly.service.impl.CourseService;
import kopo.poly.service.impl.ImageService;
import kopo.poly.service.impl.S3Service;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Slf4j
@Controller
public class CourseController {

    @Autowired
    private CourseService courseService;

    @Autowired
    private S3Service s3Service;

    @Autowired
    private ImageService imageService;

    @GetMapping(value = "/course/index")
    public String courseIndex(Model model) throws Exception {
        List<CourseDTO> rList = courseService.getCourse();
        List<CertificationDTO> cList = courseService.getCertification();
        model.addAttribute("rList", rList);
        model.addAttribute("cList", cList);
        return "course/indexPage";
    }

    @GetMapping(value = "/course/courseDetail")
    public String courseDetail(HttpServletRequest request, Model model) throws Exception {
        String coursename = CmmUtil.nvl(request.getParameter("coursename"));
        log.info(coursename);
        CourseDTO pDTO = new CourseDTO();
        pDTO.setCourseName(coursename);
        ImageDTO iDTO = new ImageDTO();
        iDTO.setCoursename(coursename);
        CourseDTO rDTO = courseService.getCourseByName(coursename);
        ImageDTO mDTO = imageService.getImg(iDTO);
        model.addAttribute("rDTO", rDTO);
        model.addAttribute("iDTO",mDTO);
        return "/course/courseDetail";
    }

    @GetMapping(value = "/course/deleteCourse")
    public String deleteCourse(HttpServletRequest request, Model model) throws Exception {
        String coursename = CmmUtil.nvl(request.getParameter("coursename"));
        log.info(coursename);
        CourseDTO pDTO = new CourseDTO();
        pDTO.setCourseName(coursename);
        ImageDTO iDTO = new ImageDTO();
        iDTO.setCoursename(coursename);
        courseService.deleteCourse(coursename);
        model.addAttribute("msg", "인증소 삭제가 완료되었습니다.");
        return "/course/MsgToIndex";
    }

    @GetMapping(value = "/course/certificateDetail")
    public String certificationDetail(HttpServletRequest request, Model model) throws Exception {

        String checkPoint = CmmUtil.nvl(request.getParameter("checkPoint"));
        log.info(checkPoint);
        CertificationDTO rDTO = courseService.getCertificationByName(checkPoint);
        model.addAttribute("rDTO", rDTO);
        return "/course/certificationDetail";
    }

    @GetMapping(value = "/course/deleteCertificate")
    public String deleteCertificate(HttpServletRequest request, Model model) throws Exception {
        String checkPoint = CmmUtil.nvl(request.getParameter("checkPoint"));
        log.info(checkPoint);
        courseService.deleteCertification(checkPoint);
        model.addAttribute("msg", "인증소 삭제가 완료되었습니다.");
        return "/course/MsgToIndex";
    }

    @GetMapping(value = "/course/courseForm")
    public String courseForm(){

        return "/course/courseWrite";
    }

    @PostMapping(value = "/course/courseUpload")
    public String courseUpload(MultipartHttpServletRequest request, Model model) throws Exception {
        String courseName = request.getParameter("title");
        String courseDiv = request.getParameter("s1");
        String startPoint = request.getParameter("startPoint");
        String endPoint = request.getParameter("endPoint");
        String hour = request.getParameter("hour");
        String minute = request.getParameter("minute");
        String courseIntro = request.getParameter("courseIntro");
        if(!Objects.requireNonNull(request.getFile("file")).isEmpty()) {
            MultipartFile file = request.getFile("file");
            String imgPath = s3Service.upload(file);
            String imglink = "https://d1y3hanryj5vy8.cloudfront.net/" + imgPath;
            log.info(imglink);
            ImageDTO pDTO = new ImageDTO();
            pDTO.setCoursename(courseName);
            pDTO.setCourseimg(imglink);
            imageService.insertImg(pDTO);
        }
        CourseDTO pDTO = new CourseDTO();
        pDTO.setCourseIntro(courseIntro);
        pDTO.setCourseDiv(courseDiv);
        pDTO.setTimeHour(hour);
        pDTO.setTimeMinute(minute);
        pDTO.setEndPoint(endPoint);
        pDTO.setStartPoint(startPoint);
        pDTO.setCourseName(courseName);
        courseService.insertCourse(pDTO);

        model.addAttribute("msg",courseDiv+"가 등록되었습니다.");
        return "/course/MsgToIndex";
    }

    @GetMapping(value = "/course/certificateForm")
    public String certificateForm(){

        return "/course/certificateWrite";
    }
    @PostMapping(value = "/course/certificateUpload")
    public String certificateUpload(HttpServletRequest request, Model model) throws Exception {
        String courseName = request.getParameter("title");
        String checkPoint = request.getParameter("checkPoint");
        String address = request.getParameter("address");
        String phonenum = request.getParameter("phonenum");
        String hour = request.getParameter("hour");
        String auto = request.getParameter("auto");
        CertificationDTO pDTO = new CertificationDTO();
        pDTO.setOperateTime(hour);
        pDTO.setAddress(address);
        pDTO.setAutoCkeck(auto);
        pDTO.setCourseName(courseName);
        pDTO.setCheckPoint(checkPoint);
        pDTO.setPhoneNum(phonenum);
        courseService.insertCertificate(pDTO);
        model.addAttribute("msg","종주인증소가 등록되었습니다.");
        return "/course/MsgToIndex";
    }

}
