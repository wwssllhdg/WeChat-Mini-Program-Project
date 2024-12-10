package com.eight.evaluation.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.eight.evaluation.entity.Test;
import com.eight.evaluation.service.TestService;
import com.eight.evaluation.mapper.TestMapper;
import com.eight.evaluation.vo.ShowTestVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
* @author lenovo
* @description 针对表【test(存放所有测试记录)】的数据库操作Service实现
* @createDate 2024-10-29 14:47:30
*/
@Service
public class TestServiceImpl extends ServiceImpl<TestMapper, Test>
    implements TestService{

    @Autowired
    private TestMapper testMapper;

    @Override
    public List<ShowTestVO> showTest(Integer userId, Integer subjectId) {
        List<ShowTestVO> showTestVOS = new ArrayList<>();
        LambdaQueryWrapper<Test> queryWrapper = new LambdaQueryWrapper<Test>();
        queryWrapper.eq(Test::getTestUserId,userId)
                .eq(Test::getTestSubjectId,subjectId);
        List<Test> tests = testMapper.selectList(queryWrapper);
        for(Test test:tests){
            ShowTestVO showTestVO = new ShowTestVO();
            showTestVO.setTestId(test.getTestId());
            showTestVO.setTestScore(test.getTestScore());
            showTestVO.setTestTime(String.valueOf(test.getTestTime()));
            showTestVOS.add(showTestVO);
        }

        return showTestVOS;
    }
}




