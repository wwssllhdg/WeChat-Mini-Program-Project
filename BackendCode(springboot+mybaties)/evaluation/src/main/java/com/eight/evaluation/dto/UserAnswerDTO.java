package com.eight.evaluation.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserAnswerDTO {
    private int testId;
    private List<String> userAnswer;
}
