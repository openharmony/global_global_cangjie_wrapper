# 全球化仓颉接口

## 简介

全球化仓颉接口是在 OpenHarmony 上基于全球化子系统能力之上封装的仓颉API。当OpenHarmony系统/应用在全球不同区域使用时，系统/应用需要满足不同市场用户关于语言、文化习俗的需求。全球化仓颉提供支持多语言、多文化的能力，包括：

-   **资源管理能力**

    根据设备类型、系统配置等信息，对系统资源和应用资源加载、解析和初始化，对外提供获取字符串、媒体等资源的接口。

-   **国际化能力**

    提供底层的资源回溯能力，同时对外提供丰富的国际化接口，包括日历功能等。


## 系统架构

**图 1**  全球化仓颉架构图


![](figures/global_cangjie_wrapper_architecture.png "全球化仓颉架构图")

## 目录

```
base/global/global_cangjie_wrapper
├── ohos             # 仓颉全球化接口实现
├── kit              # 仓颉kit化代码
├── figures          # 存放readme中的架构图
```

## 约束

当前开放的全球化仓颉接口仅支持standard设备。

## 使用说明

如架构图所示，全球化仓颉接口提供了以下功能接口，开发者可以根据使用诉求，综合使用一类或多类接口：

  - 资源管理模块提供系统和应用资源获取的能力。
  - i18n模块提供获取应用偏好语言，支持日历相关功能。

与ArkTS相比，暂不支持以下功能：

  - Intl模块相关能力。
  - 区域管理、电话号码处理、文本处理、时区和节假日管理等功能。

全球化相关API请参见：
1. [ohos.i18n](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/LocalizationKit/cj-apis-i18n.md)
2. [ohos.resource_manager](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/LocalizationKit/cj-apis-resource_manager.md)

相关指导请参见[国际化开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/tree/master/doc/Dev_Guide/source_zh_cn/internationalization)。

## 相关仓

[global_i18n](https://gitee.com/openharmony/global_i18n)

[global_resource_management](https://gitee.com/openharmony/global_resource_management)

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。
