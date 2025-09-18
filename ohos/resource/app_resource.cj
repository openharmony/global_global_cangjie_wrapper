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

package ohos.resource

import ohos.ffi.*
import std.collection.*
import ohos.base.*
import ohos.labels.*
import std.deriving.Derive

/**
 * Contains resource descriptor information.
 *
 * @relation export interface Resource
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Global.ResourceManager"
]
public class AppResource <: Length & ResourceColor & ResourceStr {
    /**
     * bundle name in hap
     *
     * @relation bundleName: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public let bundleName: String
    /**
     * module name in hap
     *
     * @relation moduleName: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public let moduleName: String
    /**
     * resource id in hap
     *
     * @relation id: number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public let id: UInt32
    /**
     * Set params.
     *
     * @relation params?: any[]
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public let params: ?Array<Any>
    /**
     * Set type.
     *
     * @relation type?: number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public let resType: ?Int32

    /**
     * AppResource constructor.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public init(
        bundleName: String,
        moduleName: String,
        id: UInt32,
        params!: ?Array<Any> = None,
        resType!: ?Int32 = None
    ) {
        this.bundleName = bundleName
        this.moduleName = moduleName
        this.id = id
        this.params = params
        this.resType = resType
    }

    protected init(ret: CResource) {
        this.bundleName = ret.bundleName.toString()
        this.moduleName = ret.moduleName.toString()
        this.id = ret.resId
        this.params = None
        this.resType = None
    }
}

@C
protected struct CResource {
    protected let bundleName: CString
    protected let moduleName: CString
    protected let resId: UInt32

    protected init(resource: AppResource) {
        unsafe {
            this.bundleName = LibC.mallocCString(resource.bundleName)
            try {
                this.moduleName = LibC.mallocCString(resource.moduleName)
            } catch (e: Exception) {
                LibC.free(this.bundleName)
                throw e
            }
        }
        this.resId = resource.id
    }

    protected func free(): Unit {
        unsafe {
            LibC.free(this.bundleName)
            LibC.free(this.moduleName)
        }
    }
}