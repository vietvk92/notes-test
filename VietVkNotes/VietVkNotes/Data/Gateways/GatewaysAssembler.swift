//
//  GatewaysAssembler.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

protocol GatewaysAssembler {
    func resolve() -> AuthGatewayType
    func resolve() -> NoteGatewayType
    func resolve() -> CreateNoteGatewayType
    func resolve() -> UserGatewayType
}

extension GatewaysAssembler where Self: DefaultAssembler {
    func resolve() -> AuthGatewayType {
        AuthGateway()
    }
    func resolve() -> NoteGatewayType {
        NoteGateway()
    }
    func resolve() -> CreateNoteGatewayType {
        CreateNoteGateway()
    }
    
    func resolve() -> UserGatewayType {
        UserGateway()
    }
}
