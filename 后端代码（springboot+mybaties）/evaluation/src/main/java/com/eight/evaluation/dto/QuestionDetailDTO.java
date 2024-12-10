package com.eight.evaluation.dto;

import lombok.Data;

@Data
public class QuestionDetailDTO {
    private String questionName;
    private String questionChoiceA;
    private String questionChoiceB;
    private String questionChoiceC;
    private String questionChoiceD;
    private String questionAnswer;
    private int everytestType;
    private String everytestUserAnswer;
    private int everytestIsCorrect;
}
