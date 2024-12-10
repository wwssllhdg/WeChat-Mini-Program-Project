import { ShowTrainscript } from '../../api/API.js';
import { GetSingleQuestion } from '../../api/API.js';
//import * as echarts from 'echarts-for-weixin'; // 引入ECharts


Page({
  data: {
    testId:-1,
    testScore: 0,
    testLevel: 0,
    testEvaluation: '',
    questions: [],
    selectedIndex: -1, // 用于保存选中索引，初始值为 -1
  },

  // 页面加载时调用获取成绩单
  onLoad: function (options) {
    const testId = options.testId ? parseInt(options.testId, 10) : -1;
    console.log("testId is ",testId);
    this.fetchTranscript();
    this.setData({
      testId: testId,
    });
    console.log('接收到的测试编号:', testId);
    this.fetchTranscript();
   
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
          testEvaluation: res.data.testEvaluation,
          questions: res.data.question,
          testLevel:res.data.testLevel,
        });
            // 计算正确和错误的数量
        const correctCount = res.data.question.filter((item: { everytestIsCorrect: number; }) => item.everytestIsCorrect === 1).length;
        const totalCount = res.data.question.length;

        // 绘制图表
        this.drawChart(correctCount, totalCount);
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


  async onCircleClick(e: { currentTarget: { dataset: { questionNo: any; index: any; }; }; }) {
    const questionNo = e.currentTarget.dataset.questionNo;
    const index = e.currentTarget.dataset.index;
    const { testId, selectedIndex } = this.data;
  
    // 如果点击的索引与当前选中索引相同，则跳转
    if (selectedIndex === index) {
      try {
        // 获取题目详情
        const res = await GetSingleQuestion({ testId, questionNo });
  
        if (res.code === 200) {
          const questionData = res.data; // 获取返回的题目数据
  
          // 本地存储数据
          wx.setStorageSync('currentQuestionData', questionData);
  
          // 判断题目类型，根据 everytestType 判断跳转页面
          const targetPage = questionData.everytestType === 1 ? 'ChooseReport' : 'JudgeReport';
  
          // 跳转到对应的页面并传递参数
          wx.redirectTo({
            url: `/pages/${targetPage}/profile?questionNo=${questionNo}&testId=${testId}`,
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
    } else {
      // 第一次点击，设置当前选中索引
      this.setData({
        selectedIndex: index,
      });
    }
  },
  

  // 返回
  goBack() {
    wx.redirectTo({
      url: '/pages/Record/profile',
    });
  },
  goBack1() {
    wx.redirectTo({
      url: '/pages/Main/profile',
    });
  },
  drawChart(correctCount: number, totalCount: number) {
    const context = wx.createCanvasContext('accuracyChart', this);
  
    // 设置圆心和半径
    const centerX = 75; // 圆心 X 坐标
    const centerY = 75; // 圆心 Y 坐标
    const radius = 60;  // 圆弧半径
    const lineWidth = 15; // 线宽
  
    // 计算正确和错误的比例
    const correctRatio = correctCount / totalCount;
    const incorrectRatio = 1 - correctRatio;
  
    // 起始角度为 0，计算正确部分的角度（以弧度计算）
    const startAngle = 0;
    const correctEndAngle = startAngle + correctRatio * 2 * Math.PI;
  
    // 绘制正确部分（绿色部分）
    context.beginPath();
    context.arc(centerX, centerY, radius, startAngle, correctEndAngle, false);
    context.lineWidth = lineWidth;
    context.setStrokeStyle('#a4ed8e'); // 绿色
    context.stroke();
  
    // 绘制错误部分（红色部分）
    context.beginPath();
    context.arc(centerX, centerY, radius, correctEndAngle, startAngle + 2 * Math.PI, false);
    context.lineWidth = lineWidth;
    context.setStrokeStyle('#ff4d4f'); // 红色
    context.stroke();
  
    // 绘制完成
    context.draw();
  }
  

});
