package com.eight.evaluation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 存放所有测试记录
 * @TableName test
 */
@TableName(value ="test")
@Data
public class Test implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Integer testId;

    /**
     * 
     */
    private Integer testUserId;

    /**
     * 
     */
    private Integer testSubjectId;

    /**
     * 
     */
    private Integer testScore;

    /**
     * 
     */
    private Date testTime;


    private Integer testUserlevel;

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
        Test other = (Test) that;
        return (this.getTestId() == null ? other.getTestId() == null : this.getTestId().equals(other.getTestId()))
            && (this.getTestUserId() == null ? other.getTestUserId() == null : this.getTestUserId().equals(other.getTestUserId()))
            && (this.getTestSubjectId() == null ? other.getTestSubjectId() == null : this.getTestSubjectId().equals(other.getTestSubjectId()))
            && (this.getTestScore() == null ? other.getTestScore() == null : this.getTestScore().equals(other.getTestScore()))
            && (this.getTestTime() == null ? other.getTestTime() == null : this.getTestTime().equals(other.getTestTime()))
            && (this.getTestUserlevel() == null? other.getTestUserlevel()==null:this.getTestUserlevel().equals(other.getTestUserlevel()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getTestId() == null) ? 0 : getTestId().hashCode());
        result = prime * result + ((getTestUserId() == null) ? 0 : getTestUserId().hashCode());
        result = prime * result + ((getTestSubjectId() == null) ? 0 : getTestSubjectId().hashCode());
        result = prime * result + ((getTestScore() == null) ? 0 : getTestScore().hashCode());
        result = prime * result + ((getTestTime() == null) ? 0 : getTestTime().hashCode());
        result = prime * result + ((getTestUserlevel() == null) ? 0 : getTestUserlevel().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", testId=").append(testId);
        sb.append(", testUserId=").append(testUserId);
        sb.append(", testSubjectId=").append(testSubjectId);
        sb.append(", testScore=").append(testScore);
        sb.append(", testTime=").append(testTime);
        sb.append(", testUserlevel=").append(testUserlevel);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}