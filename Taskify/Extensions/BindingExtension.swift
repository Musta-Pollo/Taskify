//
//  BindingExtension.swift
//  Taskify
//
//  Created by Jan Zimola on 01.02.2024.
//

import SwiftUI

extension Binding where Value == UUID {
    /// Converts `Binding<UUID>` to `Binding<UUID?>`.
    var optional: Binding<UUID?> {
        Binding<UUID?>(
            get: { self.wrappedValue },
            set: { newValue in
                // Only update the original binding if newValue is not nil.
                if let newValue = newValue {
                    self.wrappedValue = newValue
                }
                // If needed, handle the case where newValue is nil.
                // For example, you might set a default value or leave the existing value unchanged.
            }
        )
    }
}
