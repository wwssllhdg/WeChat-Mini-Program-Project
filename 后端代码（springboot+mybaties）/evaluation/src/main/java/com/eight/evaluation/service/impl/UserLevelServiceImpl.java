package com.eight.evaluation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.eight.evaluation.entity.UserLevel;
import com.eight.evaluation.service.UserLevelService;
import com.eight.evaluation.mapper.UserLevelMapper;
import org.springframework.stereotype.Service;

/**
* @author lenovo
* @description 针对表【user_level(存放用户各个科目等级)】的数据库操作Service实现
* @createDate 2024-10-29 14:47:30
*/
@Service
public class UserLevelServiceImpl extends ServiceImpl<UserLevelMapper, UserLevel>
    implements UserLevelService{

}




