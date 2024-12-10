import { SubmitQuestionAnswer } from "../../api/API"; 
Page({
  data: {
    userAnswers: [], // 用于存储所有题目答案
    selectedOption: '',  // 存储当前选中的选项
    questionNo: -1,  // 当前题目的编号（根据需要调整）
    questionName: '',  // 当前题目的内容
    questionProgress: '',  // 题目进度，例如 1/10
    isFirstQuestion: false,  // 是否是第一题
    isLastQuestion: false,  // 是否是最后一题
    UserAnswer:'',
    testId:-1,
    subjectName:"",
  },
  onLoad: function (options) {
 
    // 如果 options.questionNo 存在，则转换为数字，否则使用默认值 -1
    const questionNo = options.questionNo ? parseInt(options.questionNo, 10) : -1;


    const testId = options.testId ? parseInt(options.testId, 10) : -1;
    
    const subjectId: number = wx.getStorageSync('subjectId') || 1;

    const subjectMap: { [key: number]: string } = {
      1: 'C语言基础',
      4: 'Python程序设计',
      3: 'Java程序设计',
      2: '数据结构'
    };
    
    // 根据 subjectId 获取对应的 subjectName
    const subjectName = subjectMap[subjectId] || '未知科目';

    // 更新数据状态
    this.setData({
      questionNo: questionNo,
      testId: testId,
      subjectName: subjectName
    });

    console.log('接收到的题目编号:', questionNo);
    console.log('当前科目名称:', subjectName);


      const questions = wx.getStorageSync('questions');
    
      // 检查题目编号有效性，防止越界
      if (questions && questionNo > 0 && questionNo <= questions.length) {
        const question = questions[questionNo - 1];
        
        // 更新页面显示的题目内容和选项
        this.setData({
          questionName: question.questionName,  // 题目内容
        });
      }
      // 初始化已选择答案
      const userAnswers = wx.getStorageSync('userAnswers') || {};
      const selectedOption = userAnswers[questionNo] || ''; // 如果没有已存答案，默认为空
      this.setData({ selectedOption });
      // 处理题目进度和按钮状态
      this.setData({
        questionProgress: `${questionNo}/10`,  // 显示题目进度
        isFirstQuestion: questionNo === 1,  // 是否是第一题
        isLastQuestion: questionNo === 10,  // 是否是最后一题
      });
    
  },

  
  // 选择某个选项
  selectOption: function (e: { currentTarget: { dataset: { option: any; }; }; }) {

    const selected = e.currentTarget.dataset.option; // 获取选中的选项（A/B/C/D）
  
    // 更新当前选中的选项
    this.setData({
      selectedOption: selected, // 更新选中的选项
    });
  
    // 保存当前答案到本地存储
    const { questionNo } = this.data; // 获取当前题号
    const userAnswers = wx.getStorageSync('userAnswers') || {}; // 获取或初始化用户答案
    userAnswers[questionNo] = selected; // 更新答案
    wx.setStorageSync('userAnswers', userAnswers); // 保存到本地存储
  
    console.log(`已保存答案: 题号 ${questionNo}, 选择 ${selected}`);
  
    // 更新选项的选中效果
    this.updateSelectedOption();
  },
  

  // 更新选项选中效果
  updateSelectedOption: function() {
    const selectedOption = this.data.selectedOption;

    // 清除所有选项的选中状态
    const options = ['True', 'False'];
    options.forEach(option => {
      this.setData({
        [`${option}Class`]: option === selectedOption ? 'selected' : '',  // 判断当前选项是否被选中
      });
    });
  },

  // 返回按钮的点击事件
  goBack: function() {

    const answered = Object.keys(wx.getStorageSync('userAnswers') || {}).length; // 获取已答题目数
    const total = wx.getStorageSync('questions').length; // 获取题目总数
    const remaining = total - answered; // 剩余题目数
    console.log("answered is ",answered)
    console.log("total is ",total)
    console.log("remaining is ",remaining)
    wx.showModal({
      title: '退出测评',
      content: `注意: 中途退出将结束测评\n您当前已答${answered}题，剩余${remaining}题。`,
      success: (res) => {
        if (res.confirm) {
          // 用户确认退出时，清除本地存储的答题记录
        wx.removeStorageSync('userAnswers'); // 清除用户答案
        wx.removeStorageSync('questions'); // 清除题目数据
        wx.removeStorageSync('testId'); // 如果有其他存储的测试相关数据，也一并清除
          // 如果用户确认退出，提交全部答案并返回主界面
          wx.navigateBack();
        }
        // 如果用户取消退出，什么都不做
      }
    });
  },
  

  goPrevious: function () {

    this.saveCurrentAnswer();

    const questions = wx.getStorageSync('questions');
    let { questionNo } = this.data;
    console.log("questionNo is  ",questionNo)
    if (questionNo > 1) {
      questionNo -= 1;
      if(questions[questionNo-1].everytestType == 0){
        console.log("题目类型为判断题")
        wx.redirectTo({
          url: `/pages/Judge/profile?questionNo=${questionNo}`,
        });
      }else{
        console.log("题目类型为选择题")
        wx.redirectTo({
          url: `/pages/Choose/profile?questionNo=${questionNo}`,
        });
      }
     
    }
  },

  // 处理下一题或提交按钮的点击事件
  goNext: function () {

    this.saveCurrentAnswer();
    const questions = wx.getStorageSync('questions');
    let { questionNo } = this.data;
     console.log("questionNo is  ",questionNo)
    if (questionNo < 10) {
      questionNo += 1;
      if(questions[questionNo-1].everytestType == 0){
        console.log("题目类型为判断题")
        wx.redirectTo({
          url: `/pages/Judge/profile?questionNo=${questionNo}`,
        });
      }else{
        console.log("题目类型为选择题")
        wx.redirectTo({
          url: `/pages/Choose/profile?questionNo=${questionNo}`,
        });
      }
  }
},
  //需要给用户一个提示语
  //先进行判断，看用户是否全部答完，如果全部答完
  //确定要提交所有答案吗
  //确认提交  |  我再想想
  //

  //如果有题目没有答完
  //提示:
  //您已答X题，未答X题
  //跳转未答  |  直接提交

  submitAnswer: function () {

    const testId = wx.getStorageSync('testId'); // 获取测试 ID
    const userAnswers = wx.getStorageSync('userAnswers') || {}; // 获取用户答案对象
    const totalQuestions = wx.getStorageSync('questions').length; // 获取题目总数

    
    const userAnswerArray: string[] = []; // 用于存储最终的答案数组
    
    // 遍历每一道题，构建答案数组
    for (let i = 1; i <= totalQuestions; i++) {
      let answer = userAnswers[i] || ''; // 默认未答为空字符串
      
      // 判断答案类型是判断题（T/F）还是选择题（C）
      if (answer === 'True') {
        userAnswerArray.push('T'); // 判断题答案是 'T'
      } else if (answer === 'False') {
        userAnswerArray.push('F'); // 判断题答案是 'F'
      } else if (answer === '') {
        userAnswerArray.push(''); // 未答题目
      } else {
        userAnswerArray.push(answer); // 选择题或其他答案
      }
    }
  
    // 提交答案到服务器
      wx.showModal({
        title: '提交确认',
        content: '确定要提交所有答案吗？',
        success: (res) => {
          if (res.confirm) {
            SubmitQuestionAnswer({
              testId,
              userAnswer: userAnswerArray
            })
            .then((response) => {
              if (response.code === 200) {
                wx.showToast({
                  title: '答案提交成功',
                  icon: 'success',
                  duration: 2000,
                });
                console.log('提交的答案:', { testId, userAnswer: userAnswerArray });
                wx.removeStorageSync('userAnswers'); // 清除用户答案
                wx.removeStorageSync('questions'); // 清除题目数据
                // 提交成功后跳转到结果页面    
                wx.redirectTo({
                  url: `/pages/FinishTest/profile?testId=${testId}`,
                });
              } else {
                wx.showToast({
                  title: '提交失败',
                  icon: 'none',
                  duration: 2000,
                });
              }
            })
            .catch((error) => {
              console.error('提交答案出错:', error);
              wx.showToast({
                title: '提交失败，请稍后重试',
                icon: 'none',
                duration: 2000,
              });
            });
          }
        },
      });

  },
  
saveCurrentAnswer: function () {
  const { selectedOption, questionNo } = this.data;

  // 检查用户是否已选择答案
  if (!selectedOption) {
    console.log(`题号: ${questionNo}, 未选择答案`);
    return; // 未选择答案时直接返回
  }

  // 获取或初始化本地存储的答案
  const userAnswers = wx.getStorageSync('userAnswers') || {};

  // 更新答案
  userAnswers[questionNo] = selectedOption;

  // 存储更新后的答案到本地
  wx.setStorageSync('userAnswers', userAnswers);

  console.log(`已保存答案: 题号 ${questionNo}, 选择 ${selectedOption}`);
},



  onShow: function() {
    // 页面显示时初始化已选择答案的状态
    this.updateSelectedOption();  // 更新选中效果
  },
 
});
