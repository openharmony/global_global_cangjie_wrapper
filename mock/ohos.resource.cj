/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

package ohos.resource

import ohos.base.*
import ohos.labels.APILevel

@OverflowWrapping
protected func getResourceLength(res: AppResource): Length {
    LengthMetrics(1.0)
}

protected func getResourceColor(res: AppResource): Color {
    Color(0x00000000)
}

protected func getResourceString(res: AppResource): String {
    ""
}

protected func getResourceMedia(res: AppResource): String {
    ""
}

@!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
public class AppResource <: Length & ResourceColor & ResourceStr {
    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var bundleName: String

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var moduleName: String

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var id: UInt32

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var params: ?Array<Any>

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var resType: ?Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public init(
        bundleName: String,
        moduleName: String,
        id: UInt32,
        params!: ?Array<Any> = None,
        resType!: ?Int32 = None
    ) {
        super()
        this.bundleName = String()
        this.moduleName = String()
        this.id = 0
        this.params = None
        this.resType = None
    }
}