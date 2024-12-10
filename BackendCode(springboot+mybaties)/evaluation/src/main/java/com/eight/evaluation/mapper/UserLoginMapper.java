package com.eight.evaluation.mapper;

import com.eight.evaluation.entity.UserLogin;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
* @author lenovo
* @description 针对表【user_login(存放用户登录信息)】的数据库操作Mapper
* @createDate 2024-10-29 14:47:30
* @Entity generator.entity.UserLogin
*/
@Mapper
public interface UserLoginMapper extends BaseMapper<UserLogin> {

    @Select("select * from user_login where user_phone = #{user_phone}")
    public UserLogin selectPasswordByPhone(String user_phone);
    @Insert("insert into user_login(user_phone,user_password) values(#{userPhone},#{userPassword})")
    public int insertUser(String userPhone,String userPassword);
    @Insert("insert into user_information (user_id, user_nickname, user_sex,user_logo) values (#{userId}, #{nickname}, 1,'http://106.54.212.158:8888/images/user/0.png')")
    public int insertUserInformation(int userId,String nickname);

}




