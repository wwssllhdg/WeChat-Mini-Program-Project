package com.eight.evaluation.vo;

import com.eight.evaluation.dto.QuestionDTO1;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class TranscriptVO {
    private int testScore;
    private int testLevel;
    private String testEvaluation;
    private List<QuestionDTO1> question;
}
