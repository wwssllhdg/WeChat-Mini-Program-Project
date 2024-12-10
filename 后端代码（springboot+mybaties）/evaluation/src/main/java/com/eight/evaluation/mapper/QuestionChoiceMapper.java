package com.eight.evaluation.mapper;

import com.eight.evaluation.dto.QuestionChoiceDTO;
import com.eight.evaluation.dto.QuestionDetailDTO;
import com.eight.evaluation.entity.QuestionChoice;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.eight.evaluation.entity.Test;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
* @author lenovo
* @description 针对表【question_choice(存放所有选择题)】的数据库操作Mapper
* @createDate 2024-10-29 14:47:30
* @Entity generator.entity.QuestionChoice
*/
@Mapper
public interface QuestionChoiceMapper extends BaseMapper<QuestionChoice> {
    @Select("select c.* ,t.type_id from question_judge c,question_type t where c.question_type_id=t.type_id and  type_subject_id=#{subjectId}  and question_level=#{level} and t.type_id=#{chapter} ")
    @Results({
            @Result(property = "typeId", column = "type_id"), // 将 type_id 映射到 DTO 的 typeId 属性
            @Result(property = "questionChoice.questionId", column = "question_id"), // 将 question_judge 表的 id 映射到 QuestionChoice 的 id
            @Result(property = "questionChoice.questionTypeId", column = "question_type_id"), // 同理，映射其他字段
            @Result(property = "questionChoice.questionAnswer", column = "question_answer"),
            @Result(property = "questionChoice.questionLevel", column = "question_level"),
            @Result(property = "questionChoice.questionName", column = "question_name")
    })
    public List<QuestionChoiceDTO> getTrueorFalseQuestions(Integer subjectId, Integer chapter, int level);
    @Select("select c.* ,t.type_id from question_choice c,question_type t where c.question_type_id=t.type_id and  type_subject_id=#{subjectId}  and question_level=#{level} and t.type_id=#{chapter}")
    @Results({
            @Result(property = "typeId", column = "type_id"), // 将 type_id 映射到 DTO 的 typeId 属性
            @Result(property = "questionChoice.questionId", column = "question_id"), // 将 question_judge 表的 id 映射到 QuestionChoice 的 id
            @Result(property = "questionChoice.questionTypeId", column = "question_type_id"), // 同理，映射其他字段
            @Result(property = "questionChoice.questionAnswer", column = "question_answer"),
            @Result(property = "questionChoice.questionLevel", column = "question_level"),
            @Result(property = "questionChoice.questionName", column = "question_name"),
            @Result(property = "questionChoice.questionChoiceA", column = "question_choice_a"),
            @Result(property = "questionChoice.questionChoiceB", column = "question_choice_b"),
            @Result(property = "questionChoice.questionChoiceC", column = "question_choice_c"),
            @Result(property = "questionChoice.questionChoiceD", column = "question_choice_d")
    })
    public List<QuestionChoiceDTO> getQuestions(Integer subjectId,Integer chapter,int level);
    @Select("select user_rank from user_level where user_id=#{userId} and subject_id=#{subjectId}")
    public Integer getUserlevel(Integer userId,int subjectId);
    @Insert("insert into test(test_user_id,test_subject_id,test_time) values(#{testUserId},#{testSubjectId},#{testTime})")
    @Options(useGeneratedKeys = true, keyProperty = "testId")
    public int insertaTest(Test test);
    @Insert("insert into everytest(everytest_test_id,everytest_no,everytest_question_id,everytest_type,everytest_is_correct) values(#{everyTestId},#{everytestno},#{everytestquestionid},#{type},0)")
    public int insertaEveryTest(int everyTestId,int everytestno,int everytestquestionid,int type);
    @Select("select question_name,question_choice_a,question_choice_b,question_choice_c,question_choice_d,question_answer,everytest_type,everytest_user_answer,everytest_is_correct from question_choice c,everytest e where c.question_id=e.everytest_question_id and everytest_test_id=#{testId} and everytest_no=#{questionNo}")
    public QuestionDetailDTO getChosenQuestioninDetail(Integer testId, Integer questionNo);
    @Select("select question_name,question_answer,everytest_type,everytest_user_answer,everytest_is_correct from question_judge c,everytest e where c.question_id=e.everytest_question_id and everytest_test_id=#{testId} and everytest_no=#{questionNo}")
    public QuestionDetailDTO getTrueorFalseQuestioninDetail(Integer testId, Integer questionNo);
    @Select("select type_id from question_type where type_subject_id=#{subjectId}")
    public List<Integer> getChapters(Integer subjectId);
}




