package kopo.poly.mapper.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import kopo.poly.dto.CertificationDTO;
import kopo.poly.dto.CourseDTO;
import kopo.poly.mapper.ICourseMapper;
import kopo.poly.util.AbstractMongoDBComon;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.bson.Document;
import org.springframework.stereotype.Component;

import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Slf4j
@Component("CourseMapper")
public class CourseMapper extends AbstractMongoDBComon implements ICourseMapper {

    @Override
    public List<CourseDTO> getCourse(String colNm) throws Exception {
        log.info(this.getClass().getName() + ".getCourse Start!");

        // 조회 결과를 전달하기 위한 객체 생성하기
        List<CourseDTO> rList = new LinkedList<>();

        MongoCollection<Document> col = mongodb.getCollection(colNm);

        // 조회 결과 중 출력할 컬럼들(SQL의 SELECT절과 FROM절 가운데 컬럼들과 유사함)
        Document projection = new Document();
        projection.append("코스구분명", "$코스구분명");
        projection.append("코스명", "$코스명");
        // MongoDB는 무조건 ObjectId가 자동생성되며, ObjectID는 사용하지 않을때, 조회할 필요가 없음
        // ObjectId를 가지고 오지 않을 때 사용함
        projection.append("_id", 0);

        // MongoDB의 find 명령어를 통해 조회할 경우 사용함
        // 조회하는 데이터의 양이 적은 경우, find를 사용하고, 데이터양이 많은 경우 무조건 Aggregate 사용한다.
        FindIterable<Document> rs = col.find(new Document()).projection(projection);

        for (Document doc : rs) {
            if (doc == null) {
                doc = new Document();

            }

            // 조회 잘되나 출력해 봄
            String courseDiv = CmmUtil.nvl(doc.getString("코스구분명"));
            String courseName = CmmUtil.nvl(doc.getString("코스명"));

            /*
            log.info("코스구분명 : " + courseDiv);
            log.info("코스명 : " + courseName);
            */

            CourseDTO rDTO = new CourseDTO();

            rDTO.setCourseDiv(courseDiv);
            rDTO.setCourseName(courseName);

            // 레코드 결과를 List에 저장하기
            rList.add(rDTO);

        }
        log.info(this.getClass().getName() + ".getCourse End!");

        return rList;
    }

    @Override
    public List<CertificationDTO> getCertification(String colNm) throws Exception {
        log.info(this.getClass().getName() + ".getCourse Start!");

        // 조회 결과를 전달하기 위한 객체 생성하기
        List<CertificationDTO> rList = new LinkedList<>();

        MongoCollection<Document> col = mongodb.getCollection(colNm);

        // 조회 결과 중 출력할 컬럼들(SQL의 SELECT절과 FROM절 가운데 컬럼들과 유사함)
        Document projection = new Document();
        projection.append("구간명", "$구간명");
        projection.append("문화관명", "$문화관명");
        // MongoDB는 무조건 ObjectId가 자동생성되며, ObjectID는 사용하지 않을때, 조회할 필요가 없음
        // ObjectId를 가지고 오지 않을 때 사용함
        projection.append("_id", 0);

        // MongoDB의 find 명령어를 통해 조회할 경우 사용함
        // 조회하는 데이터의 양이 적은 경우, find를 사용하고, 데이터양이 많은 경우 무조건 Aggregate 사용한다.
        FindIterable<Document> rs = col.find(new Document()).projection(projection);

        for (Document doc : rs) {
            if (doc == null) {
                doc = new Document();

            }

            // 조회 잘되나 출력해 봄
            String courseName = CmmUtil.nvl(doc.getString("구간명"));
            String checkPoint = CmmUtil.nvl(doc.getString("문화관명"));


            log.info("구간명 : " + courseName);
            log.info("문화관명 : " + checkPoint);


            CertificationDTO rDTO = new CertificationDTO();

            rDTO.setCourseName(courseName);
            rDTO.setCheckPoint(checkPoint);

            // 레코드 결과를 List에 저장하기
            rList.add(rDTO);

        }
        log.info(this.getClass().getName() + ".getCourse End!");

        return rList;
    }

