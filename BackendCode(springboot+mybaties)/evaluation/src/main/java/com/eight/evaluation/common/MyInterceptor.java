package com.eight.evaluation.common;

import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.eight.evaluation.utils.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.sql.Date;
import java.text.SimpleDateFormat;

@Component
public class MyInterceptor implements HandlerInterceptor {

    private static final Logger log = LoggerFactory.getLogger(MyInterceptor.class);

    @Override


    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        //过滤OPTIONS请求
        if (HttpMethod.OPTIONS.toString().equals(request.getMethod())) {
            return true;
        }

        /*
        校验用户是否登录
         */

        String token = request.getHeader("token");
        if (token == null) {
            log.info("用户未登录");
            response.setStatus(401);
            return false;
        }

        //System.out.println("reader:"+request.getReader());
        //System.out.println("handler:"+handler);

        if (!JwtUtil.checkToken(token)) {
            log.info("用户未登录");
            response.setStatus(401);
            return false;
        }


        // 获取请求时间
        long startTime = System.currentTimeMillis();
        request.setAttribute("startTime", startTime); // 将请求时间存入请求属性中以备后续使用
        String formattedTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(startTime));

        // 获取请求的方法和URL
        String method = request.getMethod(); // GET, POST, etc.
        String requestURI = request.getRequestURI(); // 请求的URI
        String queryString = request.getQueryString(); // 请求的查询参数

        // 获取客户端IP地址
        String clientIP = request.getRemoteAddr();

        // 打印请求信息
        System.out.println("===== 请求信息 =====");
        System.out.println("请求时间: " + formattedTime);
        System.out.println("请求方法: " + method);
        System.out.println("请求URI: " + requestURI);
        if (queryString != null) {
            System.out.println("查询参数: " + queryString);
        }
        System.out.println("客户端IP: " + clientIP);

        // 获取请求头
        System.out.println("===== 请求头信息 =====");
        request.getHeaderNames().asIterator().forEachRemaining(headerName -> {
            System.out.println(headerName + ": " + request.getHeader(headerName));
        });
        System.out.println("---------------------------");

        // 如果需要校验某些条件，可以在此返回 false 以中断请求
        return true; // 返回 true 继续处理请求
    }

//    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//
//        //过滤OPTIONS请求
//        if (HttpMethod.OPTIONS.toString().equals(request.getMethod())) {
//            return true;
//        }
//
//        /*
//        校验用户是否登录
//         */
//
////        String token = request.getHeader("token");
////        if(token == null){
////            log.info("用户未登录");
////            response.setStatus(401);
////            return false;
////        }
////
//        System.out.println("reader:"+request.getReader());
//        System.out.println("handler:"+handler);
////
////        if(!JwtUtil.checkToken(token)){
////            log.info("用户未登录");
////            response.setStatus(401);
////        }
//        return true;

//    }

//
//    @Override
//    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {
//        System.out.println("postHandle: " + request.getRequestURI());
//    }

//    @Override
//    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
//        System.out.println("afterCompletion: " + request.getRequestURI());
//    }
}
