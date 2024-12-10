package com.eight.evaluation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import lombok.Data;

/**
 * 存放每次具体测题目索引和用户答案
 * @TableName everytest
 */
@TableName(value ="everytest")
@Data
public class Everytest implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Integer everytestId;

    /**
     * 存放哪一次测试
     */
    private Integer everytestTestId;

    /**
     * 存放测试题目号
     */
    private Integer everytestNo;

    /**
     * 索引到题目集
     */
    private Integer everytestQuestionId;

    /**
     * 1表示选择题，0表示判断题
     */
    private Integer everytestType;

    /**
     * 用户选择的答案（选择题用ABCD表示，判断题用T/F）
     */
    private String everytestUserAnswer;

    /**
     * 1表示用户答案正确，0表示用户答案错误
     */
    private Integer everytestIsCorrect;

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
        Everytest other = (Everytest) that;
        return (this.getEverytestId() == null ? other.getEverytestId() == null : this.getEverytestId().equals(other.getEverytestId()))
            && (this.getEverytestTestId() == null ? other.getEverytestTestId() == null : this.getEverytestTestId().equals(other.getEverytestTestId()))
            && (this.getEverytestNo() == null ? other.getEverytestNo() == null : this.getEverytestNo().equals(other.getEverytestNo()))
            && (this.getEverytestQuestionId() == null ? other.getEverytestQuestionId() == null : this.getEverytestQuestionId().equals(other.getEverytestQuestionId()))
            && (this.getEverytestType() == null ? other.getEverytestType() == null : this.getEverytestType().equals(other.getEverytestType()))
            && (this.getEverytestUserAnswer() == null ? other.getEverytestUserAnswer() == null : this.getEverytestUserAnswer().equals(other.getEverytestUserAnswer()))
            && (this.getEverytestIsCorrect() == null ? other.getEverytestIsCorrect() == null : this.getEverytestIsCorrect().equals(other.getEverytestIsCorrect()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getEverytestId() == null) ? 0 : getEverytestId().hashCode());
        result = prime * result + ((getEverytestTestId() == null) ? 0 : getEverytestTestId().hashCode());
        result = prime * result + ((getEverytestNo() == null) ? 0 : getEverytestNo().hashCode());
        result = prime * result + ((getEverytestQuestionId() == null) ? 0 : getEverytestQuestionId().hashCode());
        result = prime * result + ((getEverytestType() == null) ? 0 : getEverytestType().hashCode());
        result = prime * result + ((getEverytestUserAnswer() == null) ? 0 : getEverytestUserAnswer().hashCode());
        result = prime * result + ((getEverytestIsCorrect() == null) ? 0 : getEverytestIsCorrect().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", everytestId=").append(everytestId);
        sb.append(", everytestTestId=").append(everytestTestId);
        sb.append(", everytestNo=").append(everytestNo);
        sb.append(", everytestQuestionId=").append(everytestQuestionId);
        sb.append(", everytestType=").append(everytestType);
        sb.append(", everytestUserAnswer=").append(everytestUserAnswer);
        sb.append(", everytestIsCorrect=").append(everytestIsCorrect);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}