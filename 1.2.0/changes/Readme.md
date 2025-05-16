# 版本信息

- 产品名称：ClkLog
- 产品型号：社区版
- 代码版本号：V1.2.0
- 版本发布时间：2025-05-16

# 升级说明

升级前版本号：1.1.0
当前版本号：1.2.0

## 升级步骤

### 一、Docker升级说明

#### 1、更新编排文件

a. 拷贝以下编排文件到服务器上

- [docker-compose-clklog-full-base.yml](../docker-compose/docker-compose-clklog-full-base.yml)
- [docker-compose-clklog-simple-base.yml](../docker-compose/docker-compose-clklog-simple-base.yml)

b. 更新编排文件

先备份以下文件

- docker-compose-clklog-full.yml
- docker-compose-clklog-simple.yml

再覆盖新的编排文件

- [docker-compose-clklog-full.yml](../docker-compose/docker-compose-clklog-full.yml)
- [docker-compose-clklog-simple.yml](../docker-compose/docker-compose-clklog-simple.yml)


#### 2、更新环境变量

在原.env文件中添加以下内容

```shell
#[Mysql]
MYSQL_ROOT_PASSWORD=5Hzyiy4RBfxM
```

#### 3、更新ui的配置

在服务器上的clklog_dc_config/ui/config.js里添加BASE_API_MANAGE.

参考 [config.js](../docker-compose/clklog_dc_config/ui/config.js)

#### 4 更新processing的配置

在服务器上的clklog_dc_config/processing/config.properties里添加以下内容

```shell
redis.database=0
redis.pool.max-active=3
redis.pool.max-idle=3
redis.pool.min-idle=0
redis.pool.max-wait=-1
```
配置项值依据实际情况修改.

可以移除服务器上的clklog_dc_config/iplib目录下的txt文件.

#### 5 更新clickhouse的配置

此步可以选做,涉及数据库的日志级别及用户配置,非强制更新.

用[clickhouse](../docker-compose/clklog_dc_config/clickhouse) 覆盖服务器上的同目录，并删除clklog_dc_config/clickhouse/config.xml.

#### 6 更新manage的配置

将[manage](../docker-compose/clklog_dc_config/manage) 文件夹拷贝到服务器上的clklog_dc_config目录下.

#### 7 更新gateway的配置

更新clklog_dc_config/gateway/full/default.conf和clklog_dc_config/gateway/simple/default.conf的内容如下:

- 变更clklog_api_server和clklog_receiver_server的端口为8080.
- 添加以下内容.

```

upstream clklog_manage_server {
    server clklog-manage:8080;
}
```

server节点部分添加以下内容：

```
	location /manage/ {
		proxy_pass http://clklog_manage_server/;
		proxy_set_header Host $host:$server_port;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	}

	location /manage/v3/ {
		proxy_pass http://clklog_manage_server/manage/v3/;
		proxy_set_header Host $host:$server_port;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	}

```

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
