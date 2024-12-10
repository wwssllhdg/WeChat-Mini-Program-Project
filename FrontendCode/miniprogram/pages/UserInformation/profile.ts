import { GetUserInformation } from '../../api/API.js';
import { UpdateUserInformation } from '../../api/API.js';
Page({
  data: {
    selectedGender: 'male', // 默认选中男
    nickname: '',
    birthdate: '',
    userLogo: 'sdhfjsdhjfhdsjfhdskjfnh',
    signature: '',
    school: '',
    date: '1980-01-30',   // 设置默认日期
    showPlaceholder: true, // 控制是否显示占位符
  },

  // 选择性别
  chooseGender(e: { currentTarget: { dataset: { gender: any; }; }; }) {
    const selectedGender = e.currentTarget.dataset.gender;
    this.setData({
      selectedGender: selectedGender,
    });
  },

  // 更新输入框中的昵称
  onNicknameChange(e: { detail: { value: any; }; }) {
    this.setData({
      nickname: e.detail.value,
    });
  },

  // 更新生日
  onBirthdateChange(e: { detail: { value: any; }; }) {
    this.setData({
      birthdate: e.detail.value,
    });
  },

  // 更新签名
  onSignatureChange(e: { detail: { value: any; }; }) {
    this.setData({
      signature: e.detail.value,
    });
  },

  // 更新学校
  onSchoolChange(e: { detail: { value: any; }; }) {
    this.setData({
      school: e.detail.value,
    });
  },
  // 保存个人资料
  saveProfile() {
    const { nickname, selectedGender, birthdate, signature, school, userLogo } = this.data;
    
    const userId = wx.getStorageSync('userId'); // 从本地存储获取 userId

    if (!userId) {
      wx.showToast({
        title: '未找到用户 ID，请重新登录',
        icon: 'none',
        duration: 2000,
      });
      return;
    }

    // 验证昵称：长度 2-20 个字符，不能为空
    if (!nickname || nickname.length < 2 || nickname.length > 20) {
      wx.showToast({
        title: '昵称需2-20个字符',
        icon: 'none',
        duration: 2000,
      });
      return;
    }
  
    // 验证头像：不能为空
    if (!userLogo) {
      wx.showToast({
        title: '请上传头像',
        icon: 'none',
        duration: 2000,
      });
      return;
    }
  
    // 验证生日：格式为 YYYY-MM-DD，且长度不超过 20 字符
    if (birthdate && (!/^\d{4}-\d{2}-\d{2}$/.test(birthdate) || birthdate.length > 20)) {
      wx.showToast({
        title: '生日格式有误，需为 YYYY-MM-DD',
        icon: 'none',
        duration: 2000,
      });
      return;
    }
  
    // 验证签名：长度不超过 100 字符
    if (signature && signature.length > 100) {
      wx.showToast({
        title: '签名不能超过 100 个字符',
        icon: 'none',
        duration: 2000,
      });
      return;
    }
  
    // 验证学校：长度不超过 20 字符
    if (school && school.length > 20) {
      wx.showToast({
        title: '学校名称不能超过 20 个字符',
        icon: 'none',
        duration: 2000,
      });
      return;
    }
  
    // 设置性别
    let usersex = selectedGender === 'male' ? 1 : 0;
  
    // 请求参数
    const params = {
      userSex: usersex,
      userNickname: nickname,
      userLogo: userLogo,
      userSignature: signature || '', // 可选字段为空时传递空字符串
      userSchool: school || '',      // 可选字段为空时传递空字符串
      userBirthday: birthdate || '', // 可选字段为空时传递空字符串
    };
  
    console.log('请求参数:', params);
  
    // 调用更新接口
    UpdateUserInformation(userId,params)
      .then((response) => {
        if (response.code === 200) {
          wx.showToast({
            title: '更新成功',
            icon: 'success',
            duration: 2000,
          });
  
          // 跳转到个人主页
          wx.switchTab({
            url: '/pages/Main/profile',
          });
        } else {
          wx.showToast({
            title: response.msg || '更新失败',
            icon: 'none',
            duration: 2000,
          });
        }
      })
      .catch((error) => {
        console.error('更新失败:', error);
        wx.showToast({
          title: '网络异常，请稍后重试',
          icon: 'error',
          duration: 2000,
        });
      });
  },
  

  bindDateChange(e: { detail: { value: any; }; }) {
    this.setData({
      date: e.detail.value, // 更新为用户选择的日期
      showPlaceholder: false, // 隐藏占位符
    });
  },
  // 页面初始化时可以获取用户资料
  onLoad() {
    const userId = wx.getStorageSync('userId'); // 获取存储的 userId
    console.log("userId is ",userId);
    if (!userId) {
      console.log('用户未登录或没有 userId');
      wx.showToast({
        title: '用户信息未找到',
        icon: 'error',
      });
      return;
    }
    // 假设从后端获取用户资料
   GetUserInformation({userId}) // 参数以对象形式传递
   .then((response) => {
    if (response.code === 200) {
      const userProfile = response.data;  // 获取后端返回的用户资料
      if(userProfile != null){
              // 更新页面数据
      this.setData({
        nickname: userProfile.userNickname,
        selectedGender: userProfile.userSex === 1 ? 'male' : 'female',  // 映射性别
        birthdate: userProfile.userBirthday,
        signature: userProfile.userSignature,
        school: userProfile.userSchool,
      });
      console.log('用户资料:', userProfile);
      }

     } else {
       wx.showToast({
         title: response.msg || '访问失败',
         icon: 'error',
         duration: 2000,
       });
     }
   })
   .catch((error) => {
     console.error('访问失败:', error);
     wx.showToast({
       title: '网络异常，请稍后重试',
       icon: 'error',
       duration: 2000,
     });
   });
  },
  // 返回按钮
  goback() {
    // 跳转到主页
    wx.redirectTo({
      url: '/pages/Main/profile', // 跳转到主页
    });
  },

});
