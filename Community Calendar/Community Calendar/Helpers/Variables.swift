//
//  Colors.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Lambda School All rights reserved.
//

import UIKit
import CoreData

//extension NSManagedObjectContext {
//    static let mainContext = CoreDataStack.shared.mainContext
//}

let fadeViewTag = 123
let backgroundViewCornerRad: CGFloat = 10
let foregroundViewCornerRad: CGFloat = 15
var returnRadius: CGFloat { isRoundedDevice() }
var miniFrame = CGRect()

let todayDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.timeZone = .current
    df.dateFormat = "EEEE, MMMM d, yyyy"
    return df
}()

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

let featuredEventDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.timeZone = .current
    df.dateFormat = "MMMM d, EEEE"
    return df
}()

let cellDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.timeZone = .current
    df.dateFormat = "h:mma"
    return df
}()

let backendDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.timeZone = .current
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return df
}()

let weekdayDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.timeZone = .current
    df.dateFormat = "EEEE"
    return df
}()

let filterDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.timeZone = .current
    df.dateFormat = "MM-dd-yy"
    return df
}()

let todayDateFormatterWithoutTimezone: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "EEEE, MMMM d, yyyy"
    return df
}()

let featuredEventDateFormatterWithoutTimezone: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "MMMM d, EEEE"
    return df
}()

let cellDateFormatterWithoutTimezone: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "h:mma"
    return df
}()

let backendDateFormatterWithoutTimezone: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return df
}()

let weekdayDateFormatterWithoutTimezone: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "EEEE"
    return df
}()

let filterDateFormatterWithoutTimezone: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "MM-dd-yy"
    return df
}()

enum PoppinsFont: String {
    case black = "Poppins-Black"
    case blackItalic = "Poppins-BlackItalic"
    case bold = "Poppins-Bold"
    case boldItalic = "Poppins-BoldItalic"
    case extraBold = "Poppins-ExtraBold"
    case extraBoldItalic = "Poppins-ExtraBoldItalic"
    case extraLight = "Poppins-ExtraLight"
    case extraLightItalic = "Poppins-ExtraLightItalic"
    case italic = "Poppins-Italic"
    case light = "Poppins-Light"
    case lightItalic = "Poppins-LightItalic"
    case medium = "Poppins-Medium"
    case mediumItalic = "Poppins-MediumItalic"
    case regular = "Poppins-Regular"
    case semiBold = "Poppins-SemiBold"
    case semiBoldItalic = "Poppins-SemiBoldItalic"
    case thin = "Poppins-Thin"
    case thinItalic = "Poppins-ThinItalic"
}

enum ButlerFont: String {
    case bold = "Butler-Bold"
    case regular = "Butler"
    case black = "Butler-Black"
    case extraBold = "Butler-ExtraBold"
    case medium = "Butler-Medium"
    case light = "Butler-Light"
    case ultraLight = "Butler-UltraLight"
}

enum NetworkError: Error {
    case encodingError
    case responseError
    case noData
    case badDecode
    case noToken // No bearer token
    case otherError(Error)
}

