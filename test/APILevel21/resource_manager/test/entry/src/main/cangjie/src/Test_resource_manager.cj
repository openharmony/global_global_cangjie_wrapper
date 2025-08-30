/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package ohos_app_cangjie_entry

import ohos.base.*
import std.unittest.testmacro.*
import ohos.arkui.state_macro_manage.r
import ohos.resource_manager.{ColorMode, AppResource, ArgsValueType, ScreenDensity, DeviceType, Direction, NumberValueType, Direction as Direct,
    RawFileDescriptor, Configuration as Config, DeviceCapability as Device}
import std.runtime.*
import std.sync.*
import std.time.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*
import ohos.business_exception.*
import ohos.resource_manager.ResourceManager
import ohos.hilog.Hilog

const RESID_INVALID: Int32 = 9001001

func getIntFromNum(num: NumberValueType): Int32 {
    return match (num) {
        case Int32Value(v) => v
        case _ => 0
    }
}

@Test
class Test_resource_manager {
    func getResourceManager(): ResourceManager {
        Global.getAbilityContext().resourceManager
    }

    override func beforeAll(): Unit {
        sleep(Duration.second)
        // wait for context initialization
    }

    override func afterAll(): Unit {
        GC()
        sleep(Duration.second)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getString() {
        let res1 = @r(app.string.EntryAbility_desc)
        let res2_1 = @r(app.string.Test_Format1)
        let res2_2 = @r(app.string.Test_Format2)
        let resx = @r(app.string.app_name)
        let resource1 = AppResource("com.example.myapplication", "entry", res1.id)
        @Expect(getResourceManager().getString(res1.id), "description")
        @Expect(getResourceManager().getString(resource1), "description")
        @Expect(getResourceManager().getStringByName("EntryAbility_desc"), "description")

       let resource2 = AppResource("com.example.myapplication", "entry", res2_2.id)
       @Expect(getResourceManager().getString(res2_1.id, ArgsValueType.Int32Value(20)), "int is 20")
       @Expect(getResourceManager().getString(resource2, ArgsValueType.Float32Value(3.14)), "float is 3.140000")
       @Expect(getResourceManager().getStringByName("Test_Format3", ArgsValueType.StringValue("abcdefg")), "string is abcdefg")
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getArrayString() {
        let res = @r(app.strarray.sizeList)
        let expect = ["small", "middle", "large", "extra large"]
        @Expect(getResourceManager().getStringArrayValue(res.id), expect)
        @Expect(getResourceManager().getStringArrayValue(res), expect)
        @Expect(getResourceManager().getStringArrayByName("sizeList"), expect)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getPluralString() {
        let res = @r(app.plural.plural_name)
        @Expect(getResourceManager().getPluralStringValue(res.id, 1), "1 test other")
        @Expect(getResourceManager().getPluralStringValue(res, 2), "2 test other")
        @Expect(getResourceManager().getPluralStringByName("plural_name", 3), "3 test other")
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getMediaContent() {
        let res = @r(app.media.startIcon)
        @Expect(getResourceManager().getMediaContent(res.id).size > 0, true)
        @Expect(getResourceManager().getMediaContent(res).size > 0, true)
        @Expect(getResourceManager().getMediaByName("startIcon").size > 0, true)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getMediaContentBase64() {
        let res = @r(app.media.startIcon)
        @Expect(getResourceManager().getMediaContentBase64(res.id).size > 0, true)
        @Expect(getResourceManager().getMediaContentBase64(res).size > 0, true)
        @Expect(getResourceManager().getMediaBase64ByName("startIcon").size > 0, true)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getBoolean() {
        let res = @r(app.boolean.boolean_1)
        @Expect(getResourceManager().getBoolean(res.id), true)
        @Expect(getResourceManager().getBoolean(res), true)
        @Expect(getResourceManager().getBooleanByName("boolean_2"), false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getNumber() {
        let res = @r(app.integer.number_1)
        @Expect(getIntFromNum(getResourceManager().getNumber(res.id)), 123)
        @Expect(getIntFromNum(getResourceManager().getNumber(res)), 123)
        @Expect(getIntFromNum(getResourceManager().getNumberByName("number_2")), 456)

        let fRes = @r(app.float.float_1)
        match (getResourceManager().getNumber(fRes.id)) {
            case Float32Value(_) => @Expect(true)
            case _ => @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getColor() {
        let res = @r(app.color.color_test1)
        @Expect(getResourceManager().getColor(res.id), 0xFFFF_00FF)
        @Expect(getResourceManager().getColor(res), 0xFFFF_00FF)
        @Expect(getResourceManager().getColorByName("color_test2"), 0xFFFF_0011)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getRawFile() {
        @Expect(getResourceManager().getRawFileContent("test.txt").size > 0, true)
        loggerInfo("raw file list = ${getResourceManager().getRawFileList("").toString()}")
        @Expect(getResourceManager().getRawFileList("").size, 2)
        let rawFd = getResourceManager().getRawFd("test.txt")
        getResourceManager().closeRawFd("test.txt")
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getConfiguration() {
        getResourceManager().getConfiguration()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getDeviceCapability() {
        getResourceManager().getDeviceCapability()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getLocales() {
        let locales = getResourceManager().getLocales()
        loggerInfo("Locales = ${locales.toString()}")
        @Expect(locales.toString(), "[zh-CN]")
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_addResource() {
        // /data/app/el2/100/base/com.example.samples/haps/entry/files/library-default-unsigned.hsp
        let path = "/data/storage/el2/base/haps/entry/files/library-default-unsigned.hsp"
        try {
            getResourceManager().addResource(path)
            @Expect(false)
        } catch (_: BusinessException) {
            @Expect(true)
        }

        try {
            getResourceManager().removeResource(path)
            @Expect(false)
        } catch (_: BusinessException) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_string() {
        let res2_1 = @r(app.string.Test_Format1)
        let res2_2 = @r(app.string.Test_Format2)
        let resource2 = AppResource("com.example.myapplication", "entry", res2_2.id)
        getResourceManager().getString(UInt32(res2_1.id), ArgsValueType.Int32Value(20))
        getResourceManager().getString(resource2, ArgsValueType.Float32Value(3.14))
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func getStringWithFormatArgs(): Unit {
        var res = @r(app.string.test1)
        try {
            getResourceManager().getString(UInt32(res.id), ArgsValueType.Float32Value(3.14))
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 9001007)
        }

        res = @r(app.string.test2)
        try {
            getResourceManager().getString(UInt32(res.id), ArgsValueType.Float32Value(3.14))
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 9001007)
        }

        res = @r(app.string.test3)
        try {
            getResourceManager().getString(UInt32(res.id), ArgsValueType.Int32Value(1))
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 9001007)
        }

        res = @r(app.string.test3)
        @Expect(getResourceManager().getString(UInt32(res.id), Array<ArgsValueType>()), "%d, %s")
    }

    @TestCase
    @Tag[APILevel20, TestLevel0]
    func getConfiguration_success(): Unit {
        let resMgr = getResourceManager()
        let config = resMgr.getConfiguration()
        @Expect(config.locale, "zh_Hans_CN")
        @Expect(config.mcc, 0)
        @Expect(config.mnc, 0)
    }
}
