package com.eight.evaluation.controller;

import com.alibaba.fastjson.JSONObject;
import com.eight.evaluation.dto.UserDTO;
import com.eight.evaluation.entity.Result;
import com.eight.evaluation.entity.UserLogin;
import com.eight.evaluation.mapper.UserLoginMapper;
import com.eight.evaluation.utils.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Random;

@CrossOrigin
@RestController
@RequestMapping("/user")
public class UserController {
    //用户登录
    @Autowired
    private UserLoginMapper userLoginMapper;
    @PostMapping("/login")
    public Result<UserDTO> login(@RequestBody JSONObject jsonObject) {
        String userPassword = jsonObject.getString("userPassword");
        String userPhone = jsonObject.getString("userPhone");
        UserLogin userLogin = userLoginMapper.selectPasswordByPhone(userPhone);
        if (userLogin == null) {
            return Result.error(403, "用户不存在");
        }
        // 检查密码是否正确
        if (!userLogin.getUserPassword().equals(userPassword)) {
            return Result.error(401, "密码错误");
        }

        // 密码正确，生成token
        UserDTO userDTO = new UserDTO();
        HashMap<String, String> map = new HashMap<>();
        map.put("userID", String.valueOf(userLogin.getUserId()));
        map.put("timestamp", String.valueOf(System.currentTimeMillis()));
        userDTO.setUserId(userLogin.getUserId());
        userDTO.setToken(JwtUtil.createToken(map));
        return Result.success(userDTO);
    }
    //用户注册
    @PostMapping("/register")
    public Result<UserDTO> register(@RequestBody JSONObject jsonObject) {
        String userPassword = jsonObject.getString("userPassword");
        String userPhone = jsonObject.getString("userPhone");
        UserLogin userLogin = userLoginMapper.selectPasswordByPhone(userPhone);
        if (userLogin != null ) {
            return Result.error(403, "用户已存在");
        }
//        } else  if(!json.getString("verifyCode").equals(verifyCode)) {
//            return Result.error(402, "验证码错误");
//        } else if ((System.currentTimeMillis() - json.getLong("createTime")> 1000 * 60 * 5)){
//            return Result.error(402, "验证码过期");
//        }

        int update= userLoginMapper.insertUser(userPhone, userPassword);
        UserLogin userLogin1 = userLoginMapper.selectPasswordByPhone(userPhone);
        Random random = new Random();
        int number =  random.nextInt(0,1000);
        String nickname = "用户_"+number;
        userLoginMapper.insertUserInformation(userLogin1.getUserId(),nickname);
           if(update==1){
               return Result.success(null);
           }
           return Result.error(402, "注册失败");
    }
    /**
     * 发送短信验证码
     * @param
     */
    @GetMapping("/register/getcode")
    public Object getcode(HttpServletRequest request) {
        try {

            JSONObject json = null;
            //生成6位验证码
            String verifyCode = String.valueOf(new Random().nextInt(899999) + 100000);
            //发送短信
//            ZhenziSmsClient client = new ZhenziSmsClient("你的appId", "你的appSecret");
//            String result = client.send(phoneNum, "您的验证码为:" + verifyCode + "，该码有效期为5分钟，该码只能使用一次！【短信签名】");
//            json = JSONObject.parseObject(result);
//            if(json.getIntValue("code") != 0)//发送短信失败
//                return "fail";
            System.out.println("verifyCode: " + verifyCode);
            String[] phoneNumbers = request.getParameterValues("phone");
            System.out.println(Arrays.toString(phoneNumbers));
            //将验证码存到session中,同时存入创建时间
            //以json存放，这里使用的是阿里的fastjson
            HttpSession session = request.getSession();
            json = new JSONObject();
            json.put("verifyCode", verifyCode);
            json.put("createTime", System.currentTimeMillis());
            json.put("phone", phoneNumbers);
            // 将认证码存入SESSION
            request.getSession().setAttribute("verifyCode", json);
            return Result.success(null);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}


