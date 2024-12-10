package com.eight.evaluation.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SubjectVO {
    int subjectId;
    String subjectName;
    String subjectLogo;
    int testScore;
    int userRank;
    String userLogo;


}
