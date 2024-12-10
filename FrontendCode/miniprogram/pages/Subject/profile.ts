Page({
  data: {
    selectedSet: '', // 默认选中的题目集
    selectedSubjectId: -1, // 默认的 subjectId
  },

  onLoad(options) {
    const subjectId = options.subjectId;
    console.log('传递的 subjectId:', subjectId);
    
    // 根据 subjectId 设置 selectedSet 的值
    switch (subjectId) {
      case '1':
        this.setData({
          selectedSet: 'C语言题目集',
          selectedSubjectId: 1,
        });
        break;
      case '2':
        this.setData({
          selectedSet: '数据结构题目集',
          selectedSubjectId: 2,
        });
        break;
      case '3':
        this.setData({
          selectedSet: 'Java语言题目集',
          selectedSubjectId: 3,
        });
        break;
      case '4':
        this.setData({
          selectedSet: 'Python语言题目集',
          selectedSubjectId: 4,
        });
        break;
      default:
        // 如果 subjectId 不匹配，使用默认值
        this.setData({
          selectedSet: 'C语言题目集',
          selectedSubjectId: 1,
        });
        break;
    }
  },

  chooseSet(e: { currentTarget: { dataset: { set: any; index: any; }; }; }) {
    const selectedSet = e.currentTarget.dataset.set;
    let selectedSubjectId: number;

    // 根据选中的题目集文字来确定对应的 subjectId
    switch (selectedSet) {
      case 'C语言题目集':
        selectedSubjectId = 1;
        break;
      case '数据结构题目集':
        selectedSubjectId = 2;
        break;
      case 'Java语言题目集':
        selectedSubjectId = 3;
        break;
      case 'Python语言题目集':
        selectedSubjectId = 4;
        break;
      default:
        selectedSubjectId = 1; // 默认值
        break;
    }

    wx.showModal({
      title: '确认选择',
      content: `您确定要选择 ${selectedSet} 吗？`,
      success: (res) => {
          if (res.confirm) {
              this.setData({
                  selectedSet,
                  selectedSubjectId, // 更新选中数据
              });
                
              // 显示提示并保存数据
              wx.showToast({
                  title: `已选择 ${selectedSet}`,
                  icon: 'none',
                  duration: 2000,
              });
  
              wx.setStorageSync('subjectId', selectedSubjectId);
              console.log("选择题目集ID为:", selectedSubjectId);
          }
      },
  });
  
  },

  // 返回按钮
  goBack() {

      // 保存当前选择的 subjectId 到本地存储
      wx.setStorageSync('subjectId', this.data.selectedSubjectId);  // 保存 subjectId（数字）

      // 跳转到主页
      wx.redirectTo({
        url: '/pages/Main/profile', // 跳转到主页
      });

  },
});
