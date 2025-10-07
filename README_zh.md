# 全球化仓颉封装（beta特性）

## 简介

在OpenHarmnoy平台上，全球化仓颉封装为开发者提供了使用仓颉语言进行应用开发时所需的全球化相关的能力。OpenHarmony系统/应用在全球不同区域使用时，系统/应用需要满足不同市场用户关于语言、文化习俗的需求。全球化仓颉提供支持多语言、多文化的能力，包括：

- **资源管理能力**

  根据设备类型、系统配置等信息，对应用资源加载、解析和初始化，对外提供获取字符串、媒体等资源的接口。

- **国际化能力**

  提供底层的资源回溯能力，同时对外提供丰富的国际化接口，包括日历功能等。

当前开放的全球化仓颉接口仅支持standard设备。

## 系统架构

**图 1** 全球化仓颉架构图

![全球化仓颉架构图](figures/global_cangjie_wrapper_architecture.png)

如架构图所示：

接口层：

- 国际化接口：提供获取和设置日历属性的能力。
- 资源管理接口：提供获取应用资源的能力，以及获取应用偏好语言能力。

框架层：

- 国际化封装：仓颉国际化相关功能的实现封装，提供获取和设置日历属性的能力。
- 资源管理封装：仓颉资源管理的实现封装，提供资源管理和系统配置能力。

架构图中的依赖部件引入说明：

- 国际化部件：负责提供国际化基础功能，封装C语言接口提供给仓颉进行互操作。
- 资源管理组件：负责提供资源管理基础功能，封装C语言接口提供给仓颉进行互操作。
- cangjie_ark_interop：负责提供仓颉注解类定义，用于对API进行标注，以及提供抛向用户的BusinessException异常类定义。
- ArkUI开发框架：负责提供Resource相关FFI接口，用于操作应用资源。
- arkui_cangjie_wrapper：负责提供ResourceColor等接口定义，用于实现AppResource类。
- hiviewdfx_cangjie_wrapper：负责提供日志接口，用于在关键路径处打印日志。

## 目录

```
base/global/global_cangjie_wrapper
├── figures                   # 存放README中的架构图
├── kit                       # 仓颉LocalizationKit的kit化代码
│   └── LocalizationKit
├── ohos                      # 仓颉全球化接口实现
│   ├── BUILD.gn
│   ├── i18n                  # 国际化相关接口实现
│   └── resource_manager      # 资源管理相关接口实现
└── test                      # 仓颉全球化测试用例
    ├── i18n                  # 国际化测试用例
    └── resource_manager      # 资源管理测试用例
```

## 使用说明

全球化仓颉接口提供了以下功能接口：

- 日历提供获取和设置日历属性的能力，如时间，时区等。
- 资源管理提供应用资源获取的能力。
- 系统配置提供获取应用偏好语言能力。

全球化相关API请参见：
1. [国际化](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/LocalizationKit/cj-apis-i18n.md)
2. [资源管理](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/LocalizationKit/cj-apis-resource_manager.md)

相关指导请参见[国际化开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/tree/master/doc/Dev_Guide/source_zh_cn/internationalization)和[资源管理开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/resource-manager/cj-resource-manager.md)。

## 约束

与ArkTS提供的API能力相比：

- 国际化暂不支持以下功能：
  - 日期格式化、数字格式化、排序。

- 资源管理暂不支持以下功能：
  - 区域管理、电话号码处理、文本处理、时区和节假日管理等功能。
  - 跨线程传输资源对象。

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[arkui_ace_engine](https://gitcode.com/openharmony/arkui_ace_engine)

[arkui_arkui_cangjie_wrapper](https://gitcode.com/openharmony-sig/arkui_arkui_cangjie_wrapper)

[global_i18n](https://gitcode.com/openharmony/global_i18n)

[global_resource_management](https://gitcode.com/openharmony/global_resource_management)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)
