// import { TokenOutTime } from '../../api/API.js'; // 根据你的路径导入
// 全局请求封装
const base_url = 'http://106.54.212.158:8888';
//const token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3MzI5MzMzNjcsInVzZXJJRCI6IjIzIiwidGltZXN0YW1wIjoiMTczMjkzMzMwNzA4OCJ9.KtnUbk2ImplqfpI03kmwazQwxJXDWnDrRj26K3wByhc';
//默认导出 js里只有先导出一个模块，才能在别处使用此模块
export default (params) => {
  let url = params.url;
  //从传入的 params 对象中提取 url 属性，并将其赋值给变量 url。这个 url 是你请求的具体路径或API地址
  //{ url: '/api/user' }
  let method = params.method || "GET";//若没有传入method，则默认为GET方法
  let data = params.data || {};//如果 params 中没有提供 data，则默认使用一个空对象 {}
  let header = {};

  if (method == "POST") {
    header = {
      'content-type': 'application/json'
    };
  }

  // 获取本地token
  const token = wx.getStorageSync("token");
  if (token) {
    header['token'] =  token;
  }
 //Token 通常是 服务器 在用户登录成功后发放给客户端的
 //Token 可以类比为一个 临时的用户ID
 
 
 //Promise 会接受 wx.request 的结果，并根据请求的结果调用 resolve 或 reject
 //resolve 表示操作成功   reject 表示操作失败
  return new Promise((resolve, reject) => {
    wx.request({
      url: base_url + url,
      method: method,
      header: header,
      
//通过 wx.getStorageSync("token") 获取本地存储中的 token（如果有的话）。如果 token 存在，就将 //Authorization 字段添加到 header 中，并将 token 以 Bearer <token> 的形式放在 Authorization 字段里。Bearer 是一种常用的认证方式，表示这是一个持有者令牌（即 token）。

      data: data,
      success(response) {

        console.log("请求成功，response：", response); // 查看完整的响应数据
        if (response.statusCode === 401) {
          console.log("token过期");    
          wx.showToast({
            title: '登录过期,请重新登录',
            icon: 'none',
            duration: 2000 // 设置持续时间为 2 秒
          });
        
          // 延迟跳转，等待 2 秒后再执行跳转
          setTimeout(() => {
            // 清除本地缓存的 token 和用户信息
            wx.removeStorageSync('token');
            wx.removeStorageSync('subjectId');
            wx.removeStorageSync('testId');
            wx.removeStorageSync('questions');
            wx.removeStorageSync('userAnswers');
            wx.removeStorageSync('currentQuestionData');   
            wx.removeStorageSync('userId');
            wx.removeStorageSync('subject');
            wx.removeStorageSync('userLogo');
            // wx.removeStorageSync('userInfo');
            // 跳转到登录页面
            wx.navigateTo({
              url: '/pages/Log/profile' // 修改为你的登录页路径
            });
          }, 2000);
        }else{
          console.log("token尚未过期");       
          const res = response.data;
          console.log("响应数据：", res);       
          resolve(res);
        }
      },
      fail(err) {
        console.log(err);
        if (err.errMsg.indexOf('request:fail') !== -1) {
          wx.showToast({
            title: '网络异常',
            icon: "error",
            duration: 2000
          });
        } else {
          wx.showToast({
            title: '未知异常',
            duration: 2000
          });
        }
        reject(err);
      },
      complete() {
        wx.hideLoading();
        wx.hideToast();
      }
    });
  }).catch((e) => {});
};

