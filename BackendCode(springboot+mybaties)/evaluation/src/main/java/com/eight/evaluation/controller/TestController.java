package com.eight.evaluation.controller;


import com.eight.evaluation.dto.QuestionDTO;
import com.eight.evaluation.dto.QuestionDetailDTO;
import com.eight.evaluation.dto.UserAnswerDTO;
import com.eight.evaluation.entity.Result;
import com.eight.evaluation.entity.Subject;
import com.eight.evaluation.service.EverytestService;
import com.eight.evaluation.service.SubjectService;
import com.eight.evaluation.service.TestService;
import com.eight.evaluation.service.impl.QuestionChoiceServiceImpl;
import com.eight.evaluation.vo.ShowTestVO;
import com.eight.evaluation.vo.TranscriptVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@CrossOrigin
@RestController
@RequestMapping("/test")
public class TestController {


    @Autowired
    private EverytestService everytestService;


    @Autowired
    private SubjectService subjectService;


    @Autowired
    private QuestionChoiceServiceImpl questionChoiceService;


    @Autowired
    private TestService testService;

    @GetMapping("/getQuestion")
    public Result<QuestionDTO> getQuestion(@RequestParam Integer userId,
                                           @RequestParam Integer subjectId){
        return Result.success(questionChoiceService.getQuestions(userId,subjectId));
    }
    @GetMapping("/getquestion")
    public Result<QuestionDetailDTO> getquestion(@RequestParam Integer testId,
                                                 @RequestParam Integer questionNo){
        QuestionDetailDTO questionDetailDTO = questionChoiceService.getQuestionDetail(testId,questionNo);

        if(questionDetailDTO==null||questionDetailDTO.equals("")){
            return Result.error("所查信息不存在");
        }
        return Result.success(questionDetailDTO);
    }
    /**
     * 用户提交答案
     * @param userAnswerDTO
     * @return
     */
    @PostMapping(value = "/submitAnswer")
    public Result<String> SubmitAnswer(@RequestBody UserAnswerDTO userAnswerDTO) {
        everytestService.submitUserAnswer(userAnswerDTO);
        return Result.success(null);

    }

    /**
     * 展示用户需要查看的题目集
     */
    @GetMapping("/chooseSubject")
    public Result<List<Subject>> returnUserSubject(@RequestParam("userId") int userId) {
        List<Subject> subject = subjectService.selectAllSubject(userId);
        return Result.success(subject);
    }

    /**
     * 展示某一次测试的成绩单（测试完后的成绩单也用这个）
     * @param testId
     * @return
     */
    @GetMapping("/showtranscript")
    public Result<TranscriptVO> showTranscript(@RequestParam("testId") int testId) {
        TranscriptVO transcriptVO = everytestService.getTranscript(testId);
        return Result.success(transcriptVO);
    }

    /**
     * 展示用户在某一题目集的所有记录
     * @param userId
     * @param subjectId
     * @return
     */


    @GetMapping("/showAllTest")
    public Result<List<ShowTestVO>> showAllTest(@RequestParam("userId") Integer userId,
                                          @RequestParam("subjectId") Integer subjectId){
        List<ShowTestVO> list = testService.showTest(userId,subjectId);
        return Result.success(list);
    }
}
