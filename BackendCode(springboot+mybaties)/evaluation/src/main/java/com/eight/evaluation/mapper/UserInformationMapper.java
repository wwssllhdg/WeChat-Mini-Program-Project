package com.eight.evaluation.mapper;

import com.eight.evaluation.entity.UserInformation;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
* @author lenovo
* @description 针对表【user_information(存放用户基本信息)】的数据库操作Mapper
* @createDate 2024-10-29 14:47:30
* @Entity generator.entity.UserInformation
*/
@Mapper
public interface UserInformationMapper extends BaseMapper<UserInformation> {

    void updateByUserId(@Param("user")UserInformation user);
}




