//
//  CoreDataService.swift
//  CoreData-Names
//
//  Created by User on 13.11.2022.
//

import Foundation
import CoreData

class CoreDataService {

    static let shared = CoreDataService()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData_Names")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchUsers() -> [Person] {
        var persons: [Person] = []
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            persons =  try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return persons
    }

    func savePerson(withName name: String) {
        let context = persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Person", in: context) else {
            print("Error while getting entity")
            return
        }
        let personObject = Person(entity: entity, insertInto: context)
        personObject.name = name
        saveContext()
    }

    func delete(person: Person) {
        persistentContainer.viewContext.delete(person)
        saveContext()
    }

    func updatePerson(withName name: String, date: Date?, gender: String?, image: Data?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        if let persons = try? persistentContainer.viewContext.fetch(fetchRequest) as? [Person], !persons.isEmpty {
            guard let requiredPerson = persons.first else { return }
            requiredPerson.setValue(name, forKey: "name")
            requiredPerson.setValue(date, forKey: "dateOfBirth")
            requiredPerson.setValue(gender, forKey: "gender")
            requiredPerson.setValue(image, forKey: "image")
            try? persistentContainer.viewContext.save()
        }
    }
}