//let testData = [
//    Event(title: "Downtown Winter Wonderland Lights Walk", description: "The winter magic isn't over yet - join us for a walk among downtown's gorgeous parks and public spaces, twinkling with lights throughout the winter season. We'll stop to hear from some of the people behind the park lighting.", startDate: backendDateFormatter.date(from: "2020-01-12T00:00:00.000Z") ?? Date(), endDate: backendDateFormatter.date(from: "2020-01-12T02:00:00.000Z") ?? Date(), creator: "Detroit Experience Factory ", urls: ["https://www.eventbrite.com/e/downtown-winter-wonderland-lights-walk-tickets-86842691829"], images: ["https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F85140001%2F89373299245%2F1%2Foriginal.20191219-193513?w=800&auto=format%2Ccompress&q=75&sharp=10&rect=220%2C0%2C1880%2C940&s=5c24d24ce75c0a170c95f533542b323f"], rsvps: ["Tyler Berrett"], locations: [Community_Calendar.Location(longitude: Optional(-83.045427), latitude: Optional(42.330511), name: "Roasting Plant", state: "MI", city: "Detroit", streetAddress: "600 Woodward Avenue", streetAddress2: nil, zipcode: 48202)], tags: [Community_Calendar.Tag(title: "lights", id: Optional("ck5zf48n8004n07875pang24n")), Community_Calendar.Tag(title: "holidays", id: Optional("ck5zf48nb004o0787uzb5oefq"))], ticketPrice: 5.0), Event(title: "Art & Architecture - Downtown Walking Tour", description: "Detroit is a city rich in history, grand buildings, and vibrant art surrounding public spaces. Walk with Detroit Experience Factory through the downtown area as we explore some of the great contributions of both prolific architects and emerging artists.", startDate: backendDateFormatter.date(from: "2020-01-22T17:00:00.000Z") ?? Date(), endDate: backendDateFormatter.date(from: "2020-01-22T19:30:00.000Z") ?? Date(), creator: "Detroit Experience Factory ", urls: ["https://www.eventbrite.com/e/art-architecture-downtown-walking-tour-tickets-70525424443"], images: ["https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F69917729%2F89373299245%2F1%2Foriginal.jpg?w=800&auto=format%2Ccompress&q=75&sharp=10&rect=0%2C693%2C4000%2C2000&s=94184073d91c25306d22d1b0401cfea9"], rsvps: ["Lambda Labs Community Calendar Channel"], locations: [Community_Calendar.Location(longitude: Optional(-83.045427), latitude: Optional(42.330511), name: "Roasting Plant", state: "MI", city: "Detroit", streetAddress: "600 Woodward Avenue", streetAddress2: nil, zipcode: 48202)], tags: [Community_Calendar.Tag(title: "art", id: Optional("ck5zf48ga003w0787q90nokh7")), Community_Calendar.Tag(title: "history", id: Optional("ck5zf48gj003x07870vmzgxw0")), Community_Calendar.Tag(title: "downtown", id: Optional("ck5zf48gq003y078720xvloku")), Community_Calendar.Tag(title: "architecture", id: Optional("ck5zf48gv003z0787w21hwdr0"))], ticketPrice: 0.0), Event(title: "Kwanzaa Tour at the Charles H. Wright Museum", description: "Kwanzaa is an African American seven-day cultural celebration first celebrated in 1966. Each day honors one of seven principles - the Nguzo Saba. This tour is on Day 1 and highlights African American history connected to the principle of Umoja - Unity.", startDate: backendDateFormatter.date(from: "2020-01-22T17:00:00.000Z") ?? Date(), endDate: backendDateFormatter.date(from: "2020-01-26T19:00:00.000Z") ?? Date(), creator: "Black Scroll Network History & Tours ", urls: ["https://www.eventbrite.com/e/kwanzaa-tour-at-the-charles-h-wright-museum-tickets-85347868773"], images: ["https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F83852725%2F88642988607%2F1%2Foriginal.jpg?w=800&auto=format%2Ccompress&q=75&sharp=10&rect=0%2C0%2C800%2C400&s=634757517829d19f5fb6128818867f9f"], rsvps: [], locations: [Community_Calendar.Location(longitude: Optional(-83.060526), latitude: Optional(42.358328), name: "Charles H. Wright Museum of African American History", state: "MI", city: "Detroit", streetAddress: "315 East Warren Avenue", streetAddress2: nil, zipcode: 48201)], tags: [Community_Calendar.Tag(title: "history", id: Optional("ck5zf48gj003x07870vmzgxw0")), Community_Calendar.Tag(title: "kids", id: Optional("ck5zf491y00610787l1qmue8v")), Community_Calendar.Tag(title: "family", id: Optional("ck5zf4925006307872xbhv235")), Community_Calendar.Tag(title: "kwanzaa", id: Optional("ck5zf498x006u078769noaulk")), Community_Calendar.Tag(title: "africanamerican", id: Optional("ck5zf4991006v0787l3o0rlak")), Community_Calendar.Tag(title: "heritage", id: Optional("ck5zf4995006w0787295q3u9g"))], ticketPrice: 0.0), Event(title: "2020 Shift Tap In w/ Mary Sheffield", description: "Join Mary Sheffield and friends for an intimate conversation about purpose, mindset, vision and much more. Let's talk, heal, connect and set our intentions for the 2020 Shift!!", startDate: backendDateFormatter.date(from: "2020-01-27T23:00:00.000Z") ?? Date(), endDate: backendDateFormatter.date(from: "2020-01-28T01:00:00.000Z") ?? Date(), creator: "Mary Sheffield", urls: ["https://www.eventbrite.com/e/2020-shift-tap-in-w-mary-sheffield-tickets-86524496097"], images: ["https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F85046743%2F5763501059%2F1%2Foriginal.20191219-001336?w=800&auto=format%2Ccompress&q=75&sharp=10&rect=0%2C64%2C1080%2C540&s=946121ba79ce53ba2459153c2741b52a"], rsvps: [], locations: [Community_Calendar.Location(longitude: Optional(-83.048084), latitude: Optional(42.328923), name: "Trust Cocktails, Shareables & Nightlife", state: "MI", city: "Detroit", streetAddress: "205 West Congress Street", streetAddress2: nil, zipcode: 48226)], tags: [Community_Calendar.Tag(title: "community", id: Optional("ck5zf48v9005b0787fbv3lwu9")), Community_Calendar.Tag(title: "cocktails", id: Optional("ck5zf48ve005c0787jhag621t")), Community_Calendar.Tag(title: "nightlife", id: Optional("ck5zf48vi005d07872ad2qgd8"))], ticketPrice: 20.0), Event(title: "FREE Introduction to Coding Workshop Grand Circus", description: "Looking to transition to a career in tech? Let us help you on your journey! In 2020, there will be over one million open computer-programming jobs. Here at Grand Circus, we are aiming to help fill those positions, one coder at a time. We believe anyone can become a developer.", startDate: backendDateFormatter.date(from: "2020-01-28T19:00:00.000Z") ?? Date(), endDate: backendDateFormatter.date(from: "2020-01-28T22:00:00.000Z") ?? Date(), creator: "Eastern Market Partnership ", urls: [], images: ["https://res.cloudinary.com/communitycalendar/image/upload/v1580152827/zaw0ehnfy5hnqefjchx2.jpg"], rsvps: [], locations: [Community_Calendar.Location(longitude: Optional(-83.04905), latitude: Optional(42.3344), name: "Grand Circus Detroit", state: "MI", city: "Detroit", streetAddress: "1570 Woodward Ave", streetAddress2: nil, zipcode: 48226)], tags: [Community_Calendar.Tag(title: "code", id: Optional("ck5zf49v9009a0787txhexrtn")), Community_Calendar.Tag(title: "free", id: Optional("ck5zf49ve009b0787ltsaqvn6"))], ticketPrice: 0.0), Event(title: "Detroit Lions Eastern Market Tailgating", description: "Proceeds made from tailgating go to support our mission of operating our markets, providing greater access to good food, and growing local food businesses. $45 – $180 depending on location per car", startDate: backendDateFormatter.date(from: "2020-01-29T12:00:00.000Z") ?? Date(), endDate: backendDateFormatter.date(from: "2020-01-30T00:00:00.000Z") ?? Date(), creator: "Eastern Market Partnership ", urls: ["https://www.eventbrite.com/e/detroit-lions-eastern-market-tailgating-tickets-69230968691"], images: ["https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F68668427%2F145956314054%2F1%2Foriginal.20190814-194752?w=800&auto=format%2Ccompress&q=75&sharp=10&rect=0%2C397%2C3456%2C1728&s=1344cbac19465528c33d117ec245f5ba"], rsvps: [], locations: [Community_Calendar.Location(longitude: Optional(-83.040027), latitude: Optional(42.346801), name: "Eastern Market", state: "MI", city: "Detroit", streetAddress: "Eastern Market", streetAddress2: nil, zipcode: 48208)], tags: [Community_Calendar.Tag(title: "sports", id: Optional("ck5zf49o5008j0787vlu7vnbg")), Community_Calendar.Tag(title: "football", id: Optional("ck5zf49o9008k0787yehqbe4s")), Community_Calendar.Tag(title: "lions", id: Optional("ck5zf49oe008l0787wxkdz01a")), Community_Calendar.Tag(title: "party", id: Optional("ck5zf49oi008m0787ixk277kd")), Community_Calendar.Tag(title: "tailgating", id: Optional("ck5zf49om008n0787i9obtssk"))], ticketPrice: 0.0), Event(title: "FREE Introduction to Coding Workshop Grand Circus", description: "100% Free. Designed to be fun and engaging. In just under 2 hrs, we will slowly learn to code.", startDate: backendDateFormatter.date(from: "2020-02-01T20:00:00.000Z") ?? Date(), endDate: backendDateFormatter.date(from: "2020-02-01T22:00:00.000Z") ?? Date(), creator: "Eastern Market Partnership ", urls: [], images: ["https://res.cloudinary.com/communitycalendar/image/upload/v1580152690/ed64mi2pd7ezgr3vyl6p.jpg"], rsvps: [], locations: [Community_Calendar.Location(longitude: Optional(-83.173172), latitude: Optional(42.560998), name: "Troy Technology & Entrepreneurship Meetup Group", state: "MI", city: "Troy", streetAddress: "1787 W Big Beaver", streetAddress2: nil, zipcode: 48084)], tags: [Community_Calendar.Tag(title: "kids", id: Optional("ck5zf491y00610787l1qmue8v")), Community_Calendar.Tag(title: "code", id: Optional("ck5zf49v9009a0787txhexrtn")), Community_Calendar.Tag(title: "free", id: Optional("ck5zf49ve009b0787ltsaqvn6"))], ticketPrice: 0.0), Event(title: "3D Design with TinkerCAD", description: "Use TinkerCAD modeling software to create objects that can be 3D printed. 3D printers build up thin layers of plastic to form objects. Free program for youth ages 8-14, Call 313-481-1409 for more information", startDate: backendDateFormatter.date(from: "2020-02-04T18:30:00.000Z") ?? Date(), endDate: backendDateFormatter.date(from: "2020-02-04T20:00:00.000Z") ?? Date(), creator: "Detroit Public Library ", urls: ["https://www.eventbrite.com/e/3d-design-with-tinkercad-tickets-85556223969"], images: ["https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F84135113%2F293621734690%2F1%2Foriginal.20191210-171159?w=800&auto=format%2Ccompress&q=75&sharp=10&rect=1%2C84%2C224%2C112&s=cf869634d7a67a925a7db1b8ad861f53"], rsvps: [], locations: [Community_Calendar.Location(longitude: Optional(-83.066701), latitude: Optional(42.358385), name: "Detroit Main Library, Children\'s Room", state: "MI", city: "Detroit", streetAddress: "5201 Woodward Avenue", streetAddress2: nil, zipcode: 48202)], tags: [Community_Calendar.Tag(title: "kids", id: Optional("ck5zf491y00610787l1qmue8v")), Community_Calendar.Tag(title: "teenagers", id: Optional("ck5zf49gq007n0787pqd7pabr")), Community_Calendar.Tag(title: "STEM", id: Optional("ck5zf49gv007o0787w433vz9c")), Community_Calendar.Tag(title: "tinkerCAD", id: Optional("ck5zf49h0007p0787u4005a8i")), Community_Calendar.Tag(title: "CAD", id: Optional("ck5zf49h3007q0787fzy6uxw6")), Community_Calendar.Tag(title: "engineering", id: Optional("ck5zf49h7007r0787u9zgoaht"))], ticketPrice: 0.0), Event(title: "Detroit Skating Club's 21st Annual Ice Show", description: "Another Magical Evening!", startDate: backendDateFormatter.date(from: "2020-02-06T00:00:00.000Z") ?? Date(), endDate: backendDateFormatter.date(from: "2020-02-06T03:00:00.000Z") ?? Date(), creator: "Detroit Skating Club ", urls: ["https://dscclub.com/"], images: ["https://dscclub.com/wp/wp-content/uploads/2014/02/IceShowPage.png"], rsvps: [], locations: [Community_Calendar.Location(longitude: Optional(-83.291038), latitude: Optional(42.607574), name: "Detroit Skating Club", state: "MI", city: "Bloomfield Hills", streetAddress: "888 Denison Ct", streetAddress2: nil, zipcode: 48302)], tags: [Community_Calendar.Tag(title: "kids", id: Optional("ck5zf491y00610787l1qmue8v")), Community_Calendar.Tag(title: "iceskating", id: Optional("ck5zf492100620787mqnlli57")), Community_Calendar.Tag(title: "family", id: Optional("ck5zf4925006307872xbhv235"))], ticketPrice: 10.0)
//]

enum DetailCalendar: CaseIterable {
    case detail
    case calendar
}

extension NSNotification.Name {
    static let updateEvent = NSNotification.Name("updateEvent")
}
