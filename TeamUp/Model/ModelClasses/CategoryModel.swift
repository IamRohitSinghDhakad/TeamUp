/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct CategoryModel : Codable {
	let result : [Result]?
	let message : String?
	let status : Int?

	enum CodingKeys: String, CodingKey {

		case result = "result"
		case message = "message"
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		result = try values.decodeIfPresent([Result].self, forKey: .result)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
	}

}

struct Result : Codable {
    let category_id : String?
    let category_name : String?
    let category_image : String?
    let status : String?
    let entrydt : String?

    enum CodingKeys: String, CodingKey {

        case category_id = "category_id"
        case category_name = "category_name"
        case category_image = "category_image"
        case status = "status"
        case entrydt = "entrydt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        category_image = try values.decodeIfPresent(String.self, forKey: .category_image)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        entrydt = try values.decodeIfPresent(String.self, forKey: .entrydt)
    }

}
