
import Foundation

enum APIError: Error {
  case invalidURL
	case networkingError(Error)
	case serverError // HTTP 5xx
	case requestError(Int, String) // HTTP 4xx
	case invalidResponse
	case decodingError(DecodingError)
	case postParametersEncodingFalure(description: String)
	
	var localizedDescription: String {
		switch self {
    case .invalidURL:
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
		case .postParametersEncodingFalure(let description):
			return "APIError post parameters failure -> \(description)"
		}
	}
}

public enum Either<T, U> {
	case firstType(T)
	case secondType(U)
}

extension Either: Decodable where T: Decodable, U: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		
		if let firstType = try? container.decode(T.self) {
			self = .firstType(firstType)
		} else if let secondType = try? container.decode(U.self) {
			self = .secondType(secondType)
		} else {
			let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "Unknown type")
			throw DecodingError.dataCorrupted(context)
		}
	}
}

struct ApiErrorModel: Decodable {
	let code: Int
	let error: String
}

