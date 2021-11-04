
import Foundation

enum APIError: Error {
  case invalidURL
	case networkingError(Error)
	case serverError // HTTP 5xx
	case requestError(Int, String) // HTTP 4xx
	case invalidResponse
	case decodingError(DecodingError)
  case postParametersEncodingFailure(description: String)
  
  var localizedDescription: String {
    switch self {
    case.invalidURL:
      return "Invalid url"
    case .networkingError(let error):
      return "Error sending request: \(error.localizedDescription)"
    case .serverError:
      return "HTTP 500 Server Error"
    case .requestError(let status, let body):
      return "HTTP \(status)\n\(body)"
    case .invalidResponse:
      return "Invalid Response"
    case .decodingError(let error):
      return "Decoding error: \(error.localizedDescription)"
    case .postParametersEncodingFailure(let description):
      return "APIError post parameters failure -> \(description)"
    }
  }
}
