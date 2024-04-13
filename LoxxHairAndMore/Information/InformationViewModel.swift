import Foundation

//TODO: WHEN FINISHED: CHECK IMPORTS

final class InformationViewModel {
    
private let model = InformationModel()
    
    var email: String {get {return model.email}}
    
    var phoneNumber: String {get {return model.phoneNumber}}
    
    var address: String {get {return model.address}}
    
    var show_in_map_button_localized_text: String {get {return model.show_in_map_button_localized_text}}
    
    var aMapsURLString: String {get {return model.aMapsURL}}
    
    var gMapsURLString: String {get {return model.gMapsURL}}
        
    var facebookURL: String {get {return model.facebookURL}}
        
    }
