[TOC]

# 升级步骤

## 一. 数据库变更

### 1.1 mysql

#### 1.1.1 系统相关表更新

- [mysql_clklog.sql](../docker-compose/clklog_dc_config/init/mysql_clklog.sql)


### 1.2 ClickHouse表

下列对应的sql文件导入`clklog`库中

[clickhouse-update.sql](clickhouse-update.sql)


