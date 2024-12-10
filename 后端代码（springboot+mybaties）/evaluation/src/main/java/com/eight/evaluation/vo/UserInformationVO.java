package com.eight.evaluation.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserInformationVO {

    private Integer userSex;


    private String userNickname;


    private String userSignature;


    private String userSchool;


    private String userBirthday;


private MultipartFile userLogo;
}
