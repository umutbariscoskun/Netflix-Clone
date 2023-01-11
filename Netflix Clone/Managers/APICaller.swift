//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Umut Barış Çoşkun on 8.01.2023.
//

import Foundation



enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    
    
    func getTrendingMovies(completion: @escaping (Result<[Movie],Error> )-> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results =  try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
              
                
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Movie],Error> )-> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results =  try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
              
                
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie],Error> )-> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results =  try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
              
                
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Movie],Error> )-> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results =  try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
              
                
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Movie],Error> )-> Void){
        
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results =  try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
              
                
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie],Error> )-> Void){
        
        guard let url = URL(string: "\(Constants.baseUrl)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results =  try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
              
                
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func search(with query: String,completion: @escaping (Result<[Movie],Error> )-> Void )
    {
        //formatting the url
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.baseUrl)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results =  try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
              
                
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
