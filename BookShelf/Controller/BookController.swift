//
//  BookController.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 08.04.2025.
//

import Foundation

struct BookConsoleController : Controller {
    
    private var service : BookShelfService
    
    init(service : BookShelfService) {
            self.service = service
    }
    
    func filterBook(){
        
        print("Можете ввести id для фильтрации")
        print("> ", terminator: "")
        
        var id: UUID?
        
        if let input = readLine() {
            if let _id = UUID(uuidString: input){
                id = _id
            }
        }
        
        print("Можете ввести title для фильтрации")
        print("> ", terminator: "")
        
        var title: String?
        
        if let input = readLine() {
            if (!input.isEmpty){
                title = input
            }
        }
        
        print("Можете ввести author для фильтрации")
        print("> ", terminator: "")
        
        var author: String?
        
        if let input = readLine() {
            if (!input.isEmpty){
                author = input
            }
        }
        
        print("Можете ввести publicationYear для фильтрации")
        print("> ", terminator: "")
        
        var publicationYear : UInt64?
        
        if let publicationYearStr = readLine() {
            if let year = UInt64(publicationYearStr){
                publicationYear = year
            }
        }
        
        print("Можете ввести genre для фильтрации (fiction, nonFiction,mystery,sciFi,biography)")
        print("> ", terminator: "")
        
        var genre: Genre?
        
        if let input = readLine() {
            if (!input.isEmpty){
                switch stringToGenre(str: input){
                case .success(let g):
                    genre=g
                case .failure(_):
                  ()
                }
            }
        }
        
        print("Можете ввести typeBook для фильтрации (simple,comic,study)")
        print("> ", terminator: "")
        
        var type: TypeBook?
        
        if let input = readLine() {
            if (!input.isEmpty){
                switch stringToBookType(str: input){
                case .success(let g):
                    type=g
                case .failure(_):
                  ()
                }
            }
        }
        
        print("Можете ввести courseNumber для фильтрации")
        print("> ", terminator: "")
        
        var courseNumber : UInt64?
        
        if let publicationYearStr = readLine() {
            if let year = UInt64(publicationYearStr){
                courseNumber = year
            }
        }
        
        print("Можете ввести publicationNumber для фильтрации")
        print("> ", terminator: "")
        
        var publicationNumber : UInt64?
        
        if let publicationYearStr = readLine() {
            if let year = UInt64(publicationYearStr){
                publicationNumber = year
            }
        }
        
        
        
        let responce  = service.filter(request: FilterBookRequest(id: id, title: title, author: author, publicationYear: publicationYear, genre: genre, type: type, courseNumber: courseNumber, publicationNumber: publicationNumber))
        
        if let error = responce.error {
            print("Статус: \(responce.status) Ошибка \(error)\n")
        }
        else{
            print("Статус: \(responce.status)\n")
        }
        for b in responce.books{
            print(b)
        }
    }
    
    mutating func deleteBook(){
        print("Введите id книги")
        print("> ", terminator: "")
        
        guard let input = readLine(), !input.isEmpty else {
            print("Пустой ввод. Попробуйте еще раз.\n")
            return deleteBook()
        }
        
        guard let id = UUID(uuidString: input) else {
            print("Некорректный ввод. Пожалуйста, введите uuid.\n")
            return deleteBook()
        }
        let responce = service.delete(request: DeleteBookRequest(id: id))
        if let error = responce.error {
            print("Статус: \(responce.status) Ошибка \(error)\n")
        }
        else{
            print("Статус: \(responce.status)\n")
        }
        
    }
    
    func getBook(){
        let responce  = service.get(request: GetBookRequest())
        if let error = responce.error {
            print("Статус: \(responce.status) Ошибка \(error)\n")
        }
        else{
            print("Статус: \(responce.status)\n")
        }
        for b in responce.books{
            print(b)
        }
        
    }
    
