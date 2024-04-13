final class TariffsViewModel {
    
private let model = TariffsModel()
        
var tariffs: [[String]] {get {return model.tariffsList}}
        
var prices_for_text: String {get {return model.prices_for_text}}

var long_button_text: String {get {return model.long_button_text}}
    
var short_button_text: String {get {return model.short_button_text}}
    
// Get value from model
    
}
