//
//  UserRepository.swift
//  CarGo
//
//  Created by Andrei Mirica on 13.02.2023.
//

import Foundation

class UserRepository {
    static var userId = ""
        
    func login(loginData: LoginData) async throws -> (LoginDTO?, NetworkError?) {
        do {
            let(data, error) = try await LoginService.login(loginData: loginData)
            
            guard let data = data else {
                guard let error = error else {
                    return (nil, .unexpectedError)
                }
                
                return (nil, error)
            }
            
            do {
                let response = try JSONDecoder().decode(LoginDTO.self, from: data)
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

                return (nil, .unexpectedError)
            }
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                return (response, nil)
            } catch {
                return (nil, .jsonDecoder)
            }
        }
        catch {
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
            let(data, error) = await UserInfoService.userInfo(userId: UserRepository.userId)
            
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
}
