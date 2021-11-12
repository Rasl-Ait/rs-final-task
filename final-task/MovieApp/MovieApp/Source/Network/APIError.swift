
import Foundation

enum APIError: Error {
  case invalidURL
	case networkingError(Error)
	case serverError
	case requestError(Int, String)
	case invalidResponse
	case decodingError(DecodingError)
  case postParametersEncodingFailure(description: String)
  case jsonSerializationError(Error)
  
  var localizedDescription: String {
    switch self {
    case.invalidURL:
      return "Invalid url"
    case .networkingError(let error):
      return "Error sending request: \(error.localizedDescription)"
    case .serverError:
      return "HTTP 500 Server Error"
    case .requestError(let status, let body):
      return "Status code \(status)\n\(body)"
    case .invalidResponse:
      return "Invalid Response"
    case .decodingError(let error):
      return "Decoding error: \(error.localizedDescription)"
    case .postParametersEncodingFailure(let description):
      return "APIError post parameters failure -> \(description)"
    case .jsonSerializationError(let error):
      return "Json serialization error \(error.localizedDescription)"
    }
  }
}
