package com.eight.evaluation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.eight.evaluation.service.UserLoginService;
import com.eight.evaluation.entity.UserLogin;
import com.eight.evaluation.mapper.UserLoginMapper;
import org.springframework.stereotype.Service;

/**
* @author lenovo
* @description 针对表【user_login(存放用户登录信息)】的数据库操作Service实现
* @createDate 2024-10-29 14:47:30
*/
@Service
public class UserLoginServiceImpl extends ServiceImpl<UserLoginMapper, UserLogin>
    implements UserLoginService {

}




