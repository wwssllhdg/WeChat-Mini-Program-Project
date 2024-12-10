package com.eight.evaluation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import lombok.Data;

/**
 * 存放所有选择题
 * @TableName question_choice
 */
@TableName(value ="question_choice")
@Data
public class QuestionChoice implements Serializable {
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
    private String questionChoiceA;

    /**
     * 
     */
    private String questionChoiceB;

    /**
     * 
     */
    private String questionChoiceC;

    /**
     * 
     */
    private String questionChoiceD;

    /**
     * 
     */
    private Integer questionTypeId;

    /**
     * 
     */
    private String questionAnswer;

    /**
     * 题目难度等级
     */
    private Integer questionLevel;

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
        QuestionChoice other = (QuestionChoice) that;
        return (this.getQuestionId() == null ? other.getQuestionId() == null : this.getQuestionId().equals(other.getQuestionId()))
            && (this.getQuestionName() == null ? other.getQuestionName() == null : this.getQuestionName().equals(other.getQuestionName()))
            && (this.getQuestionChoiceA() == null ? other.getQuestionChoiceA() == null : this.getQuestionChoiceA().equals(other.getQuestionChoiceA()))
            && (this.getQuestionChoiceB() == null ? other.getQuestionChoiceB() == null : this.getQuestionChoiceB().equals(other.getQuestionChoiceB()))
            && (this.getQuestionChoiceC() == null ? other.getQuestionChoiceC() == null : this.getQuestionChoiceC().equals(other.getQuestionChoiceC()))
            && (this.getQuestionChoiceD() == null ? other.getQuestionChoiceD() == null : this.getQuestionChoiceD().equals(other.getQuestionChoiceD()))
            && (this.getQuestionTypeId() == null ? other.getQuestionTypeId() == null : this.getQuestionTypeId().equals(other.getQuestionTypeId()))
            && (this.getQuestionAnswer() == null ? other.getQuestionAnswer() == null : this.getQuestionAnswer().equals(other.getQuestionAnswer()))
            && (this.getQuestionLevel() == null ? other.getQuestionLevel() == null : this.getQuestionLevel().equals(other.getQuestionLevel()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getQuestionId() == null) ? 0 : getQuestionId().hashCode());
        result = prime * result + ((getQuestionName() == null) ? 0 : getQuestionName().hashCode());
        result = prime * result + ((getQuestionChoiceA() == null) ? 0 : getQuestionChoiceA().hashCode());
        result = prime * result + ((getQuestionChoiceB() == null) ? 0 : getQuestionChoiceB().hashCode());
        result = prime * result + ((getQuestionChoiceC() == null) ? 0 : getQuestionChoiceC().hashCode());
        result = prime * result + ((getQuestionChoiceD() == null) ? 0 : getQuestionChoiceD().hashCode());
        result = prime * result + ((getQuestionTypeId() == null) ? 0 : getQuestionTypeId().hashCode());
        result = prime * result + ((getQuestionAnswer() == null) ? 0 : getQuestionAnswer().hashCode());
        result = prime * result + ((getQuestionLevel() == null) ? 0 : getQuestionLevel().hashCode());
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
        sb.append(", questionChoiceA=").append(questionChoiceA);
        sb.append(", questionChoiceB=").append(questionChoiceB);
        sb.append(", questionChoiceC=").append(questionChoiceC);
        sb.append(", questionChoiceD=").append(questionChoiceD);
        sb.append(", questionTypeId=").append(questionTypeId);
        sb.append(", questionAnswer=").append(questionAnswer);
        sb.append(", questionLevel=").append(questionLevel);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}