# 全球化子系统<a name="ZH-CN_TOPIC_0000001115837954"></a>

## 简介<a name="section11660541593"></a>

当OpenHarmony系统/应用在全球不同区域使用时，系统/应用需要满足不同市场用户关于语言、文化习俗的需求。全球化子系统提供支持多语言、多文化的能力，包括：

-   **资源管理能力**

    根据设备类型、系统配置等信息，对系统资源和应用资源加载、解析和初始化，对外提供获取字符串、媒体等资源的接口。

-   **国际化能力**

    提供底层的资源回溯能力，同时对外提供丰富的国际化接口，包括时间日期格式化、数字格式化、电话号码格式化、单复数等。


## 系统架构<a name="section1558604311012"></a>

**图 1**  全球化子系统架构图<a name="fig87184592416"></a>  


![](figures/全球化子系统架构图.png "全球化子系统架构图")

## 目录<a name="section161941989596"></a>

全球化子系统源代码在/base/global目录下。

```
base/global/global_cangjie_api
├── ohos             # 仓颉全球化接口实现
├── kit              # 仓颉kit化代码
├── figures          # 存放readme中的架构图
```

## 相关仓<a name="section1371113476307"></a>

**全球化子系统**

global_cangjie_api

[global\_i18n](https://gitee.com/openharmony/global_i18n)
