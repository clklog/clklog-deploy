| **版权所有**     | ClkLog     |
| :--------------- | :--------- |
| **产品型号**     | 社区版     |
| **代码版本号**   | V1.2.0     |
| **版本发布时间** | 2025-05-16 |

[TOC]

# [环境准备说明](../docs/preparation.md)

# [应用部署说明](../docs/preparation.md)

# 升级说明

升级前版本号：1.1.0
升级后版本号：1.2.0

## 升级步骤

### 一、Docker升级说明

### 1、

### 2、

### 3、

### 二、源码升级说明

#### 1、安装mysql数据库

源码安装需要手动安装mysql，[mysql安装步骤参考](../docs/preparation.md#mysql-安装参考)

#### 2、 数据库变更

##### 2.1 创建mysql数据库及相关表

根据下列mysql脚本创建数据库脚本如下

- [mysql_clklog.sql](../docker-compose/clklog_dc_config/init/mysql_clklog.sql)

##### 2.2 变更ClickHouse表

将下列sql文件导入`clklog`库中

- [clickhouse-update.sql](clickhouse-update.sql)

##### 更新相关服务

##### 3.1 部署计算脚本调度任务（clklog-init） 服务

- 通过clklog-init服务代替原来的使用Cron来进行任务的定时调度计算脚本clklog-scripts。

- clklog-init服务部署完成后移除原来的Cron的定时调度任务。

- [clklog-init服务详细部署步骤参考](../docs/deployment.md#3-部署初始化服务-clklog-init)

##### 3.2 部署clklog-manage服务

- clklog-manage服务是ClkLog的管理接口，提供clklog-ui前端项目管理、账号管理及数据清洗过滤配置相关接口。

- [clklog-manage服务详细部署步骤参考](../docs/deployment.md#4部署管理接口-clklog-manage)

##### 3.3 更新clklog-api服务

1) 目录已添加-，视情况修改目录名
2) 复制新的jar包至安装目录
3) 更新application.yml配置
4) 重命名服务文件为/etc/systemd/system/clklog-api.service，指向无版本号的jar包

##### 3.4 更新clklog-receiver服务

1) 目录已添加-，视情况修改目录名
2) 复制新的jar包至安装目录
3) 更新application.yml配置
4) 重命名服务文件为/etc/systemd/system/clklog-receiver.service，指向无版本号的jar包

##### 3.5 更新clklog-processing服务

1) 目录已添加-，视情况修改目录名
2) 复制新的jar包至安装目录
3) 更新config.properties配置
4) 修改相应flink启动命令

##### 3.6 更新clklog-ui服务

1) 修改config.js，配置您的域名
2) 复制替换旧文件
