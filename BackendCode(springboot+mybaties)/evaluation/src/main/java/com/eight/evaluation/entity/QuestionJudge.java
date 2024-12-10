package com.eight.evaluation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import lombok.Data;

/**
 * 存放所有判断题
 * @TableName question_judge
 */
@TableName(value ="question_judge")
@Data
public class QuestionJudge implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Integer questionId;

    /**
     * 
     */
    private String questionName;

    /**
     * 
     */
    private String questionAnswer;

    /**
     * 
     */
    private Integer questionLevel;

    /**
     * 
     */
    private Integer questionTpyeId;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        QuestionJudge other = (QuestionJudge) that;
        return (this.getQuestionId() == null ? other.getQuestionId() == null : this.getQuestionId().equals(other.getQuestionId()))
            && (this.getQuestionName() == null ? other.getQuestionName() == null : this.getQuestionName().equals(other.getQuestionName()))
            && (this.getQuestionAnswer() == null ? other.getQuestionAnswer() == null : this.getQuestionAnswer().equals(other.getQuestionAnswer()))
            && (this.getQuestionLevel() == null ? other.getQuestionLevel() == null : this.getQuestionLevel().equals(other.getQuestionLevel()))
            && (this.getQuestionTpyeId() == null ? other.getQuestionTpyeId() == null : this.getQuestionTpyeId().equals(other.getQuestionTpyeId()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getQuestionId() == null) ? 0 : getQuestionId().hashCode());
        result = prime * result + ((getQuestionName() == null) ? 0 : getQuestionName().hashCode());
        result = prime * result + ((getQuestionAnswer() == null) ? 0 : getQuestionAnswer().hashCode());
        result = prime * result + ((getQuestionLevel() == null) ? 0 : getQuestionLevel().hashCode());
        result = prime * result + ((getQuestionTpyeId() == null) ? 0 : getQuestionTpyeId().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", questionId=").append(questionId);
        sb.append(", questionName=").append(questionName);
        sb.append(", questionAnswer=").append(questionAnswer);
        sb.append(", questionLevel=").append(questionLevel);
        sb.append(", questionTpyeId=").append(questionTpyeId);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}