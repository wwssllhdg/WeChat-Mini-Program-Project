package com.eight.evaluation.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.eight.evaluation.dto.SubjectDTO;
import com.eight.evaluation.entity.Subject;
import com.eight.evaluation.entity.Test;
import com.eight.evaluation.entity.UserInformation;
import com.eight.evaluation.entity.UserLevel;
import com.eight.evaluation.mapper.TestMapper;
import com.eight.evaluation.mapper.UserInformationMapper;
import com.eight.evaluation.mapper.UserLevelMapper;
import com.eight.evaluation.service.SubjectService;
import com.eight.evaluation.mapper.SubjectMapper;
import com.eight.evaluation.vo.SubjectVO;
import org.apache.catalina.User;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
/**
* @author lenovo
* @description 针对表【subject(题目集)】的数据库操作Service实现
* @createDate 2024-10-29 14:47:30
*/
@Service
public class SubjectServiceImpl extends ServiceImpl<SubjectMapper, Subject>
    implements SubjectService{


    @Autowired
    private SubjectMapper subjectMapper;

    @Autowired
    private UserLevelMapper userLevelMapper;


    @Autowired
    private TestMapper testMapper;

    @Autowired
    private UserInformationMapper userInformationMapper;

    @Override
    public List<Subject> selectAllSubject(int userId) {
        List<Integer> list = userLevelMapper.selectUserSubjectId(userId);
        LambdaQueryWrapper<Subject> queryWrapper = new LambdaQueryWrapper();
        queryWrapper.in(Subject::getSubjectId,list);
        List<Subject> subject = subjectMapper.selectList(queryWrapper);
        return subject;
    }



    @Override
    public List<Subject> findSubjects() {//查询所有题目集

        return subjectMapper.findSubjects();
    }

    @Override
    public SubjectVO chooseSubject(int subjectId, int userId) {//查询特定的题目集
        LambdaQueryWrapper<UserInformation> queryWrapper1 = new LambdaQueryWrapper();
        queryWrapper1.eq(UserInformation::getUserId,userId);
        String userLogo = userInformationMapper.selectOne(queryWrapper1).getUserLogo();
        SubjectVO subjectVO = new SubjectVO();
        SubjectDTO subjectDTO = subjectMapper.getSubject(subjectId,userId);
        if(subjectDTO==null){
            //执行插入操作
            UserLevel userLevel = new UserLevel();
            userLevel.setUserId(userId);
            userLevel.setSubjectId(subjectId);
            userLevel.setUserRank(0);
            userLevelMapper.insert(userLevel);

            //封装返回类
            LambdaQueryWrapper<Subject> queryWrapper = new LambdaQueryWrapper();
            queryWrapper.eq(Subject::getSubjectId,subjectId);
            Subject subject = subjectMapper.selectOne(queryWrapper);

            subjectVO.setSubjectId(subjectId);
            subjectVO.setUserRank(0);
            subjectVO.setSubjectLogo(subject.getSubjectLogo());
            subjectVO.setSubjectName(subject.getSubjectName());
            subjectVO.setTestScore(-1);
            subjectVO.setUserLogo(userLogo);
            return subjectVO;
        }else{

            BeanUtils.copyProperties(subjectDTO,subjectVO);
            subjectVO.setUserLogo(userLogo);
            LambdaQueryWrapper<Test> queryWrapper = new LambdaQueryWrapper();
            queryWrapper.eq(Test::getTestSubjectId,subjectId)
                    .eq(Test::getTestUserId,userId)
                    .orderByDesc(Test::getTestTime);
            List<Test> list = testMapper.selectList(queryWrapper);
            if(list.size()==0){
                subjectVO.setTestScore(-1);
            }else{
                subjectVO.setTestScore(list.get(0).getTestScore());
            }

            return subjectVO;

        }

    }




}




