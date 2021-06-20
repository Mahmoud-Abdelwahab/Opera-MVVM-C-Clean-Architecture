//
//  RxMoya+Ex.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 20/06/2021.
//

import RxSwift
import Moya

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func catchAppError() -> Single<Element> {
        return flatMap { response in
            switch response.statusCode {
            case 200...299:
                return .just(response)
            case 400:
                throw AppError.badRequest
            case 401:
                throw AppError.unauthorized
            case 404:
                throw AppError.notFound
            case 408, -1001:
                throw AppError.timeout
            case -1009:
                throw AppError.offline
            case 500:
                throw AppError.serverError
            default:
                throw AppError.networkError
            }
        }
    }
    
}
