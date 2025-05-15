use clklog;

alter table log_analysis add column app_crashed_reason Nullable(String);

CREATE TABLE crashed_detail_bydate
(
    `stat_date` Date COMMENT '统计日期',
    `lib` String COMMENT '终端平台',
    `project_name` String COMMENT '项目名',
    `app_version` String COMMENT 'app版本',
    `model` String COMMENT '品牌',
    `visit_count` UInt32 DEFAULT 0 COMMENT '访问次数',
    `crashed_count` UInt32 DEFAULT 0 COMMENT '崩溃次数',
    `uv` UInt32 DEFAULT 0 COMMENT '访问用户数',
    `crashed_uv` UInt32 DEFAULT 0 COMMENT '崩溃触发用户数',
    `ip_count` UInt32 DEFAULT 0 COMMENT '崩溃触发用户ip数',
    `update_time` DateTime COMMENT '更新时间'
)
ENGINE = ReplacingMergeTree
PARTITION BY stat_date
ORDER BY (lib, project_name, app_version, model)
SETTINGS index_granularity = 8192
