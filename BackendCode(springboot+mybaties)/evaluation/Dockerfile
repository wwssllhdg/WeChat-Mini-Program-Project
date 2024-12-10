#FROM openjdk:17-jdk-slim
### saltice-sc-admin-1.0-SNAPSHOT.jar是我项目打包后生成的可运行的jar
### saltice-sc.jar 是在构建镜像里面的名称，就是把前面那个文件从上下文目录放到了镜像里面的根目录去了
#ADD target/evaluation-0.0.1-SNAPSHOT.jar demo.jar
#MAINTAINER SaltIce
## 暴露端口
#EXPOSE 8888
### 运行命令组装一下啦
#ENTRYPOINT ["java", "-Dfile.encoding=utf-8", "-jar", "demo.jar"]
#FROM openjdk:17-jdk-slim
#
#MAINTAINER SaltIce
#
## 暴露端口
#EXPOSE 8888
#
## 直接运行宿主机路径下挂载到容器的文件
#ENTRYPOINT ["java", "-Dfile.encoding=utf-8", "-jar", "/home/app/evaluation-0.0.1-SNAPSHOT.jar"]


# 使用官方基础镜像
FROM openjdk:17-jdk-slim

# 设置工作目录
WORKDIR /app

# 暴露应用使用的端口
EXPOSE 8888

# 设置启动命令
CMD ["java", "-jar", "/app/demo.jar"]

