package com.eight.evaluation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.eight.evaluation.dto.*;
import com.eight.evaluation.entity.QuestionChoice;
import com.eight.evaluation.entity.Test;
import com.eight.evaluation.dto.QuestionDTO;
import com.eight.evaluation.mapper.TestMapper;
import com.eight.evaluation.service.QuestionChoiceService;
import com.eight.evaluation.mapper.QuestionChoiceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

/**
* @author lenovo
* @description 针对表【question_choice(存放所有选择题)】的数据库操作Service实现
* @createDate 2024-10-29 14:47:30
*/
@Service
public class QuestionChoiceServiceImpl extends ServiceImpl<QuestionChoiceMapper, QuestionChoice>
    implements QuestionChoiceService {

    @Autowired
    private QuestionChoiceMapper questionChoiceMapper;

    @Autowired
    private TestMapper testMapper;
    public QuestionDTO getQuestions(Integer userId, Integer subjectId) {
        QuestionDTO questionDTO = new QuestionDTO();
        LocalDateTime now = LocalDateTime.now();
        Timestamp timestamp = Timestamp.valueOf(now);
        Test test=new Test();
        test.setTestTime(timestamp);
        test.setTestSubjectId(subjectId);
        test.setTestUserId(userId);
        test.setTestScore(0);
        //System.out.println(test);
        testMapper.insert(test);
        //questionChoiceMapper.insertaTest(test);
//        System.out.println(update);
//        System.out.println(test);
        questionDTO.setTestId(test.getTestId());
        Integer rank=questionChoiceMapper.getUserlevel(userId,subjectId);
        List<Integer> chapters=questionChoiceMapper.getChapters(subjectId);
        Collections.shuffle(chapters, new Random());
        List<Integer> selectedChapters = chapters.subList(0, 5);
        List<QuestionChoiceDTO> questionChoices1= new ArrayList<>();
        List<QuestionChoiceDTO> questionChoices2= new ArrayList<>();
        int num=1;
        List<SelectedQuestion> selectedQuestions = new ArrayList<>();
        for (Integer  chapter: selectedChapters){
            if(rank<=1){
                questionChoices1=questionChoiceMapper.getTrueorFalseQuestions(subjectId, chapter,1);
                questionChoices2=questionChoiceMapper.getQuestions(subjectId,chapter,1);
            } else if (rank<=3) {
                questionChoices1=questionChoiceMapper.getTrueorFalseQuestions(subjectId,chapter,2);
                questionChoices2=questionChoiceMapper.getQuestions(subjectId,chapter,2);
            }
            else {
                questionChoices1=questionChoiceMapper.getTrueorFalseQuestions(subjectId,chapter,3);
                questionChoices2=questionChoiceMapper.getQuestions(subjectId,chapter,3);
            }
            Collections.shuffle(questionChoices1, new Random());
            Collections.shuffle(questionChoices2, new Random());
//            System.out.println(questionChoices1);
//            System.out.println(questionChoices2);
            SelectedQuestion  selectedQuestion= new SelectedQuestion();
            selectedQuestion.setEverytestNo(num);
            selectedQuestion.setEverytestType(0);
            selectedQuestion.setQuestionName(questionChoices1.get(0).getQuestionChoice().getQuestionName());
            questionChoiceMapper.insertaEveryTest(test.getTestId(),num,questionChoices1.get(0).getQuestionChoice().getQuestionId(),0);
            selectedQuestions.add(selectedQuestion);
            //System.out.println(selectedQuestion);
            num++;
            SelectedQuestion  selectedQuestion2= new SelectedQuestion();
            selectedQuestion2.setEverytestNo(num);
            selectedQuestion2.setEverytestType(1);
            selectedQuestion2.setQuestionName(questionChoices2.get(0).getQuestionChoice().getQuestionName());
            selectedQuestion2.setQuestionChoiceA(questionChoices2.get(0).getQuestionChoice().getQuestionChoiceA());
            selectedQuestion2.setQuestionChoiceB(questionChoices2.get(0).getQuestionChoice().getQuestionChoiceB());
            selectedQuestion2.setQuestionChoiceC(questionChoices2.get(0).getQuestionChoice().getQuestionChoiceC());
            selectedQuestion2.setQuestionChoiceD(questionChoices2.get(0).getQuestionChoice().getQuestionChoiceD());
            questionChoiceMapper.insertaEveryTest(test.getTestId(),num,questionChoices2.get(0).getQuestionChoice().getQuestionId(),1);
            selectedQuestions.add(selectedQuestion2);
            num++;


        }
        questionDTO.setSelectedQuestions(selectedQuestions);
        return questionDTO;
    }

    public QuestionDetailDTO getQuestionDetail(Integer testId, Integer questionNo) {
        QuestionDetailDTO questionDetailDTO = new QuestionDetailDTO();
        if(questionNo>10||questionNo<1){
            throw new RuntimeException("题号越界，请重试");
        }
        if(questionNo % 2 == 0){//查找的是选择题
            questionDetailDTO=questionChoiceMapper.getChosenQuestioninDetail(testId,questionNo);
        } else {
            questionDetailDTO = questionChoiceMapper.getTrueorFalseQuestioninDetail(testId, questionNo);
        }

        return questionDetailDTO;
    }
}




