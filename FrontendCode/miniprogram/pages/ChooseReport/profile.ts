import { GetSingleQuestion } from "../../api/API"; 
Page({
  data: {
    questionNo: -1,  // 当前题目的编号（根据需要调整）
    questionName: '',  // 当前题目的内容
    questionChoiceA: '',  // 选项A
    questionChoiceB: '',  // 选项B
    questionChoiceC: '',  // 选项C
    questionChoiceD: '',  // 选项D
    isFirstQuestion: false,  // 是否是第一题
    isLastQuestion: false,  // 是否是最后一题
    trueQuestionAnswer:'',//题目正确答案
    AnswerIsCorrect:'',//用户的答案是否正确
    UserAnswer:'',
    testId:-1,
  },
  onLoad: function (options) {

    // 如果 options.questionNo 存在，则转换为数字，否则使用默认值 -1
    const questionNo = options.questionNo ? parseInt(options.questionNo, 10) : -1;
    const testId = options.testId ? parseInt(options.testId, 10) : -1;

    console.log("questionNo is ",questionNo);
    console.log("testId is ",testId);
    if(questionNo === 1){
      this.setData({
        isFirstQuestion:true,
      })
    }
    if(questionNo === 10){
      this.setData({
        isLastQuestion:true,
      })
    }
    // 将 questionNo 存储到页面的 data 中
    // 更新数据状态
    this.setData({
      questionNo: questionNo,
      testId:testId,
    });
    
    console.log('接收到的题目编号:', questionNo);

    // 区分答题模式和回顾模式

      const questions = wx.getStorageSync('currentQuestionData');
      this.setData({
        questionName: questions.questionName,  // 题目内容
        questionChoiceA: questions.questionChoiceA,  // 选项A
        questionChoiceB: questions.questionChoiceB,  // 选项B
        questionChoiceC: questions.questionChoiceC,  // 选项C
        questionChoiceD: questions.questionChoiceD,  // 选项D
        UserAnswer:  questions.everytestUserAnswer,//用户所选答案
        trueQuestionAnswer: questions.questionAnswer,//题目正确答案
      });
       // 根据用户的选择和正确答案来设置每个选项的样式
       this.setOptionStyles();
  },

  setOptionStyles: function() {
    const { trueQuestionAnswer, UserAnswer } = this.data;
    console.log("trueQuestionAnswer is ", trueQuestionAnswer);  // 确认正确答案
    console.log("UserAnswer is ", UserAnswer);  // 确认用户答案
  
    const options = ['A', 'B', 'C', 'D'];
    options.forEach(option => {
      let className = '';  // 初始为空
  
      // 判断是否是正确答案，赋予正确答案样式
      if (option === trueQuestionAnswer) {
        className = 'correct'; // 正确答案样式
      }
  
      // 判断如果是错误答案，并且用户选错了，赋予错误答案样式
      if (option === UserAnswer && UserAnswer !== trueQuestionAnswer) {
        className = 'incorrect'; // 错误答案样式
      }
  
      console.log(`${option}Class: ${className}`);  // 输出每个选项的 className
  
      // 设置每个选项的样式
      this.setData({
        [`${option}Class`]: className,  // 动态更新每个选项的样式
      });
    });
  },
  
  
  
  

  

  // 返回按钮的点击事件
   // 注意:退出之后是直接提交的
   goBack: function() {
    const { testId } = this.data;  // 从页面数据中获取 testId
    wx.redirectTo({
      url: `/pages/Result/profile?testId=${testId}`, // 使用反引号进行插值
    });
    return;
},
  

  goPrevious: async function () {
    const { testId } = this.data;
    let { questionNo } = this.data; // 改为 let，这样可以重新赋值

    if (questionNo >= 2) {
      questionNo = questionNo - 1;
    }

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
  },

  // 处理下一题或提交按钮的点击事件
  // 处理下一题或提交按钮的点击事件
  goNext: async function () {
    const { testId } = this.data;
    let { questionNo } = this.data; // 改为 let，这样可以重新赋值
  
    if (questionNo <= 9) {
      questionNo = questionNo + 1 ;
    }
  
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
  },
  Chatgpt: function(){
    wx.showToast({
      title: '此功能正在开发中',
      icon: 'none',
    });
  } 

});
