import SwiftUI

/// View for the routing options
struct RoutingOptionsView: View {
    // MARK: Properties
    
    /// The dismiss action of the environment
    @Environment(\.dismiss) private var dismiss
    
    
    /// If toll roads should be avoided during routing
    @State var shouldAvoidTollRoadsWhileRouting: Bool = false
    
    
    /// If unpaved roads should be avoided during routing
    @State var shouldAvoidUnpavedRoadsWhileRouting: Bool = false
    
    
    /// If paved roads should be avoided during routing
    @State var shouldAvoidPavedRoadsWhileRouting: Bool = false
    
    
    /// If ferries should be avoided during routing
    @State var shouldAvoidFerriesWhileRouting: Bool = false
    
    
    /// If motorways should be avoided during routing
    @State var shouldAvoidMotorwaysWhileRouting: Bool = false
    
    
    /// If steps should be avoided during routing
    @State var shouldAvoidStepsWhileRouting: Bool = false
    
    
    /// The actual view
    var body: some View {
        NavigationView {
            List {
                Section {
                    Toggle("avoid_tolls", isOn: $shouldAvoidTollRoadsWhileRouting)
                        .tint(.accent)
                    
                    Toggle("avoid_unpaved", isOn: $shouldAvoidUnpavedRoadsWhileRouting)
                        .tint(.accent)
                        .disabled(shouldAvoidPavedRoadsWhileRouting)
                    
                    Toggle("avoid_ferry", isOn: $shouldAvoidFerriesWhileRouting)
                        .tint(.accent)
                    
                    Toggle("avoid_motorways", isOn: $shouldAvoidMotorwaysWhileRouting)
                        .tint(.accent)
                    
                    Toggle("avoid_steps", isOn: $shouldAvoidStepsWhileRouting)
                        .tint(.accent)
                    
                    Toggle("avoid_paved", isOn: $shouldAvoidPavedRoadsWhileRouting)
                        .tint(.accent)
                        .disabled(shouldAvoidUnpavedRoadsWhileRouting)
                }
            }
            .navigationTitle(String(localized: "driving_options_title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("close")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            shouldAvoidTollRoadsWhileRouting = Settings.shouldAvoidTollRoadsWhileRouting
            shouldAvoidUnpavedRoadsWhileRouting = Settings.shouldAvoidUnpavedRoadsWhileRouting
            shouldAvoidPavedRoadsWhileRouting = Settings.shouldAvoidPavedRoadsWhileRouting
            shouldAvoidFerriesWhileRouting = Settings.shouldAvoidFerriesWhileRouting
            shouldAvoidMotorwaysWhileRouting = Settings.shouldAvoidMotorwaysWhileRouting
            shouldAvoidStepsWhileRouting = Settings.shouldAvoidStepsWhileRouting
        }
        .onChange(of: shouldAvoidTollRoadsWhileRouting) { changedShouldAvoidTollRoadsWhileRouting in
            Settings.shouldAvoidTollRoadsWhileRouting = changedShouldAvoidTollRoadsWhileRouting
        }
        .onChange(of: shouldAvoidUnpavedRoadsWhileRouting) { changedShouldAvoidUnpavedRoadsWhileRouting in
            Settings.shouldAvoidUnpavedRoadsWhileRouting = changedShouldAvoidUnpavedRoadsWhileRouting
            if changedShouldAvoidUnpavedRoadsWhileRouting {
                shouldAvoidPavedRoadsWhileRouting = false
            }
        }
        .onChange(of: shouldAvoidPavedRoadsWhileRouting) { changedShouldAvoidPavedRoadsWhileRouting in
            Settings.shouldAvoidPavedRoadsWhileRouting = changedShouldAvoidPavedRoadsWhileRouting
            if changedShouldAvoidPavedRoadsWhileRouting {
                shouldAvoidUnpavedRoadsWhileRouting = false
            }
        }
        .onChange(of: shouldAvoidFerriesWhileRouting) { changedShouldAvoidFerriesWhileRouting in
            Settings.shouldAvoidFerriesWhileRouting = changedShouldAvoidFerriesWhileRouting
        }
        .onChange(of: shouldAvoidMotorwaysWhileRouting) { changedShouldAvoidMotorwaysWhileRouting in
            Settings.shouldAvoidMotorwaysWhileRouting = changedShouldAvoidMotorwaysWhileRouting
        }
        .onChange(of: shouldAvoidStepsWhileRouting) { changedShouldAvoidStepsWhileRouting in
            Settings.shouldAvoidStepsWhileRouting = changedShouldAvoidStepsWhileRouting
        }
        .accentColor(.toolbarAccent)
    }
}
