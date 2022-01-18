import Foundation
import SwiftUI

class HelperShare {
    
    // static function so it can be called externally
    static func createTrainingCSV(training: Training, rifle: Rifle, average: Double, total: Double) -> NSURL {
        
        var trainingArray: [[String: AnyObject]] = Array()
        var trainingDict = [String: AnyObject]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        // adding values to dictionary as strings
        trainingDict.updateValue(String(NSLocalizedString(rifle.name ?? "", comment: "")) as AnyObject, forKey: "rifle")
        trainingDict.updateValue(String(training.indicator ?? "") as AnyObject, forKey: "training_add_title_mood")
        trainingDict.updateValue(String(NSLocalizedString(training.training ?? "", comment: "")) as AnyObject, forKey: "training_add_kind")
        trainingDict.updateValue(String(training.place ?? "") as AnyObject, forKey: "training_add_location")
        trainingDict.updateValue(dateFormatter.string(from: training.date ?? Date()) as AnyObject, forKey: "training_add_date")
        trainingDict.updateValue(String(training.shoot_count) as AnyObject, forKey: "training_add_shootcount")
        for i in 0 ..< training.shoots!.count {
            trainingDict.updateValue(String(training.shoots?[i] ?? 0) as AnyObject, forKey: "training_add_shot \(i)")
        }
        trainingDict.updateValue(String(total) as AnyObject, forKey: "training_add_total")
        trainingDict.updateValue(String(average) as AnyObject, forKey: "training_add_average")
        trainingDict.updateValue(String(training.report ?? "") as AnyObject, forKey: "training_add_title_report")
        
        // appending array with dictionary
        trainingArray.append(trainingDict)
        
        // string with column names
        var csvString = "\(String(NSLocalizedString("rifle", comment: ""))),\(String(NSLocalizedString("training_add_title_mood", comment: ""))),\(String(NSLocalizedString("training_add_kind", comment: ""))), \(String(NSLocalizedString("training_add_location", comment: ""))), \(String(NSLocalizedString("training_add_date", comment: ""))),\(String(NSLocalizedString("training_add_shootcount", comment: ""))),"
        
        for i in 1 ..< training.shoots!.count + 1 {
            csvString = csvString.appending(String(format: NSLocalizedString("training_add_shot %lld", comment: ""), i))
            csvString = csvString.appending(",")
        }
        
        csvString = csvString.appending("\(String(NSLocalizedString("training_add_total", comment: ""))),\(String(NSLocalizedString("training_add_average", comment: ""))),\(String(NSLocalizedString("training_add_title_report", comment: "")))\n")
        
        // add dictionary data to csv String
        for dct in trainingArray {csvString = csvString.appending("\(String(describing: dct[("rifle")]!)),\(String(describing: dct[("training_add_title_mood")]!)),\(String(describing: dct[("training_add_kind")]!)),\"\(String(describing: dct[("training_add_location")]!))\",\(String(describing: dct[("training_add_date")]!)),\(String(describing: dct[("training_add_shootcount")]!)),")
            
            for i in 0 ..< training.shoots!.count {
                csvString = csvString.appending("\(String(describing: dct[("training_add_shot \(i)")]!)),")
            }
            
            csvString = csvString.appending(
                "\(String(describing: dct[("training_add_total")]!)),\(String(describing: dct[("training_add_average")]!)),\"\(String(describing: dct[("training_add_title_report")]!))\"\n")
        }
        
        // write file to documents folder
        do {
            let fileManager = FileManager.default
            let sharePath = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
            let shareURL = sharePath.appendingPathComponent("CSVRecTraining.csv")
            let NSShareURL = NSURL(string: shareURL.absoluteString)
            try csvString.write(to: shareURL, atomically: true, encoding: .utf8)
            print("CSV written to:", shareURL)
            return NSShareURL!
        } catch {
            print("error creating file")
            return NSURL(string: "Error")!
        }
    }
    
    // static function so it can be called externally
    static func createCompetitionCSV(competition: Competition, rifle: Rifle, total: Double) -> NSURL {
        
        var competitionArray: [[String: AnyObject]] = Array()
        var competitionDict = [String: AnyObject]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        // adding values to dictionary as strings
        competitionDict.updateValue(String(NSLocalizedString(rifle.name ?? "", comment: "")) as AnyObject, forKey: "rifle")
        competitionDict.updateValue(String(NSLocalizedString(competition.kind ?? "", comment: "")) as AnyObject, forKey: "competition_add_kind")
        competitionDict.updateValue(String(competition.place ?? "") as AnyObject, forKey: "competition_add_location")
        competitionDict.updateValue(dateFormatter.string(from: competition.date ?? Date()) as AnyObject, forKey: "competition_add_date")
        competitionDict.updateValue(String(competition.shoot_count) as AnyObject, forKey: "competition_add_shootcount")
        for i in 0 ..< competition.shoots!.count {
            competitionDict.updateValue(String(competition.shoots?[i] ?? 0) as AnyObject, forKey: "competition_add_shot \(i)")
        }
        competitionDict.updateValue(String(total) as AnyObject, forKey: "competition_add_total")
        competitionDict.updateValue(String(competition.report ?? "") as AnyObject, forKey: "competition_add_title_report")
        
        // appending array with dictionary
        competitionArray.append(competitionDict)
        
        // string with column names
        var csvString = "\(String(NSLocalizedString("rifle", comment: ""))),\(String(NSLocalizedString("competition_add_kind", comment: ""))), \(String(NSLocalizedString("competition_add_location", comment: ""))), \(String(NSLocalizedString("competition_add_date", comment: ""))),\(String(NSLocalizedString("competition_add_shootcount", comment: ""))),"
        
        for i in 1 ..< competition.shoots!.count + 1 {
            csvString = csvString.appending(String(format: NSLocalizedString("competition_add_shot %lld", comment: ""), i))
            csvString = csvString.appending(",")
        }
        
        csvString = csvString.appending("\(String(NSLocalizedString("competition_add_total", comment: ""))),\(String(NSLocalizedString("competition_add_title_report", comment: "")))\n")
        
        // add dictionary data to csv String
        for dct in competitionArray {csvString = csvString.appending("\(String(describing: dct[("rifle")]!)), \(String(describing: dct[("competition_add_kind")]!)),\"\(String(describing: dct[("competition_add_location")]!))\", \(String(describing: dct[("competition_add_date")]!)), \(String(describing: dct[("competition_add_shootcount")]!)),")
            
            for i in 0 ..< competition.shoots!.count {
                csvString = csvString.appending("\(String(describing: dct[("competition_add_shot \(i)")]!)),")
            }
            
            csvString = csvString.appending(
                "\(String(describing: dct[("competition_add_total")]!)),\"\(String(describing: dct[("competition_add_title_report")]!))\"\n")
        }
        
        // write file to documents folder
        do {
            let fileManager = FileManager.default
            let sharePath = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
            let shareURL = sharePath.appendingPathComponent("CSVRecCompetition.csv")
            let NSShareURL = NSURL(string: shareURL.absoluteString)
            try csvString.write(to: shareURL, atomically: true, encoding: .utf8)
            print("CSV written to:", shareURL)
            return NSShareURL!
        } catch {
            print("error creating file")
            return NSURL(string: "Error")!
        }
    }
}
