import { ShowAllTestRecord } from '../../api/API.js';

const BUTTONS_PER_GROUP = 5;

interface BackendItem {
  testId: number;
  testScore: number;
  testTime: string;
  index?: number;
}

Page({
  data: {
    selectedIndex: 0,               // 当前选中的圆形索引
    Buttons: [] as BackendItem[],
    swiperButtons: [] as BackendItem[][],
    selectedSubject: 1,             // 默认选中 C语言，对应 subjectId = 1
    selectedTestTime: '',           // 当前选中测试的时间
    selectedTestScore: '',          // 当前选中测试的得分
    testCount: 0,                   // 测试次数
    averageScore: 0,                // 平均分
    subjectName: '',       // 科目名称
    currentSwiperIndex: 0,          // 当前 swiper 显示的分组索引
    chartContainerWidth: 0,         // 图表容器宽度
    scrollLeft: 0,                  // 控制 scroll-view 的滚动位置

  },
  

  onLoad() {
    // 从本地存储获取 subjectId，如果没有，则使用默认值 1（C语言）
    const subjectId = wx.getStorageSync('subjectId') || 1;
    this.setData({ selectedSubject: subjectId });

    this.loadTestRecords(subjectId);
  },

 

  onTabSelect(e: { currentTarget: { dataset: { subjectId: string } } }) {
    const subjectId = parseInt(e.currentTarget.dataset.subjectId, 10);
  
    this.setData({
      selectedSubject: subjectId,
      selectedTestTime: '',
      selectedTestScore: '',
      testCount: 0,
      averageScore: 0,
      Buttons: [],
      swiperButtons: [],
      scrollLeft: 0,
    });
  
    wx.setStorageSync('subjectId', subjectId);
  
    // 重新加载数据
    this.loadTestRecords(subjectId);
  },
  
  
  /**
   * 根据 subjectId 返回科目名称
   */
getSubjectName(subjectId: number): string {
  const subjectMap: { [key: number]: string } = {
    1: 'C语言',
    4: 'Python',
    3: 'Java',
    2: '数据结构'
  };

  return subjectMap[subjectId] || '未知科目';
},


  /**
   * 加载测试记录数据
   * @param subjectId 当前选中的科目ID
   */
  loadTestRecords(subjectId: number) {
    const userId = wx.getStorageSync('userId');
    ShowAllTestRecord({ subjectId, userId })
      .then((res) => {
        if (res.code === 200 && res.data.length > 0) {
          // 正常情况：有测试记录
          this.processBackendData(res.data);
  
          const testCount = res.data.length;
          const totalScore = res.data.reduce((sum: any, item: { testScore: any; }) => sum + item.testScore, 0);
          const averageScore = parseFloat((totalScore / testCount).toFixed(2));
  
          this.setData({
            currentSwiperIndex: 0,
            selectedIndex: 0,
            selectedTestTime: formatTestTime(res.data[0].testTime),
            selectedTestScore: res.data[0].testScore,
            testCount: testCount,
            averageScore: averageScore,
            subjectName: this.getSubjectName(subjectId),
          });
  
          // 提取分数和标签用于图表
          const scores = res.data.map((item: { testScore: any; }) => item.testScore);
          const labels = res.data.map((_: any, index: number) => `测试${index + 1}`);
  
          // 动态绘制图表
          this.drawChart(scores, labels);
        } else {
          // 无测试记录情况，清空图表
          this.setData({
            Buttons: [],
            swiperButtons: [],
            testCount: 0,
            averageScore: 0,
            selectedTestTime: '',
            selectedTestScore: '',
            subjectName: this.getSubjectName(subjectId),
          });
  
          // 清空图表
          this.clearChart();
        }
      })
      .catch((error) => {
        console.error('请求失败：', error);
        this.setData({
          Buttons: [],
          swiperButtons: [],
          testCount: 0,
          averageScore: 0,
          selectedTestTime: '',
          selectedTestScore: '',
        });
        this.clearChart();
      });
  },
  clearChart() {
    const context = wx.createCanvasContext('scoreChart');
    context.clearRect(0, 0, 400, 200); // 清空画布区域
    context.draw();                   // 渲染空白画布
  },
  

  
  onCircleTap(e: { currentTarget: { dataset: { index: number, testId: number, testScore: number, testTime: string } } }) {
    const { index, testId, testScore, testTime } = e.currentTarget.dataset;
  
    // 如果当前点击的按钮已被选中，跳转到具体测试页面
    if (this.data.selectedIndex === index) {
      wx.navigateTo({
        url: `/pages/Result/profile?testId=${testId}`,
      });
      return;
    }
  
    // 更新选中的索引和测试信息
    this.setData({
      selectedIndex: index,
      selectedTestScore: testScore.toString(),
      selectedTestTime: formatTestTime(testTime),
    });
  },
  

  /**
   * 处理后端数据
   * @param data 后端返回的数据
   */
  processBackendData(data: BackendItem[]) {
    const buttonsData = data.map((item, index) => ({ ...item, index }));
    const swiperData = this.groupButtons(buttonsData, BUTTONS_PER_GROUP);

    this.setData({
      Buttons: buttonsData,
      swiperButtons: swiperData,
    });
  },

  /**
   * 将按钮数据分组
   */
  groupButtons(buttons: BackendItem[], groupSize: number): BackendItem[][] {
    const grouped = [];
    for (let i = 0; i < buttons.length; i += groupSize) {
      grouped.push(buttons.slice(i, i + groupSize));
    }
    return grouped;
  },

  /**
   * 返回主页面
   */
  goBack() {
    wx.redirectTo({
      url: '/pages/Main/profile',
    });
  },


  drawChart(scores: number[], labels: string[]) {
    const context = wx.createCanvasContext('scoreChart');
    const dataCount = scores.length;  
    const pointWidth = 55; // 每个数据点宽度，比如 80px

    this.setData({
      chartContainerWidth: dataCount * pointWidth, // 动态计算容器宽度
    });
    // 图表起始位置和高度
    const stepX = 50;  // 每个点之间的水平间距
    const startX = 40; // 起始X坐标
    const startY = 180; // 起始Y坐标
    const chartHeight = 120; // 图表高度
    
    // 清除画布
    context.clearRect(0, 0, 400, 200);
  
    // 绘制网格线和Y轴标签
    context.setStrokeStyle("#e0e0e0");
    context.setLineWidth(1);
    for (let i = 0; i <= 5; i++) {
      let y = startY - (i * (chartHeight / 5));
      context.beginPath();
      context.moveTo(startX, y);
      context.lineTo(startX + stepX * (scores.length - 1), y);
      context.stroke();
      context.setFontSize(12);
      context.setFillStyle("#666");
      context.fillText((20 * i).toString(), 10, y + 5);
    }
  
    // 绘制X轴标签
    labels.forEach((label, index) => {
      context.setFontSize(12);
      context.setFillStyle("#666");
      context.fillText(label, startX + index * stepX - 15, startY + 20);
    });
  
    // 绘制坐标轴
    context.setStrokeStyle("#333");
    context.setLineWidth(2);
    context.beginPath();
    context.moveTo(startX, startY);
    context.lineTo(startX + stepX * (scores.length - 1), startY);
    context.moveTo(startX, startY);
    context.lineTo(startX, startY - chartHeight);
    context.stroke();
  
    // 绘制折线图
    context.setStrokeStyle("#007bff");
    context.setLineWidth(2);
    context.beginPath();
  
    scores.forEach((score, index) => {
      const x = startX + index * stepX;
      const y = startY - (score / 100) * chartHeight;
  
      if (index === 0) {
        context.moveTo(x, y);
      } else {
        context.lineTo(x, y);
      }
    });
  
    context.stroke();
  
    // 绘制数据点
    scores.forEach((score, index) => {
      const x = startX + index * stepX;
      const y = startY - (score / 100) * chartHeight;
  
      context.beginPath();
      context.arc(x, y, 4, 0, 2 * Math.PI);
      context.setFillStyle("#007bff");
      context.fill();
      context.stroke();
  
      // 显示分数
      context.setFontSize(12);
      context.setFillStyle("#333");
      context.fillText(score.toString(), x - 10, y - 10);
    });
  
    context.draw();
  },

  
});
/**
 * 将 UTC 时间字符串转换为 YYYY/MM/DD 格式
 * @param utcString UTC 格式的时间字符串
 * @returns 格式化后的日期字符串
 */
function formatTestTime(utcString: string): string {
  const date = new Date(utcString);

  const year = date.getUTCFullYear();
  const month = (date.getUTCMonth() + 1).toString().padStart(2, '0'); // 月份是从 0 开始的
  const day = date.getUTCDate().toString().padStart(2, '0');

  return `${year}/${month}/${day}`;
}
