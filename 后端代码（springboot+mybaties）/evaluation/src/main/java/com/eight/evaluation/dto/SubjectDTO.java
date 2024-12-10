package com.eight.evaluation.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SubjectDTO {
    int subjectId;
    String subjectName;
    String subjectLogo;
    int userRank;
}
