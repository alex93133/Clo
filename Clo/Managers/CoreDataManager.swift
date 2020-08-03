import CoreData
import UIKit

class CoreDataManager {

    // MARK: - Properties
    weak var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    var context: NSManagedObjectContext {
        return appDelegate!.persistentContainer.viewContext
    }

    static let shared = CoreDataManager()
    private init() {}

    // MARK: - Fetch clothes
    func fetchClothes(handler: @escaping (Result<Error>) -> Void) -> [Clothes] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Identifiers.CoreDataEntitiesName.clothesInfo)
        request.returnsObjectsAsFaults = false

        var allClothes = [Clothes]()

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                guard let creationDate = data.value(forKey: "creationDate") as? Date,
                    let typeString     = data.value(forKey: "type") as? String,
                    let colorString    = data.value(forKey: "color") as? String,
                    let info           = data.value(forKey: "info") as? String?,
                    let photoData      = data.value(forKey: "photo") as? Data,
                    let symbolsIDs     = data.value(forKey: "symbolsIDs") as? [Int]
                    else { return allClothes }

                let clothes = Clothes(creationDate: creationDate,
                                      typeString: typeString,
                                      colorString: colorString,
                                      info: info,
                                      photoData: photoData,
                                      symbolsIDs: symbolsIDs)
                allClothes.append(clothes)
            }
        } catch {
            handler(.failure(error))
        }
        handler(.success)
        return allClothes.sorted { $0.creationDate > $1.creationDate }
    }

    // MARK: - Save clothes
    func saveClothes(clothes: Clothes, handler: @escaping (Result<Error>) -> Void) {
        guard let entity = NSEntityDescription.entity(forEntityName: Identifiers.CoreDataEntitiesName.clothesInfo,
                                                      in: context) else { return }

        guard let photoData = clothes.photo.pngData() else { return }
        let arrayOfID       = clothes.symbols.map { $0.id }
        let newClothes      = NSManagedObject(entity: entity, insertInto: context)

        newClothes.setValue(clothes.creationDate, forKey: "creationDate")
        newClothes.setValue(clothes.type.rawValue, forKey: "type")
        newClothes.setValue(clothes.color.rawValue, forKey: "color")
        newClothes.setValue(clothes.info, forKey: "info")
        newClothes.setValue(photoData, forKey: "photo")
        newClothes.setValue(arrayOfID, forKey: "symbolsIDs")
        handler(appDelegate!.saveContext())
    }

    // MARK: - Delete clothes
    func deleteClothes(clothes: Clothes, handler: @escaping (Result<Error>) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Identifiers.CoreDataEntitiesName.clothesInfo)

        do {
            let result = try context.fetch(request)
            for object in result as! [NSManagedObject] {
                guard let creationDate = object.value(forKey: "creationDate") as? Date else { return }
                if creationDate == clothes.creationDate {
                    context.delete(object)
                }
            }
        } catch {
            handler(.failure(error))
        }
        handler(appDelegate!.saveContext())
    }

    // MARK: - Update clothes
    func updateClothes(editableClothes: Clothes, handler: @escaping (Result<Error>) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Identifiers.CoreDataEntitiesName.clothesInfo)
        do {
            let result = try context.fetch(request)
            for object in result as! [NSManagedObject] {
                guard let creationDate = object.value(forKey: "creationDate") as? Date else { return }
                guard let photoData = editableClothes.photo.pngData() else { return }
                if creationDate == editableClothes.creationDate {
                    let arrayOfID = editableClothes.symbols.map { $0.id }
                    object.setValue(photoData, forKey: "photo")
                    object.setValue(editableClothes.type.rawValue, forKey: "type")
                    object.setValue(editableClothes.color.rawValue, forKey: "color")
                    object.setValue(editableClothes.info, forKey: "info")
                    object.setValue(arrayOfID, forKey: "symbolsIDs")
                }
            }
        } catch {
            handler(.failure(error))
        }
        handler(appDelegate!.saveContext())
    }

    // MARK: - Save washing
    func saveWashing(washing: Washing, handler: @escaping (Result<Error>) -> Void) {
        guard let entity = NSEntityDescription.entity(forEntityName: Identifiers.CoreDataEntitiesName.washingInfo,
                                                      in: context) else { return }

        let newWashing  = NSManagedObject(entity: entity, insertInto: context)

        newWashing.setValue(washing.name, forKey: "name")
        newWashing.setValue(washing.color.rawValue, forKey: "color")
        newWashing.setValue(washing.temperature, forKey: "temperature")
        newWashing.setValue(washing.washingMode.rawValue, forKey: "washingMode")
        newWashing.setValue(washing.coincidence, forKey: "coincidence")
        newWashing.setValue(washing.creationDate, forKey: "creationDate")
        handler(appDelegate!.saveContext())
    }

    // MARK: - Fetch washing
    func fetchWashing(handler: @escaping (Result<Error>) -> Void) -> [Washing] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Identifiers.CoreDataEntitiesName.washingInfo)
        request.returnsObjectsAsFaults = false

        var allLaundries = [Washing]()

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                guard let name      = data.value(forKey: "name") as? String,
                    let color       = data.value(forKey: "color") as? String,
                    let temperature = data.value(forKey: "temperature") as? Int64,
                    let washingMode = data.value(forKey: "washingMode") as? String,
                    let coincidence = data.value(forKey: "coincidence") as? Bool,
                    let creationDate = data.value(forKey: "creationDate") as? Date

                    else { return allLaundries }

                let washing = Washing(name: name,
                                      color: color,
                                      temperature: temperature,
                                      washingMode: washingMode,
                                      coincidence: coincidence,
                                      creationDate: creationDate)

                allLaundries.append(washing)
            }
        } catch {
            handler(.failure(error))
        }
        handler(.success)
        return allLaundries.reversed()
    }

    // MARK: - Delete washing
    func deleteWashing(washing: Washing, handler: @escaping (Result<Error>) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Identifiers.CoreDataEntitiesName.washingInfo)

        do {
            let result = try context.fetch(request)
            for object in result as! [NSManagedObject] {
                guard let creationDate = object.value(forKey: "creationDate") as? Date else { return }
                if creationDate == washing.creationDate {
                    context.delete(object)
                }
            }
        } catch {
            handler(.failure(error))
        }
        handler(appDelegate!.saveContext())
    }
}
