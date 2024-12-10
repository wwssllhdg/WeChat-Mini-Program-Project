package com.eight.evaluation.service;

import com.eight.evaluation.entity.UserInformation;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author lenovo
* @description 针对表【user_information(存放用户基本信息)】的数据库操作Service
* @createDate 2024-10-29 14:47:30
*/
public interface UserInformationService extends IService<UserInformation> {

    void updateByUserId(UserInformation userInformation);


}
