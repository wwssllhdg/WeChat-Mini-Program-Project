import { UserRegister } from '../../api/API.js';

Page({
  data: {
    phoneNumber: '',
    code: '',
    password: ''
  },
  goBack(){
      wx.redirectTo({url: '/pages/Log/profile'});
  },
  // 获取手机号输入框的值
  onPhoneInput(event: { detail: { value: any; }; }) {
    this.setData({
      phoneNumber: event.detail.value
    });
  },

  // 获取验证码输入框的值
  onCodeInput(event: { detail: { value: any; }; }) {
    this.setData({
      code: event.detail.value
    });
  },

  // 获取密码输入框的值
  onPasswordInput(event: { detail: { value: any; }; }) {
    this.setData({
      password: event.detail.value
    });
  },

  // 点击注册按钮时触发
  onRegister() {
    const { phoneNumber, code, password } = this.data;
    console.log('用户手机号:', phoneNumber);
    console.log('用户密码:', code);
    console.log('用户密码:', password);
    // 检查是否填写了所有必要的字段
    if (!phoneNumber || !code || !password) {
      wx.showToast({
        title: '请填写所有信息',
        icon: 'none'
      });
      return;
    }
     // 验证手机号格式
     const phonePattern = /^[1][3-9][0-9]{9}$/;  // 简单的中国大陆手机号正则（11位数字，以1开头，第二位为3-9）
     if (!phonePattern.test(phoneNumber)) {
       wx.showToast({
         title: '手机号格式不正确',
         icon: 'none',
         duration: 2000,
       });
       return;
     }
     // 验证密码长度（例如 6-20 位）
     if (password.length < 6 || password.length > 20) {
       wx.showToast({
         title: '密码长度应为6-20位',
         icon: 'none',
         duration: 2000,
       });
       return;
     }

     // 验证密码复杂性：至少包含字母和数字
     const passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d).{6,20}$/;
     if (!passwordPattern.test(password)) {
       wx.showToast({
         title: '密码必须包含字母和数字',
         icon: 'none',
         duration: 2000,
       });
       return;
     }
     if(code != password){
      wx.showToast({
        title: '两次输入密码必须相同',
        icon: 'none',
        duration: 2000,
      });
      return;
     }
    
    // 向后端发送请求
    UserRegister({userPhone: phoneNumber, userPassword: password})
    .then((response) => {
      if (response.code === 200) {       
        wx.showToast({
          title: '注册成功',
          icon: 'success',
          duration: 2000,
        });
         // 使用 setTimeout 延迟执行跳转，确保 Toast 显示时不被打断
          wx.redirectTo({url: '/pages/Log/profile',});


      } else if(response.code === 403){
        //存在用户已存在的情况
        wx.showToast({
          title: '用户已存在',
          icon: 'none',
          duration: 2000,
        });
         // 

      }
    })
    .catch((error) => {
      console.error('注册失败:', error);
      wx.showToast({
        title: '网络异常，请稍后重试',
        icon: 'none',
        duration: 2000,
      });
    });    
  }
});
