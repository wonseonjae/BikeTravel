package kopo.poly.mapper;

import kopo.poly.dto.ImageDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IimageMapper {
    ImageDTO getImg(ImageDTO pDTO) throws Exception;

    int insertImg(ImageDTO pDTO) throws Exception;

    int deleteImg(ImageDTO pDTO) throws Exception;
}
