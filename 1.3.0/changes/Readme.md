# 版本信息

- 产品名称：ClkLog
- 产品型号：社区版
- 代码版本号：V1.3.0
- 版本发布时间：2026-06-18

# 升级说明

升级前版本号：V1.2.3
当前版本号：V1.3.0

## 升级步骤

### 一、Docker升级说明

#### 1、更新编排文件

修改clklog-api的镜像为`registry.cn-shanghai.aliyuncs.com/clklog/api:1.3.0`.

修改clklog-manage的镜像为`registry.cn-shanghai.aliyuncs.com/clklog/manage:1.3.0`.

修改clklog-ui的镜像为`registry.cn-shanghai.aliyuncs.com/clklog/ui:1.3.0`.

### 二、源码升级说明

#### 2.1 更新clklog-api服务

1) 目录已添加-，视情况修改目录名
2) 复制新的jar包至安装目录
3) 更新application.yml配置
4) 重命名服务文件为/etc/systemd/system/clklog-api.service，指向无版本号的jar包

#### 2.2 更新clklog-manage服务

1) 目录已添加-，视情况修改目录名
2) 复制新的jar包至安装目录
3) 更新application.yml配置
4) 重命名服务文件为/etc/systemd/system/clklog-manage.service，指向无版本号的jar包

#### 2.3 更新clklog-ui服务

1) 重新打包ui.

### 三、升级数据库

1) 在mysql客户端执行[mysql_clklog.sql](..%2Fdocker-compose%2Fclklog_dc_config%2Finit%2Fmysql_clklog.sql)里的`tbl_api_key`建表语句.
