//
//  Assembler.swift
//  VietVkNotes
//
//  Created by VietVk on 06/08/2022.
//

protocol Assembler: AnyObject,
                    InputUserAssembler,
                    MainAssembler,
                    CreateNoteAssembler,
                    UsersAssembler,
                    UserDetailAssembler,
                    GatewaysAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}
