package com.eight.evaluation.common;

import com.auth0.jwt.exceptions.TokenExpiredException;

import com.eight.evaluation.entity.Result;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@ControllerAdvice()
@RestController
@ResponseBody
public class GlobalExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(RuntimeException.class)
    public Result<String> RuntimeException(RuntimeException ex) {
        log.warn("出现异常:{}", ex.getMessage());
        ex.printStackTrace();
        return Result.error(400, ex.getMessage());
    }


}
