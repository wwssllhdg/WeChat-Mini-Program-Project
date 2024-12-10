package com.eight.evaluation.dto;

import com.eight.evaluation.entity.QuestionChoice;
import lombok.Data;

@Data
public class QuestionChoiceDTO {
    private QuestionChoice questionChoice;
    private int typeId;

    public int getTypeId() {
        return typeId;
    }
}