    @Override
    public CourseDTO getIntroByName(String colNm, String pName) throws Exception {
        log.info(this.getClass().getName() + ".getIntroByName");
        log.info("pName : " + pName);
        List<CourseDTO> rList = new LinkedList<>();
        MongoCollection<Document> col = mongodb.getCollection(colNm);

        // 조회 결과 중 출력할 컬럼들(SQL의 SELECT절과 FROM절 가운데 컬럼들과 유사함)
        Document projection = new Document();
        projection.append("코스구분명", "$코스구분명");
        projection.append("코스명", "$코스명");
        projection.append("출발점", "$출발점");
        projection.append("도착점", "$도착점");
        projection.append("소요시간", "$소요시간");
        projection.append("소요분", "$소요분");
        projection.append("소개", "$소개");

        // MongoDB는 무조건 ObjectId가 자동생성되며, ObjectID는 사용하지 않을때, 조회할 필요가 없음
        // ObjectId를 가지고 오지 않을 때 사용함
        projection.append("_id", 0);

        // MongoDB의 find 명령어를 통해 조회할 경우 사용함
        // 조회하는 데이터의 양이 적은 경우, find를 사용하고, 데이터양이 많은 경우 무조건 Aggregate 사용한다.
        FindIterable<Document> rs = col.find(new Document()).projection(projection);

        CourseDTO rDTO = new CourseDTO();

        for (Document doc : rs) {
            if (doc == null) {
                doc = new Document();

            }
            // 조회 잘되나 출력해 봄

            String courseName = CmmUtil.nvl(doc.getString("코스명"));
            if (courseName.equals(pName)) {
            /*
            log.info("코스구분명 : " + courseDiv);
            log.info("코스명 : " + courseName);
            */
                String courseDiv = CmmUtil.nvl(doc.getString("코스구분명"));
                String startPoint = CmmUtil.nvl(doc.getString("출발점"));
                String endPoint = CmmUtil.nvl(doc.getString("도착점"));
                String timeHour = CmmUtil.nvl(doc.getString("소요시간"));
                String timeMinute = CmmUtil.nvl(doc.getString("소요분"));
                String intro = CmmUtil.nvl(doc.getString("소개"));

                rDTO.setCourseDiv(courseDiv);
                rDTO.setCourseName(courseName);
                rDTO.setStartPoint(startPoint);
                rDTO.setEndPoint(endPoint);
                rDTO.setTimeHour(timeHour);
                rDTO.setTimeMinute(timeMinute);
                rDTO.setCourseIntro(intro);

                // 레코드 결과를 List에 저장하기
                log.info(this.getClass().getName() + ".getCourse End!");
                return rDTO;

            }


        }
        return rDTO;
    }

    @Override
    public CertificationDTO getCertificationByChk(String colNm, String pName) throws Exception {
        log.info(this.getClass().getName() + ".getCertificationByChk");
        log.info("pName : " + pName);
        List<CertificationDTO> rList = new LinkedList<>();
        MongoCollection<Document> col = mongodb.getCollection(colNm);

        // 조회 결과 중 출력할 컬럼들(SQL의 SELECT절과 FROM절 가운데 컬럼들과 유사함)
        Document projection = new Document();
        projection.append("구간명", "$구간명");
        projection.append("문화관명", "$문화관명");
        projection.append("주소", "$주소");
        projection.append("주요시설", "$주요시설");
        projection.append("전화번호", "$전화번호");
        projection.append("운영시간", "$운영시간");

        // MongoDB는 무조건 ObjectId가 자동생성되며, ObjectID는 사용하지 않을때, 조회할 필요가 없음
        // ObjectId를 가지고 오지 않을 때 사용함
        projection.append("_id", 0);

        // MongoDB의 find 명령어를 통해 조회할 경우 사용함
        // 조회하는 데이터의 양이 적은 경우, find를 사용하고, 데이터양이 많은 경우 무조건 Aggregate 사용한다.
        FindIterable<Document> rs = col.find(new Document()).projection(projection);

        CertificationDTO rDTO = new CertificationDTO();

        for (Document doc : rs) {
            if (doc == null) {
                doc = new Document();

            }
            // 조회 잘되나 출력해 봄

            String checkPoint = CmmUtil.nvl(doc.getString("문화관명"));
            if (checkPoint.equals(pName)) {
            /*
            log.info("코스구분명 : " + courseDiv);
            log.info("코스명 : " + courseName);
            */
                String courseName = CmmUtil.nvl(doc.getString("구간명"));
                String address = CmmUtil.nvl(doc.getString("주소"));
                String facility = CmmUtil.nvl(doc.getString("주요시설"));
                String phoneNum = CmmUtil.nvl(doc.getString("전화번호"));
                String operateTime = CmmUtil.nvl(doc.getString("운영시간"));

                rDTO.setCourseName(courseName);
                rDTO.setCheckPoint(checkPoint);
                rDTO.setAddress(address);
                rDTO.setAutoCkeck(facility);
                rDTO.setPhoneNum(phoneNum);
                rDTO.setOperateTime(operateTime);

                // 레코드 결과를 List에 저장하기
                log.info(this.getClass().getName() + ".getCertificationByChk End!");
                return rDTO;

            }

        }
        return rDTO;
    }

