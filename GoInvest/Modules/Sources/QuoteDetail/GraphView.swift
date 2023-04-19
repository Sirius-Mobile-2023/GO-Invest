import SwiftUI
import Charts

struct GraphView: View {
    @State var sampleAnalytics: [GraphMockModel] = sampleData
    @State var currentActiveItem: GraphMockModel?
    @State var plotWidth: CGFloat = 0

    var body: some View {
        VStack {
            animatedChart()
        }
        .padding(.top, 30)
        .padding(.horizontal, 5)
    }

    @ViewBuilder
    func animatedChart() -> some View {
        let max = sampleAnalytics.max { item1, item2 in
            return item2.price > item1.price
        }?.price ?? 0

        Chart {
            ForEach(sampleAnalytics) { item in
                LineMark(
                    x: .value("Hour", item.day, unit: .hour),
                    y: .value("Price", item.animate ? item.price : 0)
                )
                .foregroundStyle(Color.blue.gradient)

                PointMark(
                    x: .value("Hour", item.day, unit: .hour),
                    y: .value("Price", item.animate ? item.price : 0)
                )
                .foregroundStyle(Color.blue.gradient)

                if let currentActiveItem, currentActiveItem.id == item.id {
                    RuleMark(x: .value("Hour", currentActiveItem.day))
                        .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                        .offset(x: (plotWidth / CGFloat(sampleAnalytics.count)) / 2)
                        .annotation(position: .top) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Price")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white.shadow(.drop(radius: 2)))
                            }
                        }
                }
            }
        }
        .chartYScale(domain: 0...(max))
        .chartOverlay(content: { proxy in
            GeometryReader {_ in
                Rectangle()
                    .fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let location = value.location
                                if let date: Date = proxy.value(atX: location.x) {
                                    let calendar = Calendar.current
                                    let hour = calendar.component(.hour, from: date)
                                    if let currentItem = sampleAnalytics.first(where: { item in
                                        calendar.component(.hour, from: item.day) == hour
                                    }) {
                                        self.currentActiveItem = currentItem
                                        self.plotWidth = proxy.plotAreaSize.width
                                    }
                                }
                            }.onEnded {_ in
                                self.currentActiveItem = nil
                            }
                    )
            }
        })
        .frame(height: 250)
        .onAppear {
            animateGraph()
        }
    }

    func animateGraph(fromChange: Bool = false) {
        for (index, _) in sampleAnalytics.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * (fromChange ? 0.03 : 0.05)) {
                withAnimation(fromChange ? .easeInOut(duration: 0.6) : .interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)) {
                    sampleAnalytics[index].animate = true
                }
            }
        }
    }
}

struct GraphMockModel: Identifiable {
    var id = UUID()
    var day: Date
    var price: Double
    var animate = false
}

// TODO: Get data for chart #24
extension Date {
    func updateHour(value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: value, minute: 0, second: 0, of: self) ?? .now
    }
}

var sampleData: [GraphMockModel] = [
    GraphMockModel(day: Date().updateHour(value: 8), price: 1500),
    GraphMockModel(day: Date().updateHour(value: 9), price: 2625),
    GraphMockModel(day: Date().updateHour(value: 10), price: 7500),
    GraphMockModel(day: Date().updateHour(value: 11), price: 3688),
    GraphMockModel(day: Date().updateHour(value: 12), price: 2988),
    GraphMockModel(day: Date().updateHour(value: 13), price: 3289),
    GraphMockModel(day: Date().updateHour(value: 14), price: 4500),
    GraphMockModel(day: Date().updateHour(value: 15), price: 6788),
    GraphMockModel(day: Date().updateHour(value: 16), price: 9988),
    GraphMockModel(day: Date().updateHour(value: 17), price: 7866),
    GraphMockModel(day: Date().updateHour(value: 18), price: 1989),
    GraphMockModel(day: Date().updateHour(value: 19), price: 6456),
    GraphMockModel(day: Date().updateHour(value: 20), price: 3467)
]
