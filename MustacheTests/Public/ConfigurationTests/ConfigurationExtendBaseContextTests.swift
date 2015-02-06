//
//  ConfigurationExtendBaseContextTests.swift
//
//  Created by Gwendal Roué on 05/11/2014.
//  Copyright (c) 2014 Gwendal Roué. All rights reserved.
//

import XCTest
import Mustache

class ConfigurationExtendBaseContextTests: XCTestCase {
   
    func testConfigurationExtendBaseContextWithValue() {
        var configuration = Configuration()
        configuration.registerInBaseContext("name", Box("Arthur"))
        let repository = TemplateRepository()
        repository.configuration = configuration
        let template = repository.template(string: "{{name}}")!
        
        var rendering = template.render()!
        XCTAssertEqual(rendering, "Arthur")
        
        rendering = template.render(Box(["name": "Bobby"]))!
        XCTAssertEqual(rendering, "Bobby")
    }
    
    func testConfigurationExtendBaseContextWithProtectedObject() {
        // TODO: import test from che
    }
    
    func testConfigurationExtendBaseContextWithWillRenderFunction() {
        let willRender = { (tag: Tag, box: MustacheBox) -> MustacheBox in
            return Box("delegate")
        }
        var configuration = Configuration()
        configuration.extendBaseContext(Box(willRender))
        let repository = TemplateRepository()
        repository.configuration = configuration
        let template = repository.template(string: "{{name}}")!
        let rendering = template.render()!
        XCTAssertEqual(rendering, "delegate")
    }
}