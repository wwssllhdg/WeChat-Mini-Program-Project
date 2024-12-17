import { GetUserInformation } from '../../api/API.js';
import { UpdateUserInformation } from '../../api/API.js';
Page({
  data: {
    selectedGender: 'male', // 默认选中男
    nickname: '',
    userLogo: '',
    signature: '',
    school: '',
    birthdate: '1980-01-01',   // 初始化默认生日为1980-01-01
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

  // 选择生日时触发的事件
  onBirthdateChange(e: { detail: { value: any; }; }) {
    console.log("Selected date:", e.detail.value);  // 调试查看选中的日期
    this.setData({
      birthdate: e.detail.value,   // 更新实际的生日
      showPlaceholder: false,      // 隐藏占位符
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
  
    const userId = wx.getStorageSync('userId');
    const token = wx.getStorageSync('token');
  
    if (!userId) {
      wx.showToast({
        title: '未找到用户 ID，请重新登录',
        icon: 'none',
        duration: 2000,
      });
      return;
    }
  
    // 验证昵称长度
    if (!nickname || nickname.length < 2 || nickname.length > 20) {
      wx.showToast({
        title: '昵称需2-20个字符',
        icon: 'none',
        duration: 2000,
      });
      return;
    }
  
    // 设置性别
    let usersex = selectedGender === 'male' ? 1 : 0;
  
    const params = {
      userSex: usersex,
      userNickname: nickname,
      userSignature: signature || '',
      userSchool: school || '',
      userBirthday: birthdate || '',
    };
  
    const uploadFile = (filePath: string) => {
      wx.uploadFile({
        url: `http://106.54.212.158:8888/user/updateUserInformation/${userId}`,
        filePath: filePath,
        name: 'userLogo',
        header: {
          'token': token,
        },
        formData: params,
        success: (res) => {
          console.log('上传成功，返回的数据:', res.data);
          try {
            const data = JSON.parse(res.data);
            if (data.code === 200) {
              wx.showToast({
                title: '更新成功',
                icon: 'success',
              });
              this.onLoad(); // 保存成功后重新加载用户信息
            } else {
              wx.showToast({
                title: data.msg || '更新失败',
                icon: 'none',
              });
            }
          } catch (error) {
            console.error('解析返回数据失败:', error);
            wx.showToast({
              title: '服务器返回数据格式错误',
              icon: 'none',
            });
          }
          deleteTempFile(filePath); // 上传后删除临时文件
        },
        fail: (err) => {
          console.error('更新失败:', err);
          wx.showToast({
            title: '网络异常，请稍后重试',
            icon: 'error',
          });
          deleteTempFile(filePath); // 上传失败也删除临时文件
        },
      });
    };
    
    // 删除临时文件的函数
    const deleteTempFile = (filePath: string) => {
      wx.getFileSystemManager().unlink({
        filePath: filePath,
        success: () => {
          console.log('临时文件删除成功:', filePath);
        },
        fail: (err) => {
          console.error('临时文件删除失败:', err);
        },
      });
    };
    
    // 判断 userLogo 是否为网络地址
    const isWebUrl = userLogo.startsWith('http://') || userLogo.startsWith('https://');
    
    if (isWebUrl) {
      // 如果是网络地址，先下载图片再上传
      wx.downloadFile({
        url: userLogo,
        success: (res) => {
          if (res.statusCode === 200) {
            const tempFilePath = res.tempFilePath;
            uploadFile(tempFilePath); // 下载成功后上传文件
          } else {
            wx.showToast({
              title: '图片下载失败，请重试',
              icon: 'none',
            });
          }
        },
        fail: (err) => {
          console.error('下载失败:', err);
          wx.showToast({
            title: '图片下载失败，请检查网络',
            icon: 'none',
          });
        },
      });
    } else if (userLogo) {
      // 如果是本地路径，直接上传
      uploadFile(userLogo);
    } else {
      // 如果没有选择头像，提示用户
      wx.showToast({
        title: '请上传头像',
        icon: 'none',
        duration: 2000,
      });
    };
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
        userLogo:userProfile.userLogo,
        showPlaceholder: !userProfile.userBirthday, // 如果生日有值，隐藏占位符
      });
      wx.setStorageSync('userLogo', this.data.userLogo);
      wx.setStorageSync('userLogo', userProfile.userLogo);
      console.log("用户头像已存储:", userProfile.userLogo); 
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
  // 选择图片并设置临时路径
  chooseImage() {
    
    wx.chooseImage({
      count: 1,
      sizeType: ['compressed'],
      sourceType: ['album', 'camera'],
      success: (res) => {
        const tempFilePath = res.tempFilePaths[0];
        console.log('选中图片的路径:', res.tempFilePaths[0]);
        this.setData({
          userLogo: tempFilePath,
        });
        wx.setStorageSync('userLogo', tempFilePath);
      },
      fail: (err) => {

      },
    });
  },

});
