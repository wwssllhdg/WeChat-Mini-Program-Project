package com.eight.evaluation.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Base64;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class ImageUtil {

    // 将图像文件转换为字节数组
    public static byte[] convertImageToBytes(String imagePath) {
        File file = new File(imagePath);
        try (FileInputStream imageInFile = new FileInputStream(file)) {
            byte[] imageData = new byte[(int) file.length()];
            imageInFile.read(imageData);
            return imageData;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
