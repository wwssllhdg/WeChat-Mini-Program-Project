package com.eight.evaluation.service;

import com.eight.evaluation.dto.UserAnswerDTO;
import com.eight.evaluation.entity.Everytest;
import com.baomidou.mybatisplus.extension.service.IService;
import com.eight.evaluation.entity.Result;
import com.eight.evaluation.vo.TranscriptVO;

/**
* @author lenovo
* @description 针对表【everytest(存放每次具体测题目索引和用户答案)】的数据库操作Service
* @createDate 2024-10-29 14:47:30
*/
public interface EverytestService extends IService<Everytest> {

     void submitUserAnswer(UserAnswerDTO userAnswerDTO);

    TranscriptVO getTranscript(int testId);
}
