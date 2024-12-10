package com.eight.evaluation.service;

import com.eight.evaluation.entity.Subject;
import com.baomidou.mybatisplus.extension.service.IService;
import com.eight.evaluation.vo.SubjectVO;

import java.util.List;
/**
* @author lenovo
* @description 针对表【subject(题目集)】的数据库操作Service
* @createDate 2024-10-29 14:47:30
*/
public interface SubjectService extends IService<Subject> {

    List<Subject> selectAllSubject(int userId);


    List<Subject> findSubjects();//返回题目集列表

    SubjectVO chooseSubject(int subjectId, int userId);//返回特定的题目集
}
