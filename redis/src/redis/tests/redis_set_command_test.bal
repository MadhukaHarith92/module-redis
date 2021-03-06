// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/test;
import ballerina/java;

@test:Config {
}
function testSAdd() {
    var result = conn->sAdd("testSAddKey", ["testSAddValue3", "testSAddValue4", "testSAddValue5"]);
    if (result is int) {
        test:assertEquals(result, 3);
        test:assertTrue(sisMember(java:fromString("testSAddKey"), java:fromString("testSAddValue3")));
        test:assertTrue(sisMember(java:fromString("testSAddKey"), java:fromString("testSAddValue4")));
        test:assertTrue(sisMember(java:fromString("testSAddKey"), java:fromString("testSAddValue5")));
    } else {
        test:assertFail(io:sprintf("Error from Connector: %s - %s", result.reason(),
        <string>result.detail()["message"]));
    }
}

@test:Config {
}
function testSDiff() {
    var result = conn->sDiff(["testSDiffKey1", "testSDiffKey2"]);
    if (result is string[]) {
        test:assertEquals(result.length(), 2);
        test:assertTrue((result[0] == "Three" && result[1] == "Four") || (result[0] == "Four" && result[1] == "Three"));
    } else {
        test:assertFail(io:sprintf("Error from Connector: %s - %s", result.reason(),
        <string>result.detail()["message"]));
    }
}

@test:Config {
}
function testSDiffStore() {
    var result = conn->sDiffStore("testSDiffStoreDestKey", ["testSDiffKey1", "testSDiffKey2"]);
    if (result is int) {
        test:assertEquals(result, 2);
        test:assertTrue(sisMember(java:fromString("testSDiffStoreDestKey"), java:fromString("Three")));
        test:assertTrue(sisMember(java:fromString("testSDiffStoreDestKey"), java:fromString("Four")));
    } else {
        test:assertFail(io:sprintf("Error from Connector: %s - %s", result.reason(),
        <string>result.detail()["message"]));
    }
}

@test:Config {
}
function testSInter() {
    var result = conn->sInter(["testSInterKey1", "testSInterKey2"]);
    if (result is string[]) {
        test:assertTrue((result[0] == "One" && result[1] == "Two") || (result[0] == "Two" && result[1] == "One"));
    } else {
        test:assertFail(io:sprintf("Error from Connector: %s - %s", result.reason(),
        <string>result.detail()["message"]));
    }
}

@test:Config {
}
function testSInterStore() {
    var result = conn->sInterStore("testSInterDestKey", ["testSInterKey1", "testSInterKey2"]);
    if (result is int) {
        test:assertEquals(result, 2);
        test:assertTrue(sisMember(java:fromString("testSInterDestKey"), java:fromString("One")));
        test:assertTrue(sisMember(java:fromString("testSInterDestKey"), java:fromString("Two")));
        test:assertFalse(sisMember(java:fromString("testSInterDestKey"), java:fromString("Three")));
        test:assertFalse(sisMember(java:fromString("testSInterDestKey"), java:fromString("Four")));
    } else {
        test:assertFail(io:sprintf("Error from Connector: %s - %s", result.reason(),
        <string>result.detail()["message"]));
    }
}

@test:Config {
}
function testSIsMember() {
    var result = conn->sIsMember("testSIsMemberKey", "testSIsMemberValue");
    if (result is boolean) {
        test:assertTrue(result);
    } else {
        test:assertFail(io:sprintf("Error from Connector: %s - %s", result.reason(),
        <string>result.detail()["message"]));
    }
}

@test:Config {
}
function testSMembers() {
    var result = conn->sMembers("testSMembersKey");
    if (result is string[]) {
        test:assertEquals(result.length(), 3);
    } else {
        test:assertFail(io:sprintf("Error from Connector: %s - %s", result.reason(),
        <string>result.detail()["message"]));
    }
}

@test:Config {
}
function testSPop() {
    var result = conn->sPop("testSPopKey", 2);
    if (result is string[]) {
        test:assertEquals(result.length(), 2);
        test:assertFalse(sisMember(java:fromString("testSPopKey"), java:fromString(result[0])));
        test:assertFalse(sisMember(java:fromString("testSPopKey"), java:fromString(result[1])));
    } else {
        test:assertFail(io:sprintf("Error from Connector: %s - %s", result.reason(),
        <string>result.detail()["message"]));
    }
}

@test:Config {
}
function testSRandMember() {
    var result = conn->sRandMember("testSRandMemberKey", 2);
    if (result is string[]) {
        test:assertEquals(result.length(), 3);
    } else {
        test:assertFail(io:sprintf("Error from Connector: %s - %s", result.reason(),
        <string>result.detail()["message"]));
    }
}

@test:Config {
}
function testSRem() {
    var result = conn->sRem("testSRemKey", ["testSRemValue1", "testSRemValue3"]);
    if (result is int) {
        test:assertEquals(result, 2);
        test:assertFalse(sisMember(java:fromString("testSRemKey"), java:fromString("testSRemValue1")));
        test:assertFalse(sisMember(java:fromString("testSRemKey"), java:fromString("testSRemValue3")));
    } else {
        test:assertFail(io:sprintf("Error from Connector: %s - %s", result.reason(),
        <string>result.detail()["message"]));
    }
}

@test:Config {
}
function testSUnion() {
    var result = conn->sUnion(["testUnionKey1", "testUnionKey2"]);
    if (result is string[]) {
        test:assertEquals(result.length(), 4);
    } else {
        test:assertFail(io:sprintf("Error from Connector: %s - %s", result.reason(),
        <string>result.detail()["message"]));
    }
}

@test:Config {
}
function testSUnionStore() {
    var result = conn->sUnionStore("testSUnionStoreDestKey", ["testUnionKey1", "testUnionKey2"]);
    if (result is int) {
        test:assertEquals(result, 4);
        test:assertTrue(sisMember(java:fromString("testSUnionStoreDestKey"), java:fromString("testUnionValue1")));
        test:assertTrue(sisMember(java:fromString("testSUnionStoreDestKey"), java:fromString("testUnionValue2")));
        test:assertTrue(sisMember(java:fromString("testSUnionStoreDestKey"), java:fromString("testUnionValue3")));
        test:assertTrue(sisMember(java:fromString("testSUnionStoreDestKey"), java:fromString("testUnionValue4")));
    } else {
        test:assertFail(io:sprintf("Error from Connector: %s - %s", result.reason(),
        <string>result.detail()["message"]));
    }
}

function setupRedisSetDatabase() = @java:Method {
    name: "setupSetDatabase",
    class: "org.ballerinalang.redis.utils.RedisDbUtils"
} external;
