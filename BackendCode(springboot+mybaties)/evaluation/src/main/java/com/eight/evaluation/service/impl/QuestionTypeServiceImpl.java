package com.eight.evaluation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.eight.evaluation.entity.QuestionType;
import com.eight.evaluation.service.QuestionTypeService;
import com.eight.evaluation.mapper.QuestionTypeMapper;
import org.springframework.stereotype.Service;

/**
* @author lenovo
* @description 针对表【question_type(存放所有题目的知识点类型)】的数据库操作Service实现
* @createDate 2024-10-29 14:47:30
*/
@Service
public class QuestionTypeServiceImpl extends ServiceImpl<QuestionTypeMapper, QuestionType>
    implements QuestionTypeService{

}




