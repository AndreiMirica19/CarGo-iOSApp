//
//  UserRepository.swift
//  CarGo
//
//  Created by Andrei Mirica on 13.02.2023.
//

import Foundation

class UserRepository: ObservableObject {
    var userId = ""
    static let shared = UserRepository()
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.setValue(isLoggedIn, forKey: "logedIn")
        }
    }
    
    init() {
        isLoggedIn = UserDefaults.standard.bool(forKey: "logedIn")
        
        guard let id = UserDefaults.standard.string(forKey: "userId") else {
            return
        }
        
        userId = id
    }
    
    func login() {
        isLoggedIn = true
    }
    
    func logout() {
        isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: "userId")
    }
    
    func login(loginData: LoginData) async throws -> (UserDTO?, NetworkError?) {
        do {
            let(data, error) = try await LoginService.login(loginData: loginData)
            
            guard let data = data else {
                guard let error = error else {
                    return (nil, .unexpectedError)
                }
                
                return (nil, error)
            }
            
            do {
                let response = try JSONDecoder().decode(UserDTO.self, from: data)
                return (response, nil)
            } catch {
                do {
                    _ = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    return (nil, .invalidAccount)
                } catch {
                    return (nil, .jsonDecoder)
                }
            }
        }
    }
    
    func register(registerData: RegisterData) async throws -> (Response?, NetworkError?) {
        do {
            let (data, error) = try await RegisterService.register(registerData: registerData)
            guard let data = data else {
                guard let error = error else {
                    return (nil, .unexpectedError)
                }
                
                return (nil, error)
            }
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                return (response, nil)
            } catch {
                return (nil, .jsonDecoder)
            }
        } catch {
            return (nil, .unexpectedError)
        }
    }
    
    func editProfile(userDetails: UserDetailsData) async throws -> (UserDetailsData?, NetworkError?) {
        do {
            let(data, error) = await EditProfileService.editProfile(userDetails: userDetails)
            
            guard let data = data else {
                guard let error = error else {
                    return (nil, .unexpectedError)
                }
                
                return (nil, error)
            }
            
            do {
                let response = try JSONDecoder().decode(UserDetailsData.self, from: data)
                return (response, nil)
            } catch {
                do {
                    _ = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    return (nil, .invalidAccount)
                } catch {
                    return (nil, .jsonDecoder)
                }
            }
        }
    }
    
    func userInfo() async throws -> (UserDetailsData?, NetworkError?) {
        do {
            let(data, error) = await UserInfoService.userInfo(userId: UserRepository.shared.userId)
            
            guard let data = data else {
                guard let error = error else {
                    return (nil, .unexpectedError)
                }
                
                return (nil, error)
            }
            
            do {
                let response = try JSONDecoder().decode(UserDetailsData.self, from: data)
                return (response, nil)
            } catch {
                do {
                    _ = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    return (nil, .invalidAccount)
                } catch {
                    return (nil, .jsonDecoder)
                }
            }
        }
    }
    
    func accountInfo() async throws -> (UserDTO?, NetworkError?) {
        do {
            let(data, error) = try await AccountInfoService.accountInfo(userId: UserRepository.shared.userId)
            
            guard let data = data else {
                guard let error = error else {
                    return (nil, .unexpectedError)
                }
                
                return (nil, error)
            }
            
            do {
                let response = try JSONDecoder().decode(UserDTO.self, from: data)
                return (response, nil)
            } catch {
                do {
                    _ = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    return (nil, .invalidAccount)
                } catch {
                    return (nil, .jsonDecoder)
                }
            }
        }
    }
    
    func changeEmail(email: String) async throws -> (Response?, NetworkError?) {
        let (data, error) = try await ChangeEmailService.changeEmail(userId: UserRepository.shared.userId, email: email)
        guard let data = data else {
            guard let error = error else {
                return (nil, .unexpectedError)
            }
            
            return (nil, error)
        }
        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            return (response, nil)
        } catch {
            return (nil, .jsonDecoder)
        }
    }
    
    func changePhoneNumber(phoneNumber: String) async throws -> (Response?, NetworkError?) {
        let (data, error) = try await ChangePhoneNumberService.changePhoneNumber(userId: userId, phoneNumber: phoneNumber)
        guard let data = data else {
            guard let error = error else {
                return (nil, .unexpectedError)
            }
            
            return (nil, error)
        }
        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            return (response, nil)
        } catch {
            return (nil, .jsonDecoder)
        }
    }
    
    func changePassowed(password: String) async throws -> (Response?, NetworkError?) {
        let (data, error) = try await ChangePasswordService.changePassword(userId: userId, password: password)
        guard let data = data else {
            guard let error = error else {
                return (nil, .unexpectedError)
            }
            
            return (nil, error)
        }
        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            return (response, nil)
        } catch {
            return (nil, .jsonDecoder)
        }
    }
    
    func deleteAccount() async throws -> (Response?, NetworkError?) {
        let (data, error) = try await DeleteAccountService.deleteAccount(userId: userId)
        
        guard let data = data else {
            guard let error = error else {
                return (nil, .unexpectedError)
            }
            
            return (nil, error)
        }
        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            return (response, nil)
        } catch {
            return (nil, .jsonDecoder)
        }
    }
    
}
