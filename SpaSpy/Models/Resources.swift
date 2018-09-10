//
//  Resources.swift
//  SpaSpy
//
//  Created by C4Q on 9/9/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

let myQuote = "Illicit massage businesses (IBMs) are prevalent in our communities but there is little to no visible effort to eradicate their presence and disrupt their operations of human trafficking and the exploitation of women. This app would arm the average citizen with a tool to actively contribute to the fight against human trafficking, specifically in identifying suspicious IBMs in their communities."



struct Quote: Codable {
    let source: String
    let quoteText: String
    let reportName: String
    let pageOfReport: Int
}

struct Link: Codable {
    let urlString: String
    let websiteName: String
}

let websiteLinks = [
    Link(urlString: "https://polarisproject.org/", websiteName: "Polaris"),
    Link(urlString: "https://humantraffickinghotline.org/", websiteName: "Human Trafficking Hotline"),
//    Link(urlString: "http://restorenyc.org/", websiteName: "Restore NYC")
]

let polarisIMBReportURL = "https://polarisproject.org/sites/default/files/Full_Report_Human_Trafficking_in_Illicit_Massage_Businesses.pdf"
let polarisIMBReportName = "Human Trafficking in Illicit Massage Businesses"

let fsmtbReportURL = "https://www.fsmtb.org/media/1606/httf-report-final-web.pdf"
let fsmtbReportName = "Human Trafficking Task Force Report"

let reportLinks = [
    Link(urlString: polarisIMBReportURL, websiteName: "Polaris: " + polarisIMBReportName),
    Link(urlString: "https://polarisproject.org/sites/default/files/A%20Roadmap%20for%20Systems%20and%20Industries%20to%20Prevent%20and%20Disrupt%20Human%20Trafficking.pdf", websiteName: "Polaris: On-Ramps, Intersections, and Exit Routes: A Roadmap for Systems and Industries to Prevent and Disrupt Human Trafficking (July 2018)"),
//    Link(urlString: "http://polarisproject.org/sites/default/files/2017NHTHStats%20%281%29.pdf", websiteName: "Polaris: 2017 Statistics from the National Human Trafficking Hotline and BeFree Textline"),
    Link(urlString: "http://polarisproject.org/sites/default/files/Polaris%20-%20Beneficial%20Ownership%20-%20April%202018.pdf ", websiteName: "Polaris: Hidden in Plain Sight: How Corporate Secrecy Facilitates Human Trafficking in Illicit Massage Parlors (April 2018)"),
//    Link(urlString: "https://polarisproject.org/sites/default/files/Polaris-Typology-of-Modern-Slavery.pdf ", websiteName: "Polaris: The Typology of Modern Slavery: Defining Sex and Labor Trafficking in the United States"),
    Link(urlString: "https://www.fsmtb.org/media/1606/httf-report-final-web.pdf", websiteName: "Federation of State Massage Therapy Boards: Human Trafficking Task Force Report (2017)")
]