    mutating func addBook(){
        
        print("Введите название")
        print("> ", terminator: "")
        
        guard let title = readLine(), !title.isEmpty else {
            print("Пустой ввод. Попробуйте еще раз.\n")
            return addBook()
        }
        
        print("Введите автора")
        print("> ", terminator: "")
        
        guard let author = readLine(), !author.isEmpty else {
            print("Пустой ввод. Попробуйте еще раз.\n")
            return addBook()
        }
        
        print("Можете ввести год выпуска")
        print("> ", terminator: "")
        
        var publicationYear : UInt64?
        
        if let publicationYearStr = readLine() {
            if let year = UInt64(publicationYearStr){
                publicationYear = year
            }
        }
        
        
        print("Введите жанр (fiction, nonFiction,mystery,sciFi,biography)")
        print("> ", terminator: "")
        
        guard let genreStr = readLine(), !genreStr.isEmpty else {
            print("Пустой ввод. Попробуйте еще раз.\n")
            return addBook()
        }
        
        var genre : Genre
        
        switch stringToGenre(str: genreStr){
        case .failure(let error):
            print(error)
            return addBook()
        case .success(let _genre):
            genre=_genre
        }
        
        print("Введите тип книги")
        print("0 – Обычная")
        print("1 – Комиксы")
        print("2 – Учебная")
        print("> ", terminator: "")
        
        
        
        guard let input = readLine(), !input.isEmpty else {
            print("Пустой ввод. Попробуйте еще раз.\n")
            return addBook()
        }
        
        guard let command = Int(input) else {
            print("Некорректный ввод. Пожалуйста, введите число.\n")
            return addBook()
        }
        
        var book : BookRepresentation
        
        switch command {
        case 0: do {
            book = Book(title: title, author: author, publicationYear:  publicationYear, genre: genre)
        }
            
        case 1: do {
            
            print("Введите номер выпуска")
            print("> ", terminator: "")
            guard let input = readLine(), !input.isEmpty else {
                print("Пустой ввод. Попробуйте еще раз.\n")
                return addBook()
            }
            
            guard let number = UInt64(input) else {
                print("Некорректный ввод. Пожалуйста, введите число.\n")
                return addBook()
            }
            book = ComicBook(title: title, author: author, genre: genre, publicationNumber: number)
        }
            
        case 2: do {
            
            print("Введите номер курса")
            print("> ", terminator: "")
            guard let input = readLine(), !input.isEmpty else {
                print("Пустой ввод. Попробуйте еще раз.\n")
                return addBook()
            }
            
            guard let number = UInt64(input) else {
                print("Некорректный ввод. Пожалуйста, введите число.\n")
                return addBook()
            }
            book = StudyBook(title: title, author: author, genre: genre, courseNumber: number)
        }
        default:
            print("Некорректный ввод. Пожалуйста, введите число.\n")
            return addBook()
        }
        
        book.publicationYear=publicationYear
        
        let responce  = service.add(request: AddBookRequest(book: book))
        
        
        if let error = responce.error {
            print("Статус: \(responce.status) Ошибка \(error)\n")
        }
        else{
            print("Статус: \(responce.status)\n")
        }
        
        
    }
    
    
    private func stringToGenre(str:String) -> Result<Genre,Error> {
        print(str.trimmingCharacters(in: .whitespacesAndNewlines))
        switch str.trimmingCharacters(in: .whitespacesAndNewlines) {
        case "fiction": return .success(Genre.fiction)
        case "nonFiction": return .success(Genre.nonFiction)
        case "mystery": return .success(Genre.mystery)
        case "sciFi": return .success(Genre.sciFi)
        case "biography": return .success(Genre.biography)
        default:
            return .failure(BookShelfError.enumInvalidParse("gentre Invalid Parse"))
        }
        
    }
    
    private func stringToBookType(str:String) -> Result<TypeBook,Error> {
        switch str {
        case "simple": return .success(TypeBook.simple)
        case "comic": return .success(TypeBook.comic)
        case "study": return .success(TypeBook.study)
        default:
            return .failure(BookShelfError.enumInvalidParse("type book Invalid Parse"))
        }
        
    }
}
