package kopo.poly.service;

import kopo.poly.dto.ImageDTO;

public interface IimageService {
    ImageDTO getImg(ImageDTO pDTO) throws Exception;

    int insertImg(ImageDTO pDTO) throws Exception;

    int deleteImg(ImageDTO pDTO) throws Exception;
}
