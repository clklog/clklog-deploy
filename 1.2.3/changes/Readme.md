# 版本信息

- 产品名称：ClkLog
- 产品型号：社区版
- 代码版本号：V1.2.3
- 版本发布时间：2026-06-15

# 升级说明

升级前版本号：1.2.2
当前版本号：1.2.3

## 升级步骤

### 一、Docker升级说明

#### 1、更新编排文件

修改clklog-api的镜像为`registry.cn-shanghai.aliyuncs.com/clklog/api:1.2.3`.

修改clklog-init的镜像为`registry.cn-shanghai.aliyuncs.com/clklog/init:1.2.3`.

### 二、源码升级说明

#### 2.1 更新clklog-api服务

1) 目录已添加-，视情况修改目录名
2) 复制新的jar包至安装目录
3) 更新application.yml配置
4) 重命名服务文件为/etc/systemd/system/clklog-api.service，指向无版本号的jar包

#### 2.2 更新clklog-init服务

1) 目录已添加-，视情况修改目录名
2) 复制新的jar包至安装目录
3) 更新application.yml配置
4) 重命名服务文件为/etc/systemd/system/clklog-init.service，指向无版本号的jar包
