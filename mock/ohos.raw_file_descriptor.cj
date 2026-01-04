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

package ohos.raw_file_descriptor

import ohos.labels.APILevel

@!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
public class RawFileDescriptor {
    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var fd: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var offset: Int64

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var length: Int64
    
    public init() {
        super()
        this.fd = 0
        this.offset = 0
        this.length = 0
    }
}