//
//  main.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 07.04.2025.
//

import Foundation

var cosoleView = ConsoleView(
    controller: BookConsoleController(
    service: BookShelfServiceImpl(
    repository: CoreDataBookRepository())))

cosoleView.run()
