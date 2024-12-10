import { UserLogin } from '../../api/API.js';


Page({
  data: {
    userPhone: '',
    userPassword: '',
  },
  onRegister(){
    wx.redirectTo({ url: '/pages/Register/profile' });
  },
  // 手机号输入变化事件
  onPhoneInput(e: { detail: { value: any; }; }) {
    this.setData({
      userPhone: e.detail.value, // 获取输入框的值并更新到 data 中
    });
  },

  // 密码输入变化事件
  onPasswordInput(e: { detail: { value: any; }; }) {
    this.setData({
      userPassword: e.detail.value, // 获取输入框的值并更新到 data 中
    });
  },

  // 登录按钮事件
  onLogin: async function() {
    const { userPhone, userPassword } = this.data;
    // 输出手机号和密码
    console.log('用户手机号:', userPhone);
    console.log('用户密码:', userPassword);
    // 检查手机号和密码是否输入
    if (!userPhone || !userPassword) {
      wx.showToast({
        icon: 'none',
        title: '请输入手机号和密码',
        duration: 2000,
      });
      return;
    }
      // 验证手机号格式
      const phonePattern = /^[1][3-9][0-9]{9}$/;  // 简单的中国大陆手机号正则（11位数字，以1开头，第二位为3-9）
      if (!phonePattern.test(userPhone)) {
        wx.showToast({
          title: '手机号格式不正确',
          icon: 'none',
          duration: 2000,
        });
        return;
      }
    // 调用登录 API
    const response = await UserLogin({ userPhone, userPassword });
    console.log("登录成功，返回数据：", response);

        if (response.code === 200) {
          const { userId, token } = response.data;
          wx.setStorageSync('token', token); // 存储 token 到本地
          wx.setStorageSync('userId', userId); // 存储用户 ID 到本地
          // const token = wx.getStorageSync('token'); // 获取存储的 token
          // const userId = wx.getStorageSync('userId'); // 获取存储的 userId
          wx.setStorageSync('subject', 'C++题目集');//默认c++题目集

          wx.showToast({
            title: '登录成功',
            icon: 'success',
            duration: 2000,
          });

        // 使用 setTimeout 延迟执行跳转，确保 Toast 显示时不被打断  
          wx.redirectTo({url: '/pages/Main/profile'}); // 延时 2 秒后跳转

        } else if(response.code == 403) {
          wx.showToast({
            title: response.msg || '用户不存在',
            icon: 'error',
            duration: 2000,
          });
        }else if(response.code == 401) {
          wx.showToast({
            title: response.msg || '账号密码错误',
            icon: 'error',
            duration: 2000,
          });
        }else{
          wx.showToast({
            title: response.msg || '登录失败，请稍后重试',
            icon: 'error',
            duration: 2000,
          });
        }
}
});
  