package com.eight.evaluation.mapper;

import com.eight.evaluation.entity.UserLevel;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author lenovo
* @description 针对表【user_level(存放用户各个科目等级)】的数据库操作Mapper
* @createDate 2024-10-29 14:47:30
* @Entity generator.entity.UserLevel
*/
@Mapper
public interface UserLevelMapper extends BaseMapper<UserLevel> {

    void updateRank(@Param("userId") int userId, @Param("subjectId") int subjectId, @Param("level") int level);

    List<Integer> selectUserSubjectId(@Param("userId") int userId);
}




