//
//  CoreDataManager.swift
//  hh_clone
//
//  Created by Halil Yavuz on 22.10.2024.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteVacancies")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveVacancies(vacancies: VacancyModel) {
        let fetchRequest: NSFetchRequest<FavoriteVacancy> = FavoriteVacancy.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", vacancies.id)
        do {
            let results = try context.fetch(fetchRequest)
            if let existingTodo = results.first {
                existingTodo.lookingNumber = Int32(vacancies.lookingNumber ?? 0)
                existingTodo.vacancyName = vacancies.title
                existingTodo.vacancySalary = vacancies.salary.short
                existingTodo.vacancyCompany = vacancies.company
                existingTodo.vacancyExperience = vacancies.experience.previewText
                existingTodo.vacancyPublishedDate = vacancies.publishedDate
            } else {
                // Создаем новую запись
                let newVacancy = FavoriteVacancy(context: context)
                newVacancy.id = vacancies.id
                newVacancy.lookingNumber = Int32(vacancies.lookingNumber ?? 0)
                newVacancy.vacancyName = vacancies.title
                newVacancy.vacancySalary = vacancies.salary.short
                newVacancy.vacancyCompany = vacancies.company
                newVacancy.vacancyExperience = vacancies.experience.previewText
                newVacancy.vacancyPublishedDate = vacancies.publishedDate
            }
            
        } catch {
            print("Failed to fetch or update todo: \(error)")
        }
        saveContext()
    }
    
    // MARK: - Удаление задачи
    func deleteFavoriteVacancies(vacancies: VacancyModel) {
        let fetchRequest: NSFetchRequest<FavoriteVacancy> = FavoriteVacancy.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", vacancies.id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let todoToDelete = results.first {
                print("Deleting vacancy with id: \(vacancies.id)")
                context.delete(todoToDelete)
                saveContext()
            }
        } catch {
            print ("error: \(error)")
        }
    }
    
    // MARK: - Проверка, добавлена ли вакансия в избранное
    func isVacancyFavorite(id: String) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteVacancy> = FavoriteVacancy.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.count > 0
        } catch {
            print("Failed to check favorite status: \(error)")
            return false
        }
    }
    
    // MARK: - Сохранение изменений в Core Data
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                print("Failed to save context: \(error)")
            }
        }
    }
    
    func fetchFavoriteVacancies() -> [FavoriteVacancy] {
        let fetchRequest: NSFetchRequest<FavoriteVacancy> = FavoriteVacancy.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Ошибка при загрузке избранных вакансий: \(error)")
            return []
        }
    }
 }


