//
//  MovesView.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 15.07.2023.
//

import SwiftUI

struct MovesView: View {
    @State private var moveDetails: [MoveDetail]? = []
    @State private var searchText = ""
    var moves: [Move]?
    
    var detailResults: [MoveDetail] {
        if searchText.isEmpty {
            return moveDetails ?? []
        }else {
            return moveDetails?.filter{ $0.name.contains(searchText) } ?? []
        }
    }
    
    var dummyMoves: [MoveDetail] = [
        MoveDetail(id: 1, accuracy: 100, power: 50, pp: 50, name: "Cut", type: Species(name: "Cut", url: ""), damageClass: Species(name: "Cut", url: "")),
        MoveDetail(id: 2, accuracy: 100, power: 50, pp: 50, name: "Ember", type: Species(name: "Cut", url: ""), damageClass: Species(name: "Cut", url: "")),
        MoveDetail(id: 3, accuracy: 100, power: 50, pp: 50, name: "Razor leaf", type: Species(name: "Cut", url: ""), damageClass: Species(name: "Cut", url: "")),
        MoveDetail(id: 4, accuracy: 100, power: 50, pp: 50, name: "Flame Thrower", type: Species(name: "Cut", url: ""), damageClass: Species(name: "Cut", url: ""))
    ]
    
    var searchResults: [MoveDetail] {
        if searchText.isEmpty {
            return dummyMoves
        } else {
            return dummyMoves.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        ScrollView{
            TextField("Search", text: $searchText)
                .padding()
                .background(.regularMaterial)
                .cornerRadius(16)
                .textInputAutocapitalization(.never)
            ForEach(detailResults, id: \.id){ move in
                VStack(alignment: .leading,spacing: 0){
                    HStack{
                        Text(move.name.capitalized)
                            .font(.title3)
                        Text("-")
                        Text(move.type.name)
                        Text(move.damageClass.name)
                    }
                    Grid(alignment: .leading, verticalSpacing: 0) {
                        GridRow {
                            Text("\(move.power ?? 0)")
                            Text("\(move.pp)")
                            Text("\(move.accuracy ?? 0)")
                        }
                        Divider()
                            .hidden()
                        GridRow {
                            Text("Power")
                            Text("PP")
                            Text("Accuracy")
                        }
                    }
                }
                .padding()
                .background(.regularMaterial)
                .cornerRadius(16)
            }
        }
        .scrollIndicators(.hidden)
        .padding()
        .task {
            do {
                moveDetails = try await fetchMoves(for: moves ?? [])
            } catch PokeError.invalidUrl {
                print("invalid url")
            }catch PokeError.invalidResponse {
                print("invalid response")
            }catch PokeError.invalidData {
                print("invalid data")
            }catch {
                print("unexpected error from MovesView")
            }
        }
    }
}

extension MovesView {
    
    private func fetchMoves(for moves: [Move]) async throws -> [MoveDetail] {
        return try await withThrowingTaskGroup(of: MoveDetail.self) { group in
            var tempMoves: [MoveDetail] = []
            for move in moves {
                group.addTask {
                    try await fetchMove(for: move.move.url)
                }
            }
            
            for try await move in group {
                tempMoves.append(move)
            }
            
            return tempMoves
        }
    }
    
    private func fetchMove(for moveUrl: String) async throws -> MoveDetail {
        let endpoint = moveUrl
        
        guard let url = URL(string: endpoint) else {
            throw PokeError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PokeError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let move = try decoder.decode(MoveDetail.self, from: data)
            return move
        }catch {
            throw PokeError.invalidData
        }
    }
}

struct MovesView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
