package com.eight.evaluation.controller;

import com.eight.evaluation.entity.Result;
import com.eight.evaluation.entity.Subject;
import com.eight.evaluation.service.SubjectService;
import com.eight.evaluation.vo.SubjectVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;
@CrossOrigin
@RestController
@RequestMapping("/subject")
public class SubjectController {
    @Autowired
    private SubjectService subjectService;

    @GetMapping("/showSubject")
    public Result<List<Subject>> showSubject(){
        //展示所有题目集
        List<Subject> subject = new ArrayList<>();
         subject = subjectService.findSubjects();
        if(subject == null){
            return Result.error("没有题目集");
        }else {
            return Result.success(subject);
        }
    }
    @GetMapping("/chooseSubject")
    public Result<SubjectVO> chooseSubject(int subjectId, int userId){//查询特定题目集,首页展示
        SubjectVO subject =subjectService.chooseSubject(subjectId,userId);
        if(subject == null){
            return Result.error("题目集序号不存在！");
        }else{
            return Result.success(subject);
        }
    }
}
