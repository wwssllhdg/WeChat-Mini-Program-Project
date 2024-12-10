import { ShowTrainscript } from '../../api/API.js';
Page({
    data:{
        testId:-1, 
        testScore: 0,
    },

    onLoad: function (options) {
    
        const testId = options.testId ? parseInt(options.testId, 10) : -1;
        
    // 更新数据状态
    this.setData({
        testId: testId,
      });
    this.fetchTranscript();
    },
    // 查看成绩单的方法
    viewTranscript: function () {
        const testId = wx.getStorageSync('testId'); // 获取测试 ID
        // 提交成功后跳转到结果页面
        wx.redirectTo({
            url: `/pages/Result/profile?testId=${testId}`,
        });
    },
  
    // 返回首页的方法
    returnHome: function () {
      wx.redirectTo({
        url: '/pages/Main/profile',  // 修改为你的首页路径
      });
    },
      // 请求成绩单数据
  async fetchTranscript() {
    try {
      const { testId } = this.data;  // 从页面数据中获取 testId
      const res = await ShowTrainscript({testId});

      if (res.code === 200) {
        // 更新成绩数据
        this.setData({
          testScore: res.data.testScore,
        });
      } else {
        wx.showToast({
          title: '获取数据失败',
          icon: 'error',
        });
      }
    } catch (error) {
      console.error('请求失败', error);
    }
  },
  });
  