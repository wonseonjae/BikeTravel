package kopo.poly.service.impl;

import kopo.poly.dto.ImageDTO;
import kopo.poly.mapper.IClubMapper;
import kopo.poly.mapper.IimageMapper;
import kopo.poly.service.IimageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service(value = "ImageService")
public class ImageService implements IimageService {

    @Autowired
    private IimageMapper imageMapper;

    @Override
    public ImageDTO getImg(ImageDTO pDTO) throws Exception {
        return imageMapper.getImg(pDTO);
    }

    @Override
    public int insertImg(ImageDTO pDTO) throws Exception {
        return imageMapper.insertImg(pDTO);
    }

    @Override
    public int deleteImg(ImageDTO pDTO) throws Exception {
        return deleteImg(pDTO);
    }
}
