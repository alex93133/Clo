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
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ClothesInfo")
        request.returnsObjectsAsFaults = false

        var allClothes = [Clothes]()

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                guard let uID       = data.value(forKey: "uID") as? String,
                    let typeString  = data.value(forKey: "type") as? String,
                    let colorString = data.value(forKey: "color") as? String,
                    let info        = data.value(forKey: "info") as? String?,
                    let photoData   = data.value(forKey: "photo") as? Data,
                    let symbolsIDs  = data.value(forKey: "symbolsIDs") as? [Int]
                    else { return allClothes }

                let clothes = Clothes(uID: uID,
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
        return allClothes.reversed()
    }

    // MARK: - Save clothes
    func saveClothes(clothes: Clothes, handler: @escaping (Result<Error>) -> Void) {
        guard let entity = NSEntityDescription.entity(forEntityName: "ClothesInfo", in: context) else { return }

        guard let photoData = clothes.photo.pngData() else { return }
        let arrayOfID       = clothes.symbols.map { $0.id }
        let newClothes      = NSManagedObject(entity: entity, insertInto: context)

        newClothes.setValue(clothes.uID, forKey: "uID")
        newClothes.setValue(clothes.type.rawValue, forKey: "type")
        newClothes.setValue(clothes.color.rawValue, forKey: "color")
        newClothes.setValue(clothes.info, forKey: "info")
        newClothes.setValue(photoData, forKey: "photo")
        newClothes.setValue(arrayOfID, forKey: "symbolsIDs")
        handler(appDelegate!.saveContext())
    }

    // MARK: - Delete clothes
    func deleteClothes(clothes: Clothes, handler: @escaping (Result<Error>) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ClothesInfo")

        do {
            let result = try context.fetch(request)
            for object in result as! [NSManagedObject] {
                guard let uID = object.value(forKey: "uID") as? String else { return }
                if uID == clothes.uID {
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
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ClothesInfo")
        do {
            let result = try context.fetch(request)
            for object in result as! [NSManagedObject] {
                guard let uID = object.value(forKey: "uID") as? String else { return }
                guard let photoData = editableClothes.photo.pngData() else { return }
                if uID == editableClothes.uID {
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

    // MARK: - Save laundry
    func saveLaundry(laundry: Laundry, handler: @escaping (Result<Error>) -> Void) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Laundries", in: context) else { return }

        let newLaundry  = NSManagedObject(entity: entity, insertInto: context)

        newLaundry.setValue(laundry.name, forKey: "name")
        newLaundry.setValue(laundry.color.rawValue, forKey: "color")
        newLaundry.setValue(laundry.temperature, forKey: "temperature")
        newLaundry.setValue(laundry.washingMode.rawValue, forKey: "washingMode")
        newLaundry.setValue(laundry.coincidence, forKey: "coincidence")
        handler(appDelegate!.saveContext())
    }

    // MARK: - Fetch laundries
    func fetchLaundries(handler: @escaping (Result<Error>) -> Void) -> [Laundry] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Laundries")
        request.returnsObjectsAsFaults = false

        var allLaundries = [Laundry]()

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                guard let name      = data.value(forKey: "name") as? String,
                    let color       = data.value(forKey: "color") as? String,
                    let temperature = data.value(forKey: "temperature") as? Int64,
                    let washingMode = data.value(forKey: "washingMode") as? String,
                    let coincidence = data.value(forKey: "coincidence") as? Bool

                    else { return allLaundries }

                let laundry = Laundry(name: name,
                                      color: color,
                                      temperature: temperature,
                                      washingMode: washingMode,
                                      coincidence: coincidence)

                allLaundries.append(laundry)
            }
        } catch {
            handler(.failure(error))
        }
        handler(.success)
        return allLaundries.reversed()
    }

    // MARK: - Delete laundry
    func deleteLaundry(laundry: Laundry, handler: @escaping (Result<Error>) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Laundries")

        do {
            let result = try context.fetch(request)
            for object in result as! [NSManagedObject] {
                guard let name = object.value(forKey: "name") as? String else { return }
                if name == laundry.name {
                    context.delete(object)
                }
            }
        } catch {
            handler(.failure(error))
        }
        handler(appDelegate!.saveContext())
    }
}
