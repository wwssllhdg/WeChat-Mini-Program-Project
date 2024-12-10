package com.eight.evaluation.service;

import com.eight.evaluation.entity.Test;
import com.baomidou.mybatisplus.extension.service.IService;
import com.eight.evaluation.vo.ShowTestVO;

import java.util.List;

/**
* @author lenovo
* @description 针对表【test(存放所有测试记录)】的数据库操作Service
* @createDate 2024-10-29 14:47:30
*/
public interface TestService extends IService<Test> {

    List<ShowTestVO> showTest(Integer userId, Integer subjectId);
}
