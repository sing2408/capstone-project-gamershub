//
//  ProfileRepositoryProtocol.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 30/04/25.
//

import Foundation

protocol ProfileRepositoryProtocol {
    func getProfile() -> Result<Profile?, Error>
    func saveProfile(profile: Profile) -> Result<Void, Error>
}
