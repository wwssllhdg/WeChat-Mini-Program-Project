package com.eight.evaluation.mapper;

import com.eight.evaluation.dto.QuestionDTO1;
import com.eight.evaluation.dto.Result1;
import com.eight.evaluation.entity.Everytest;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author lenovo
* @description 针对表【everytest(存放每次具体测题目索引和用户答案)】的数据库操作Mapper
* @createDate 2024-10-29 14:47:30
* @Entity generator.entity.Everytest
*/
@Mapper
public interface EverytestMapper extends BaseMapper<Everytest> {

    void submitUserChoiceAnswer(@Param("testId") int testId, @Param("everytestNo") int everytestNo, @Param("answer") String answer);

    void submitUserJudgeAnswer(@Param("testId") int testId, @Param("everytestNo") int everytestNo, @Param("answer") String answer);

    Integer getScore(@Param("testId") int testId);

    void setScore(@Param("testId") int testId, @Param("score") int score,@Param("testUserlevel") int testUserlevel);


    List<QuestionDTO1> selectQuestions(int userId);


    List<Result1> getResult1(int testId);

    List<Result1> getResult2(int testId);
}
/*
        select everytest_no,question_name,type_name,question_type.type_id,everytest_is_correct
        from everytest,question_choice,question_type
where everytest_question_id =  question_id
and everytest_type = 1
and  question_choice.question_type_id =question_type.type_id
and everytest_test_id =  3
and everytest_is_correct = 0;

        select everytest_no,question_name,type_name,question_type.type_id,everytest_is_correct
        from everytest,question_judge,question_type
where everytest_question_id =  question_id
and everytest_type = 0
and  question_judge.question_type_id =question_type.type_id
and everytest_test_id =  3
and everytest_is_correct = 0;


SELECT
everytest.everytest_no,
CASE
WHEN everytest.everytest_type = 1 THEN question_choice.question_name
WHEN everytest.everytest_type = 0 THEN question_judge.question_name
END AS question_name,
question_type.type_id,
type_name
        FROM
everytest
LEFT JOIN
question_choice ON everytest.everytest_type = 1
AND everytest.everytest_question_id = question_choice.question_id
LEFT JOIN
question_judge ON everytest.everytest_type = 0
AND everytest.everytest_question_id = question_judge.question_id
        JOIN
question_type ON (
        (everytest.everytest_type = 1 AND question_choice.question_type_id = question_type.type_id) OR
        (everytest.everytest_type = 0 AND question_judge.question_type_id = question_type.type_id)
        )
WHERE
everytest.everytest_test_id = 3
AND everytest.everytest_is_correct = 0;



SELECT
        type_id,
COUNT(*) AS type_count
FROM
        everytest
LEFT JOIN
question_choice ON everytest.everytest_type = 1
AND everytest.everytest_question_id = question_choice.question_id
LEFT JOIN
question_judge ON everytest.everytest_type = 0
AND everytest.everytest_question_id = question_judge.question_id
        JOIN
question_type ON (
        (everytest.everytest_type = 1 AND question_choice.question_type_id = question_type.type_id) OR
        (everytest.everytest_type = 0 AND question_judge.question_type_id = question_type.type_id)
        )
WHERE
everytest.everytest_test_id = 3
AND everytest.everytest_is_correct = 0
GROUP BY
type_id;




*/




