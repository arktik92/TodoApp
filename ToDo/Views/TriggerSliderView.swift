//
//  TriggerSlider.swift
//  ToDo
//
//  Created by Esteban SEMELLIER on 08/01/2023.
//

import SwiftUI
import TriggerSlider

struct TriggerSliderView: View {
    @Binding var simpleRightDirectionSliderOffsetX: CGFloat
    @Binding var alertPresented: Bool
    var body: some View {
        
        TriggerSlider(sliderView: {
            // Touchable Part
            RoundedRectangle(cornerRadius: 30, style: .continuous).fill(Color.green)
                .frame(width: 60, height: 60)
                .overlay(Image(systemName: "arrow.right").font(.system(size: 30)).foregroundColor(.white))
        }, textView: {
            Text("Swipe pour terminer la tâche ").foregroundColor(Color.green)
        },
                      backgroundView: {
            // Background Part
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color.green.opacity(0.5))
                .frame(height: 60)
        }, offsetX: $simpleRightDirectionSliderOffsetX,
                      didSlideToEnd: {
            print("Triggered right direction slider!")
            self.alertPresented = true
        }, settings: TriggerSliderSettings(sliderViewVPadding: 5, slideDirection: .right)).padding(.vertical, 10).padding(.horizontal, 20)    }
}

struct TriggerSliderView_Previews: PreviewProvider {
    static var previews: some View {
        TriggerSliderView(simpleRightDirectionSliderOffsetX: .constant(0), alertPresented: .constant(false))
    }
}
