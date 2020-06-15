import UIKit
import CoreData

class CoreDataManager {

    // MARK: - Properties
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        return context!
    }

    static let shared = CoreDataManager()
    private init() {}

    // MARK: - Fetch
    func fetch(handler: @escaping (Result<Error>) -> Void) -> [Clothes] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ClothesInfo")
        request.returnsObjectsAsFaults = false

        var allClothes = [Clothes]()

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                guard let uID = data.value(forKey: "uID") as? String,
                    let typeString  = data.value(forKey: "type") as? String,
                    let colorString = data.value(forKey: "color") as? String,
                    let info        = data.value(forKey: "info") as? String?,
                    let photoData   = data.value(forKey: "photo") as? Data,
                    let symbolsIDs  = data.value(forKey: "symbolsIDs") as? [Int]
                    else { return allClothes}

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
        return allClothes
    }

    // MARK: - Save
    func saveData(clothes: Clothes, handler: @escaping (Result<Error>) -> Void) {
        guard let entity = NSEntityDescription.entity(forEntityName: "ClothesInfo", in: context) else { return }

        guard let photoData = clothes.photo.pngData() else { return }
        let arrayOfID = clothes.symbols.map { $0.id }
        let newClothes = NSManagedObject(entity: entity, insertInto: context)

        newClothes.setValue(clothes.uID, forKey: "uID")
        newClothes.setValue(clothes.type.rawValue, forKey: "type")
        newClothes.setValue(clothes.color.rawValue, forKey: "color")
        newClothes.setValue(clothes.info, forKey: "info")
        newClothes.setValue(photoData, forKey: "photo")
        newClothes.setValue(arrayOfID, forKey: "symbolsIDs")

        do {
            try context.save()
            handler(.success)
        } catch {
            handler(.failure(error))
        }
    }

    func delete(clothes: Clothes, handler: @escaping (Result<Error>) -> Void) {
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

        do {
            try context.save()
            handler(.success)
        } catch {
            handler(.failure(error))
        }
    }

    // MARK: - Update
    func update(editableClothes: Clothes, handler: @escaping (Result<Error>) -> Void) {
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
        do {
            try context.save()
            handler(.success)
        } catch {
            handler(.failure(error))
        }
    }
}
