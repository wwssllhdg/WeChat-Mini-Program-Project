package com.eight.evaluation.dto;

import com.eight.evaluation.entity.QuestionChoice;
import lombok.Data;

import java.util.List;

@Data
public class QuestionDTO {
    private  int testId;
    private List<SelectedQuestion> selectedQuestions;
}
