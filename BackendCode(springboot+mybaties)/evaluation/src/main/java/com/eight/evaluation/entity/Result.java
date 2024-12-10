package com.eight.evaluation.entity;



import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 通用返回对象
 * @param <T>
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Result<T> {
    private int code;        // 状态码
    private String msg;  // 提示消息
    private T data;         // 返回的数据

    // 成功的响应
    public static <T> Result<T> success(T data) {
        return new Result<>(200, "success", data);
    }

    // 失败的响应
    public static <T> Result error(String message) {
        return new Result<>(500, message, null);
    }
    //自定义失败响应
    public static <T> Result<T> error(int code, String  message) {
        return new Result<>(code,message,null);
    }


}