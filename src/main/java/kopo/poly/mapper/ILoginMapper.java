package kopo.poly.mapper;

import kopo.poly.dto.UserDTO;
import org.apache.ibatis.annotations.Mapper;


import java.util.Map;

@Mapper
public interface ILoginMapper {

    UserDTO login(Map<String, String> map);
}