    @Override
    public int deleteCourse(String pColNm, String pCourse) throws Exception {
        log.info(this.getClass().getName() + "deleteCourse start!");

        int res = 0;

        MongoCollection<Document> col = mongodb.getCollection(pColNm);

        log.info("pColNm : "+ pColNm);

        Document query = new Document();
        query.append("코스명", pCourse);

        FindIterable<Document> rs = col.find(query);

        rs.forEach(document -> col.deleteOne(document));

        res = 1;

        log.info(this.getClass().getName() + ".deleteCourse end!");

        return res;
    }

    @Override
    public int deleteCertification(String pColNm, String pCertificate) throws Exception {
        log.info(this.getClass().getName() + "deleteCertification start!");

        int res = 0;

        MongoCollection<Document> col = mongodb.getCollection(pColNm);

        log.info("pColNm : "+ pColNm);

        Document query = new Document();
        query.append("문화관명", pCertificate);

        FindIterable<Document> rs = col.find(query);

        rs.forEach(document -> col.deleteOne(document));

        res = 1;

        log.info(this.getClass().getName() + ".deleteCertification end!");

        return res;
    }

    @Override
    public void insertCertificate(CertificationDTO pDTO, String colNm) throws Exception {
        log.info(this.getClass().getName() + ".insertCertificate Start!");

        int res = 0;

        if (pDTO == null) {
            pDTO = new CertificationDTO();
        }

        Map<String, String> pMap = new LinkedHashMap<>();
        pMap.put("구간명",pDTO.getCourseName());
        pMap.put("문화관명",pDTO.getCheckPoint());
        pMap.put("주소",pDTO.getAddress());
        pMap.put("전화번호",pDTO.getPhoneNum());
        pMap.put("운영시간",pDTO.getOperateTime());
        pMap.put("주요시설",pDTO.getAutoCkeck());

        // 저장할 컬렉션 객체 생성
        MongoCollection<Document> col = mongodb.getCollection(colNm);

        // 레코드 한개씩 저장하기
        col.insertOne(new Document(new ObjectMapper().convertValue(pMap, Map.class)));

        res = 1;

        log.info(this.getClass().getName() + ".insertCertificate End!");

    }

    @Override
    public void insertCourse(CourseDTO pDTO, String colNm) throws Exception {
        log.info(this.getClass().getName() + ".insertCourse Start!");

        int res = 0;

        if (pDTO == null) {
            pDTO = new CourseDTO();
        }
        Map<String, String> pMap = new LinkedHashMap<>();
        pMap.put("코스구분명",pDTO.getCourseDiv());
        pMap.put("코스명",pDTO.getCourseName());
        pMap.put("출발점",pDTO.getStartPoint());
        pMap.put("도착점",pDTO.getEndPoint());
        pMap.put("소요시간",pDTO.getTimeHour());
        pMap.put("소요분",pDTO.getTimeMinute());
        pMap.put("소개",pDTO.getCourseIntro());


        // 저장할 컬렉션 객체 생성
        MongoCollection<Document> col = mongodb.getCollection(colNm);

            // 레코드 한개씩 저장하기
        col.insertOne(new Document(new ObjectMapper().convertValue(pMap, Map.class)));

        res = 1;

        log.info(this.getClass().getName() + ".insertCourse End!");

    }

}
