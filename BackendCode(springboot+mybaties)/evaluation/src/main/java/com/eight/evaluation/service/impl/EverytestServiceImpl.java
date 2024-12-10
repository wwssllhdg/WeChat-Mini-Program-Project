package com.eight.evaluation.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.eight.evaluation.dto.QuestionDTO1;
import com.eight.evaluation.dto.Result1;
import com.eight.evaluation.dto.UserAnswerDTO;
import com.eight.evaluation.entity.Everytest;
import com.eight.evaluation.entity.Test;
import com.eight.evaluation.entity.UserLevel;
import com.eight.evaluation.mapper.TestMapper;
import com.eight.evaluation.mapper.UserLevelMapper;
import com.eight.evaluation.service.EverytestService;
import com.eight.evaluation.mapper.EverytestMapper;
import com.eight.evaluation.vo.TranscriptVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Random;

import static com.eight.evaluation.constant.Question.*;

/**
 * @author lenovo
 * @description 针对表【everytest(存放每次具体测题目索引和用户答案)】的数据库操作Service实现
 * @createDate 2024-10-29 14:47:30
 */
@Service
public class EverytestServiceImpl extends ServiceImpl<EverytestMapper, Everytest>
        implements EverytestService {

    @Autowired
    private EverytestMapper everytestMapper;

    @Autowired
    private TestMapper testMapper;

    @Autowired
    private UserLevelMapper userLevelMapper;

    @Override
    public void submitUserAnswer(UserAnswerDTO userAnswerDTO) {
        int testId = userAnswerDTO.getTestId();
        List<String> answer = userAnswerDTO.getUserAnswer();
        for (int i = 1; i <= answer.size(); i++) {
            if (i % 2 == 0) {//提交检查选择题
                everytestMapper.submitUserChoiceAnswer(testId, i, answer.get(i - 1));
            } else {
                everytestMapper.submitUserJudgeAnswer(testId, i, answer.get(i - 1));
            }

        }
        //更新成绩
        int score = everytestMapper.getScore(testId) * SCORE;
        LambdaQueryWrapper<Test> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Test::getTestId, testId);
        Integer subjectId = testMapper.selectOne(wrapper).getTestSubjectId();

        Integer UserId = testMapper.selectById(testId).getTestUserId();

        LambdaQueryWrapper<UserLevel> wrapper2 = new LambdaQueryWrapper<>();
        wrapper2.eq(UserLevel::getUserId, UserId).eq(UserLevel::getSubjectId, subjectId);
        Integer testRank = userLevelMapper.selectOne(wrapper2).getUserRank();
        if (score != 0) {//用户成绩不为0
            double scoreWeight = 0.7;  // testScore 的权重（可调节）
            double rankWeight = 0.3;   // testRank 的权重（可调节）
            double baseLevel = (score / 100.0) * scoreWeight * 100 + testRank * rankWeight * 25;
            Random random = new Random();
            double randomness = random.nextDouble() * 10 - 5;
            int skillLevel = (int) Math.max(0, Math.min(100, baseLevel + randomness));
            everytestMapper.setScore(testId, score, skillLevel);
        } else {//用户成绩为0
            everytestMapper.setScore(testId, score, 0);
        }


        //更新用户水平
        Test test = testMapper.getUserRank(testId);
        int userId = test.getTestUserId();

        int score_avg = testMapper.getAvgScore(userId, subjectId);
        int count = testMapper.getCount(userId, subjectId);
        int level;
        if (score_avg >= 80) {
            // 高平均分的用户
            if (count >= 3) {
                level = 4; // 高测试次数 + 高平均分
            } else {
                level = 3; // 低测试次数 + 高平均分
            }
        } else if (score_avg >= 60) {
            // 中等平均分的用户
            if (count >= 3) {
                level = 3; // 高测试次数 + 中等平均分
            } else {
                level = 2; // 低测试次数 + 中等平均分
            }
        } else {
            // 低平均分的用户
            if (count >= 3) {
                level = 2; // 高测试次数 + 低平均分
            } else {
                level = 1; // 低测试次数 + 低平均分
            }
        }
        userLevelMapper.updateRank(userId, subjectId, level);
    }

    @Override
    public TranscriptVO getTranscript(int testId) {
        List<QuestionDTO1> questions = everytestMapper.selectQuestions(testId);
        Integer testScore = testMapper.getTestScore(testId);


//        double baseLevel  = (testScore / 100.0) * testRank * 25;
//        double randomness = random.nextDouble() * 10 - 5;
//        int skillLevel = (int) Math.max(0, Math.min(100, baseLevel + randomness));

//        double scoreWeight = 0.7;  // testScore 的权重（可调节）
//        double rankWeight = 0.3;   // testRank 的权重（可调节）
//        double baseLevel = (testScore / 100.0) * scoreWeight * 100 + testRank * rankWeight * 25;
//        double randomness = random.nextDouble() * 10 - 5;
//        int skillLevel = (int) Math.max(0, Math.min(100, baseLevel + randomness));
        int skillLevel = 0;
        if (testMapper.selectById(testId).getTestUserlevel() != null) {
            skillLevel = testMapper.selectById(testId).getTestUserlevel();
        }

        String s1 = "";//存放掌握较好的知识点
        String s2 = "";//存放掌握较差的知识点
        String s3 = "";//存放掌握一般的知识点

        List<Result1> list2 = everytestMapper.getResult1(testId);//记录用户错误的
        List<Result1> list = everytestMapper.getResult2(testId);//记录用户正确的
        for (int i = 0; i < 5; i++) {
            if (i < list.size()) {
                if (list.get(i).getCount() == 2) {
                    s1 = s1 + list.get(i).getTypeName() + " ";
                } else if (list.get(i).getCount() == 1) {
                    s3 = s3 + list.get(i).getTypeName() + " ";

                }
            }
            if (i < list2.size()) {
                if (list2.get(i).getCount() == 2) {
                    s2 = s2 + list2.get(i).getTypeName() + " ";
                }
            }


        }
        StringBuilder testEvaluation = new StringBuilder();

        if (s1 != null && !s1.isEmpty()) {
            testEvaluation.append("你在").append(s1).append("方面掌握较好,继续加油").append('\n');
        }
        if (s2 != null && !s2.isEmpty()) {
            testEvaluation.append("你在").append(s2).append("方面掌握较差，需重点学习");
        }


        String TestEvaluation = testEvaluation.toString();


        TranscriptVO transcriptVO = new TranscriptVO();
        transcriptVO.setQuestion(questions);
        transcriptVO.setTestScore(testScore);
        transcriptVO.setTestLevel(skillLevel);
        transcriptVO.setTestEvaluation(TestEvaluation);

        return transcriptVO;
    }

}




