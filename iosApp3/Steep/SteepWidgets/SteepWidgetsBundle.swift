//
//  SteepWidgetsBundle.swift
//  SteepWidgets
//
//  Created by Ben on 8/30/25.
//

import WidgetKit
import SwiftUI

@main
struct SteepWidgetsBundle: WidgetBundle {
    var body: some Widget {
        SteepWidgets()
        SteepWidgetsControl()
        SteepWidgetsLiveActivity()
    }
}
