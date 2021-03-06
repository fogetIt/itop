##### 简档
- 管理员
    - Administrator
        - 查看所有菜单，创建、修改所有表单
        - **管理工具、iTop Hub** 菜单对普通用户不展示
- （只）允许调用 `REST Web` 服务
    - REST Services User
- 门户用户
    - Portal user
        - 含 `Portal user` 账户 **只能** 访问门户页面（创建工单，查看、操作指派给自己的工单）
        - 非 `Portal user` 账户对 **能看到的** 菜单中的列表都有查看数据的权限
- 增强门户用户
    - Portal power user
        - 查看所有工单的权限
        - 不能单独设置，必须和其它简档一起使用
- 表单操作权限
    - （所有） **变更管理** 的表单操作权限（创建、修改、指派 `change`）
        - Change Approver
            - 变更审批人
        - Change Implementor
            - 变更执行人
        - Change Supervisor
            - 变更主管
    - （只有） **配置管理 / 文档** 的表单操作权限
        - Document author
    - （所有） **配置管理、数据管理** 的表单操作权限（创建、修改组织、团队、联系人、文档）
        - Configuration Manager
    - （所有） **问题管理** 的表单操作权限 （创建、修改、指派 `problem`）
        - Problem Manager
    - （所有） **Helpdesk、Incident** 的表单操作权限（创建、修改、指派工单）
        - Service Desk Agent
            - 负责创建事件
        - Support Agent
            - 负责分析和解决事件
    - （所有） **服务管理** 的表单操作权限 （创建、修改各种服务）
        - Service Manager


##### 账户配置
- 数据管理 / 组织（部门架构）
    - 配置管理 / 联系人（实际用户）
        - 管理工具 / 用户账户（登录角色）
            - 管理工具 / 简档（权限组合）
- 用户注销登录后，修改的简档才能生效


##### 工单流转
```
iTop “服务提供商”组织和“客户”组织都通过“客户合同”链接，该合同基于一些定义了服务协议的服务。
```
1. 设置服务提供商组织：
    - 创建服务提供商组织（数据管理 / 组织）
        - 定义该组织提供的服务（服务管理 / 服务）
            - 为这些服务创建 Service families
                - 为这些服务创建一些子服务（categories）
                - 为这些服务创建一些服务协议（SLA）
                    - 为 SLA 创建一些服务时间标准（SLT）
                        - 拥有时间（TTO）：创建故障单 ～ 分配给代理
                        - 解决时间（TTR）：创建故障单 ～ 解决故障
        - 为服务提供商组织创建支持团队（配置管理 / 联系人）
            - 团队用户账户设置简档为 `Support Agent`
2. 设置客户组织：
    - 创建客户组织（数据管理 / 组织）
        - 为客户组织中创建联系人（配置管理 / 联系人）
            - 为客户联系人创建用户帐户（管理工具 / 用户帐户）
                - 后台用户设置简档为 `Service Desk Agent` （一般不需要）
                - 门户用户设置简档为 `Portal user` ，部门负责人可加上 `Portal power user`
        - 为客户组织创建交付模型（Delivery models，定义了客户可以指派的团队，记录关键人物的角色）
    - 创建客户合同（服务管理 / 客户合同）
        - 选择相应的客户和服务提供商组织
        - 从供应商组织中选择支持团队，附加 SLA 以便将客户与所需服务相关联


##### 邮件通知
- 管理工具 / 通知 / 触发器 / 创建一个触发器
    - on entering a state
        - 在某个给定类对象进入某个特定状态前将触发（状态转换）
    - on leaving a state
        - 在某个给定类对象离开某个特定状态时将触发
    - on object creation
        - 当某个特定类对象创建时将触发
    - on threshold
        - 在某个给定的服务解决时间或者服务响应时间到达时将触发
    - when updated from the portal
        - 在某个给定的门户工单更新时将触发
- 触发器过滤语句（非必须，需要了解 itop 源码，根据数据库字段定义查询语句）
- 触发器状态码
    - entering/leaving a state 需要定义 state（表单中的状态字段选项）
- 管理工具 / 通知 / 动作 / 创建一个新的 Email 通知
    - 定义邮件内发送的内容
        - 邮件内容可以配置为 php 变量，获取、发送动态信息


##### 仪表盘
- 在任意一个菜单抽屉的 overview （总览）里，右上角铅笔图标 / 编辑这个页面，里面可以增加、删除、自定义图表展示。
