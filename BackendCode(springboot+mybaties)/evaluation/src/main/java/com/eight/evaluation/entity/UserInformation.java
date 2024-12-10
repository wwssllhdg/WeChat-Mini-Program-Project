package com.eight.evaluation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Arrays;
import lombok.Data;

/**
 * 存放用户基本信息
 * @TableName user_information
 */
@TableName(value ="user_information")
@Data
public class UserInformation implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Integer userInformationId;

    /**
     * 
     */
    private Integer userId;

    /**
     * 0表示女，1表示男
     */
    private Integer userSex;

    /**
     * 用户昵称
     */
    private String userNickname;

    /**
     * 
     */
    private String userSignature;

    /**
     * 
     */
    private String userSchool;

    /**
     * 
     */
    private String userBirthday;

    /**
     * 用户头像
     */
    private String userLogo;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;



    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getUserInformationId() == null) ? 0 : getUserInformationId().hashCode());
        result = prime * result + ((getUserId() == null) ? 0 : getUserId().hashCode());
        result = prime * result + ((getUserSex() == null) ? 0 : getUserSex().hashCode());
        result = prime * result + ((getUserNickname() == null) ? 0 : getUserNickname().hashCode());
        result = prime * result + ((getUserSignature() == null) ? 0 : getUserSignature().hashCode());
        result = prime * result + ((getUserSchool() == null) ? 0 : getUserSchool().hashCode());
        result = prime * result + ((getUserBirthday() == null) ? 0 : getUserBirthday().hashCode());
        result = prime * result + ((getUserLogo()) == null ? 0 : getUserLogo().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", userInformationId=").append(userInformationId);
        sb.append(", userId=").append(userId);
        sb.append(", userSex=").append(userSex);
        sb.append(", userNickname=").append(userNickname);
        sb.append(", userSignature=").append(userSignature);
        sb.append(", userSchool=").append(userSchool);
        sb.append(", userBirthday=").append(userBirthday);
        sb.append(", userLogo=").append(userLogo);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}