let resourceQuotes = [
    Quote(source: polarisIMBReportURL, quoteText: "Illicit massage businesses are designed specifically to provide the comfort of a built-in cover story for buyers — that they just “wanted a massage” and had no idea that this business offered any other services. This creates a psychological comfort zone as well as a very real one. Buyers at illicit massage businesses are rarely targeted by law enforcement, and are rarely shamed, or even talked about, in the media. It is very likely that without the availability of such businesses, this particular subset of risk-averse commercial sex buyers would remove themselves from the commercial sex marketplace.", reportName: polarisIMBReportName, pageOfReport: 14),
    Quote(source: polarisIMBReportURL, quoteText: "Buyers commonly find out about IMB locations via word-of-mouth or online, where many advertise in the “massage” or “therapeutic” sections of classified ad sites like Backpage.com and Craigslist.", reportName: polarisIMBReportName, pageOfReport: 15),
    Quote(source: polarisIMBReportURL, quoteText: "Those looking for references or to ensure that these businesses are in fact selling commercial sex, not massages, can get some information about potential IMBs to visit from mainstream review sites like Yelp. For even more detail, there are IMB-specific online communities, or “review boards” such as RubMaps.com, usasexguide.com, MPReviews.com, aampmaps.com, and spahunters.com.", reportName: polarisIMBReportName, pageOfReport: 15),
    Quote(source: polarisIMBReportURL, quoteText: "RubMaps.com, the most popular of the national review boards by web traffic, receives more than 325,000 estimated unique visitors per month. It catalogues more than 7,200 open and active illicit massage businesses around the country, allowing paid subscribers to search by state and city.", reportName: polarisIMBReportName, pageOfReport: 15),
    Quote(source: polarisIMBReportURL, quoteText: "A subset of the population of IMB sex buyers who spend time on sites like RubMaps style themselves as “hobbyists” or “mongers.” They consider themselves connoisseurs of purchasing sex from these venues and tend to be repeat customers at the same IMBs.", reportName: polarisIMBReportName, pageOfReport: 16),
    Quote(source: polarisIMBReportURL, quoteText: "To get a snapshot of the average IMB buyer who is active online, we took a look at page-visitor information for the most popular IMB buyer review board, RubMaps. The average buyer participating in this online review board skews significantly more Caucasian, wealthier, and older than the general internet population. While RubMaps is just one of many online review boards and is not representative of all buyers online, these demographics to provide a sense of the voices most represented by the RubMaps reviews analyzed for this report.", reportName: polarisIMBReportName, pageOfReport: 17),
    Quote(source: polarisIMBReportURL, quoteText: "The vast majority of women reported to have been trafficked in IMBs are from China, with a relatively high number coming from the Fujian province. The next highest group are women from South Korea. There is a notable minority of IMBs that have victims from Thailand or Vietnam.", reportName: polarisIMBReportName, pageOfReport: 19),
    Quote(source: polarisIMBReportURL, quoteText: "The average age of victims in IMBs is 35-55, although we have also seen cases of trafficking victims in their late 20s and women all the way up to their late 60s.", reportName: polarisIMBReportName, pageOfReport: 19),
    Quote(source: polarisIMBReportURL, quoteText: "Most women recruited have no more than a high school education and know very little or no English when they arrive in the United States.", reportName: polarisIMBReportName, pageOfReport: 19),
    Quote(source: polarisIMBReportURL, quoteText: "Traffickers also work to make sure the women look to police not as a source of help, but as indifferent at best, and a threat at worst. They do this by taking advantage of the women’s experience with police in their home countries, which includes both indifference and widespread corruption. In China, one in four women has experienced domestic violence, and most do not expect or receive assistance from the police.", reportName: polarisIMBReportName, pageOfReport: 31),

    Quote(source: fsmtbReportURL, quoteText: "There are many ways traffickers hide their activities and the exploitation of their victims. Massage therapy is one of the arenas in which they frequently operate. They may use massage, spa, reflexology, foot massage, bodywork, modeling, or another kind of service as a front. Illegal establishments often house individuals who have cheated to obtain a massage therapy credential, if a license is obtained at all. Unlicensed practice is common. In other cases, human trafficking is disguised as “free-agent prostitution” and marketed as massage.", reportName: fsmtbReportName, pageOfReport: 9),
    Quote(source: fsmtbReportURL, quoteText: "Polaris estimates range from 6,000 to 9,000 total active IMBs in the United States. Its more conservative estimate is 6,500. In 2016, Polaris noted a marked decrease in the number of IMBs, documenting the closing of nearly 100 IMBs by law enforcement using in part what Polaris refers to as a networked approach, or a strategy addressing IMBs as larger operations, not simply as stand-alone businesses. Similarly, an estimate in 2012 indicated that there were over 7,000 illegal prostitution sites posing as legitimate massage establishments.", reportName: fsmtbReportName, pageOfReport: 9),
    Quote(source: fsmtbReportURL, quoteText: "The states with the highest concentration of IBs are California, Texas, New York, Florida and New Jersey.", reportName: fsmtbReportName, pageOfReport: 10)
]
