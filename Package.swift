// swift-tools-version:5.1
//
//  Package.swift
//  CombineLocalizer
//
//  Created by Vladislav on 21.12.2019.
//  Copyright (c) Vlad Khambir
//

import PackageDescription

let package = Package(
    name: "CombineLocalizer",
    
    platforms: [
        .iOS(.v10),
        .tvOS(.v10),
        .macOS(.v10_12),
        .watchOS(.v3)
    ],
    products: [
        .library(name: "CombineLocalizer", targets: ["CombineLocalizer"])
    ],
    targets: [
         .target(name: "CombineLocalizer", path: "Source")
    ]
)
