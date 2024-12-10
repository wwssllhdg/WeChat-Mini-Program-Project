package com.eight.evaluation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.eight.evaluation.entity.UserInformation;
import com.eight.evaluation.service.UserInformationService;
import com.eight.evaluation.mapper.UserInformationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
* @author lenovo
* @description 针对表【user_information(存放用户基本信息)】的数据库操作Service实现
* @createDate 2024-10-29 14:47:30
*/
@Service
public class UserInformationServiceImpl extends ServiceImpl<UserInformationMapper, UserInformation>
    implements UserInformationService{


    @Autowired
    private UserInformationMapper userInformationMapper;


    @Override
    public void updateByUserId(UserInformation userInformation) {
        userInformationMapper.updateByUserId(userInformation);
    }


}




