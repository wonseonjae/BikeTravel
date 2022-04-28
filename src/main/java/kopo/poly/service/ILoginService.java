package kopo.poly.service;

import kopo.poly.dto.UserDTO;

import java.util.Map;

public interface ILoginService {

    UserDTO login(Map<String, String > map) throws Exception;
}
