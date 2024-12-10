package com.eight.evaluation.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.eight.evaluation.entity.Result;
import com.eight.evaluation.entity.UserInformation;
import com.eight.evaluation.service.UserInformationService;
import com.eight.evaluation.vo.UserInformationVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.system.ApplicationHome;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * 用户个人信息维护
 */
@Slf4j
@RestController
@RequestMapping("/user")
public class UserInformationController {


    @Autowired
    private UserInformationService userInformationService;


    @GetMapping("/getUserInformation")
    public Result<UserInformation> getUserInformation(@RequestParam("userId") int id) {
        LambdaQueryWrapper<UserInformation> queryWrapper = new LambdaQueryWrapper();
        queryWrapper.eq(UserInformation::getUserId, id);
        UserInformation userInformation = userInformationService.getOne(queryWrapper);
        if (userInformation == null) {
            throw new RuntimeException("未找到该用户");
        }
        return Result.success(userInformation);
    }

    @PutMapping("/updateUserInformation/{id}")
    public Result<String> updateUserInformation(@PathVariable int id,
                                                @RequestParam("userLogo") MultipartFile file,
                                                @RequestParam("userSex") int sex,
                                                @RequestParam("userNickname") String userNickname,
                                                @RequestParam("userSignature") String userSignature,
                                                @RequestParam("userSchool") String userSchool,
                                                @RequestParam("userBirthday") String userBirthday
    ) {
        String fileName = "";
        int f = 0;
        if (!file.isEmpty()) {
            try {
                // 获取文件名称并设置保存路径
                String originalFilename = file.getOriginalFilename();
                String ext = "." + originalFilename.split("\\.")[1];
                String uuid = UUID.randomUUID().toString().replace("-", "");
                fileName = uuid + ext;
                String directoryPath = "/images"; // 指定目录路径
                String fullPath = directoryPath + "/" + fileName;

                // 检查目录是否存在，如果不存在则创建
                File directory = new File(directoryPath);
                if (!directory.exists()) {
                    if (directory.mkdirs()) {
                        System.out.println("目录不存在，已成功创建: " + directoryPath);
                    } else {
                        throw new RuntimeException("目录创建失败: " + directoryPath);
                    }
                }

                System.out.println(fullPath);

                f = 1;

                // 保存文件到指定路径
                file.transferTo(new File(fullPath));
                System.out.println("图片上传成功");
            } catch (IOException e) {
                log.error("图片上传失败", e);
                throw new RuntimeException("图片上传失败:" + e.getMessage());
            }

        }
        String filePath = "";
        if (f == 1) {
            filePath = "http://106.54.212.158:8888/images/" + fileName;
        }
        LambdaQueryWrapper<UserInformation> queryWrapper = new LambdaQueryWrapper();
        queryWrapper.eq(UserInformation::getUserId, id);
        int userInformationId = userInformationService.getOne(queryWrapper).getUserInformationId();
        UserInformation userInformation = new UserInformation();
        userInformation.setUserInformationId(userInformationId);
        userInformation.setUserId(id);
        userInformation.setUserSex(sex);
        if (f == 1) {
            userInformation.setUserLogo(filePath);

        }
        userInformation.setUserNickname(userNickname);
        userInformation.setUserSignature(userSignature);
        userInformation.setUserSchool(userSchool);
        userInformation.setUserBirthday(userBirthday);
        userInformationService.updateById(userInformation);
        return Result.success(null);
    }


}


//            try {
//                // 获取文件名称并设置保存路径
//                String originalFilename = file.getOriginalFilename();
//                String ext = "."+originalFilename.split("\\.")[1];
//                String uuid = UUID.randomUUID().toString().replace("-", "");
//                fileName = uuid + ext;
//                String path = "/images/"+fileName;
//                System.out.println(path);
//
//                f = 1;
//
//                // 保存文件到指定路径
//                file.transferTo(new File(path));
//                System.out.println("图片上传成功");
//            } catch (IOException e) {
//                log.error("图片上传失败");
//                throw new RuntimeException("图片上传失败");
//
//            }