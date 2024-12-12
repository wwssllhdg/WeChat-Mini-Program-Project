import { GetHomepageInformation } from "../../api/API"; 
import { GetTestQuestion } from "../../api/API"; 
import { GetUserInformation } from '../../api/API.js';
// // 调用时可以选择是否显示提示信息

Page({
  data: {
    userLogo:"",
    userId: '', // 用户ID
    subjectId: -1, // 题目集ID
    subjectName: '', // 题目集名称
    subjectLogo: '', // 题目集Logo
    testScore: "", // 测试成绩
    userRank: 0, // 用户等级
    selected: 'main' // 默认选中 "main"（首页）
  },
    //加载页面数据

  onLoad: async function(){

    console.log("开始加载主页面");
    const userId = wx.getStorageSync('userId'); // 获取存储的 userId
    if (!userId) {
      console.log('用户未登录或没有 userId');
      wx.showToast({
        title: '用户信息未找到',
        icon: 'error',
        duration: 2000,
      });
      wx.redirectTo({
        url: '/pages/Log/profile', // 重定向到登录页面
      });
      return;
    }
    console.log("UserId is ",userId);



    // 假设从后端获取用户资料
   GetUserInformation({userId}) // 参数以对象形式传递
   .then((response) => {
    if (response.code === 200) {
      const userProfile = response.data;  // 获取后端返回的用户资料
      if(userProfile != null){
              // 更新页面数据
      this.setData({
        userLogo:userProfile.userLogo,
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

    const storedUserLogo = wx.getStorageSync('userLogo');
    console.log("读取到的用户头像:", storedUserLogo);

    if (storedUserLogo) {
      this.setData({
        userLogo: storedUserLogo,
      });
      console.log("用户头像存在");
    }else{
      console.log("用户头像不存在");
    }
     // 检查本地存储的 subjectId
      let subjectId = wx.getStorageSync('subjectId');



      if (!subjectId) {
        subjectId = 1; // 默认题目集 ID 为 1（C语言题目集）
        wx.setStorageSync('subjectId', subjectId); // 存储默认值到本地
      }



      console.log("Main - subjectId is ",subjectId);
      this.setData({ userId, subjectId });
    try{
      const response = await GetHomepageInformation({userId,subjectId});
      console.log('完整的响应数据:', response);
      if(response.code === 200){
        let { subjectId ,subjectName, subjectLogo, testScore, userRank } = response.data;
        
        const subjectImageMap:{[key:string]:string} = {
          "C语言基础": "c++.png",
          "python语言程序设计": "python.png",
          "Java语言程序设计": "java.png",
          "数据结构": "datastructure.png"
        };



        if(testScore === -1){
          testScore = "暂无" ;
        }


        this.setData({
          subjectName,
          subjectLogo,
          testScore,
          userRank,
          subjectImage: subjectImageMap[subjectName] || "default.jpg"
        });
  


        wx.setStorageSync('subjectId', subjectId); // 更新本地subjectId
        console.log('后端返回的数据:', response.data);
      }else{
        console.error('获取数据失败:', response.msg);
        wx.showToast({
          title: '加载数据失败',
          icon: 'none',
          duration: 2000,
        });
      }
    }catch(err){
        console.error("请求失败:",err);
    }
     

    },


    // 点击题目集选择
    navigateToSubject() {
      wx.redirectTo({
        url: `/pages/Subject/profile?subjectId=${this.data.subjectId}`,  // 传递 subjectId
      });
    },
  
    // 点击个人信息详情
    navigateToUserInformation() {
      wx.redirectTo({
        url: '/pages/UserInformation/profile', // 跳转到题目集详情页面
      });
    },
    // 点击主页
    navigateToMain() {
      wx.redirectTo({
        url: '/pages/Main/profile', // 跳转到主页面
      });
    },
    // 点击开始测试
    navigateToTest() {
      // 获取用户 ID
      const userId = wx.getStorageSync('userId');
      if (!userId) {
        console.error('用户未登录，无法开始测试');
        wx.showToast({
          title: '请先登录',
          icon: 'error',
          duration: 2000,
        });
        return;
      }
      console.log('用户 ID:', userId);
    
      // 获取选中的题目集合（subjectId）
      let subjectId = wx.getStorageSync('subjectId');
      console.log('subjectId is', subjectId);
    
      // 调用接口获取题目
      GetTestQuestion({ userId, subjectId })
        .then((response) => {
          if (response.code === 200) {
            // 获取返回的题目数据
            const data = response.data;
    
            // 存储 testId 和 questions 到本地
            wx.setStorageSync('testId', data.testId); // 存储测试ID
            wx.setStorageSync('questions', data.selectedQuestions); // 存储题目列表
    
            console.log('题目数据已存储', data.selectedQuestions);
    
            // 读取题目并跳转
            const questions = data.selectedQuestions; // 直接从接口返回的数据读取
            if (!questions || questions.length === 0) {
              console.error('题目列表为空');
              wx.showToast({
                title: '题目加载失败，请稍后重试',
                icon: 'none',
                duration: 2000,
              });
              return;
            }

            // 判断题目类型并跳转
            if (questions[0].everytestType === 1) {
              // 跳转到选择题页面，传递题目ID
              console.log('题目类型为选择题');
              console.log('题目Id为', questions[0].everytestNo);
              wx.redirectTo({
                url: `/pages/Choose/profile?questionNo=1`,
              });
            } else if (questions[0].everytestType === 0) {
              // 跳转到判断题页面，传递题目ID
              console.log('题目类型为判断题');
              console.log('题目Id为', questions[0].everytestNo);
              wx.redirectTo({
                url: `/pages/Judge/profile?questionNo=1`,
              });
            }
          }else{
            console.error('请求失败:', response.msg);
            wx.showToast({
              title: '加载题目失败，请稍后重试',
              icon: 'none',
              duration: 2000,
            });
          }
        })
        .catch((error) => {
          console.error('请求错误:', error);
          wx.showToast({
            title: '网络异常，请稍后重试',
            icon: 'none',
            duration: 2000,
          });
        });
    },
    
  
    // 点击测试记录
    navigateToRecord() {
      wx.redirectTo({
        url: '/pages/Record/profile', // 跳转到测试记录页面
      });
    },
      // 处理导航点击事件
    navigateTo(event: { currentTarget: { dataset: { page: any; }; }; }) {
      const page = event.currentTarget.dataset.page;
      this.setData({
        selected: page
      });

      // 根据选中的项导航到不同的页面
      if (page === 'main') {
        wx.redirectTo({ url: '/pages/Main/profile' });
      } else if (page === 'record') {
        wx.redirectTo({ url: '/pages/Record/profile' });
      } else if (page === 'user') {
        wx.redirectTo({ url: '/pages/UserInformation/profile' });
      }
    }
  });
  