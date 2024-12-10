package com.eight.evaluation.mapper;

import com.eight.evaluation.dto.UserRank;
import com.eight.evaluation.entity.Test;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
* @author lenovo
* @description 针对表【test(存放所有测试记录)】的数据库操作Mapper
* @createDate 2024-10-29 14:47:30
* @Entity generator.entity.Test
*/
@Mapper
public interface TestMapper extends BaseMapper<Test> {

    Test getUserRank(@Param("testId") int testId);

    int getAvgScore(@Param("userId") int userId,@Param("subjectId") int subjectId);

    int getCount(@Param("userId") int userId,@Param("subjectId") int subjectId);

    Integer getTestScore(int testId);
}




