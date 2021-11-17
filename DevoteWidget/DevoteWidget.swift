//
//  DevoteWidget.swift
//  DevoteWidget
//
//  Created by Piotr Szerszeń on 17/11/2021.
//

import WidgetKit
import SwiftUI
import Devote

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct DevoteWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var widgetFamily

    private var logoSize: CGFloat {
        return widgetFamily == .systemSmall ? 36 : 56
    }

    var body: some View {
        //        Text(entry.date, style: .time)
        GeometryReader { geometry in
            ZStack {
                backgroundGradient

                Image("rocket-small")
                    .resizable()
                    .scaledToFit()

                Image("logo")
                    .resizable()
                    .frame(width: logoSize, height: logoSize)
                    .offset(x: geometry.size.width / 2 - 20,
                            y: geometry.size.height / (-2) + 20)
                    .padding([.top, .trailing], widgetFamily == .systemSmall ? 12 : 32)

                HStack {
                    Text("Just Do It!")
                        .font(widgetFamily == .systemSmall ? .footnote : .headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 12.0)
                        .padding(.vertical, 4.0)
                        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.5)
                                        .blendMode(.overlay))
                    .clipShape(Capsule())

                    if widgetFamily != .systemSmall {
                        Spacer()
                    }
                }
                .padding()
                .offset(y: geometry.size.height / 2 - 24)
            }
        }
    }
}

@main
struct DevoteWidget: Widget {
    let kind: String = "DevoteWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DevoteWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Devote Launcher")
        .description("This is an example widgetfor the personal task manager app.")
    }
}

struct DevoteWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
