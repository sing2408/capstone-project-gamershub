//
//  ProfileUseCase.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 30/04/25.
//

import Foundation

protocol ProfileUseCaseProtocol {
    func getProfile() -> Result<Profile?, Error>
    func saveProfile(profile: Profile) -> Result<Void, Error>
}

class ProfileUseCase: ProfileUseCaseProtocol {
    private let profileRepository: ProfileRepositoryProtocol

    init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }

    func getProfile() -> Result<Profile?, Error> {
        return profileRepository.getProfile()
    }

    func saveProfile(profile: Profile) -> Result<Void, Error> {
        return profileRepository.saveProfile(profile: profile)
    }
}
