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
                        Text(move.name.uppercased())
                            .font(.title3)
                            .bold()
                        Spacer()
                        Text(move.type.name.capitalized)
                            .font(.subheadline)
                            .padding(.horizontal,8)
                            .padding(.vertical,6)
                            .background(Color(move.type.name))
                            .cornerRadius(16)
                        Text(move.damageClass.name.capitalized)
                            .font(.subheadline)
                            .padding(.horizontal,8)
                            .padding(.vertical,6)
                            .background(Color(move.type.name))
                            .cornerRadius(16)
                    }
                    Grid(alignment: .leading, verticalSpacing: 0) {
                        GridRow {
                            HStack{
                                Text("Power:")
                                Text("\(move.power ?? 0)")
                            }
                            HStack{
                                Divider()
                                Text("PP:")
                                Text("\(move.pp)")
                            }
                            HStack{
                                Divider()
                                Text("Accuracy:")
                                Text("\(move.accuracy ?? 0)")
                            }
                        }
                        .padding(.vertical, 8)
                        Divider()
                            .hidden()
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
                moveDetails = try await PokemonAPI.fetchMoves(for: moves ?? [])
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

struct MovesView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
            .environmentObject(NavigationModel.shared)
    }
}
