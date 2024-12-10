package com.eight.evaluation.mapper;

import com.eight.evaluation.dto.SubjectDTO;
import com.eight.evaluation.entity.Subject;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
* @author lenovo
* @description 针对表【subject(题目集)】的数据库操作Mapper
* @createDate 2024-10-29 14:47:30
* @Entity generator.entity.Subject
*/
@Mapper
public interface SubjectMapper extends BaseMapper<Subject> {
    //查询所有题目集
    @Select("select * from  subject")
    List<Subject> findSubjects();


    SubjectDTO getSubject(@Param("subjectId") int subjectId, @Param("userId") int userId);
}




