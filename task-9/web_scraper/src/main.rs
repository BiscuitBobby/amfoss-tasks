use scraper::{Html, Selector};
use regex::Regex;
fn main() {
let url = "https://crypto.com/price/";
let response = reqwest::blocking::get(url).expect("Could not load url.");
let body = response.text().unwrap();
let document = Html::parse_document(&body);
let crypto_selector = Selector::parse("tr.css-1cxc880").expect("Could not create selector.");

let crypto_name_selector = Selector::parse("td p").unwrap();

let crypto_price_selector = Selector::parse(".css-b1ilzc").expect("Could not create selector.");

let crypto_change_selector = Selector::parse(".css-1b7j986").expect("Could not create selector.");

let crypto_volume_selector = Selector::parse(".css-1nh9lk8").expect("Could not create selector.");

let mut wtr = csv::Writer::from_path("books.csv").unwrap();
wtr.write_record(&["CryptoCurrency", "Price", "24h change", "24h volume", "Market cap"]).expect("Could not write header.");
for element in document.select(&crypto_selector){
    let crypto_name_element = element.select(&crypto_name_selector).next().expect("Could not select crypto name.");
    let crypto_name = crypto_name_element.text().collect::<String>();
    
    let price_element = element.select(&crypto_price_selector).next().expect("Could not select price element name.");
    let price = price_element.text().collect::<String>();

    let change: String = element.select(&crypto_change_selector)
    .flat_map(|el| el.text())
    .collect();

    let volume_element = element.select(&crypto_volume_selector).next().expect("Could not select volume.");
    let volume = volume_element.text().collect::<String>();

    let inner: String = element.select(&crypto_volume_selector)
    .flat_map(|el| el.text())
    .collect();
    
    let seperator = Regex::new(r"([}]+)").expect("Invalid regex");
    let mut splits: Vec<_> = seperator.split(&change).into_iter().collect();
    let change = splits.as_slice()[splits.len()-1..].to_vec();

    let seperator1 = Regex::new(r"([$]+)").expect("Invalid regex");
    let splits1: Vec<_> = seperator1.split(&inner).into_iter().collect();
    let cap = splits1.as_slice()[splits1.len()-1..].to_vec();
    let a: &str  = "$";
    let b: &str = cap[0];
    let full_string = a.to_owned()+b;
    //println!("{:?}-{:?}-{:?}-{:?}-{:?}",crypto_name,&price,change[0],volume,&full_string);
    if change[0].find("%")!=None{
    wtr.write_record([crypto_name, price, change[0].to_string(), volume,full_string[0..].to_string()]).expect("Could not create selector.");}

    else{while change[0].find("%")==None{
        let change = splits.as_slice()[splits.len()-1..].to_vec();
        if change[0].find("%")!=None{
            let change = change[0];
            let seperator2 = Regex::new(r"([css]+)").expect("Invalid regex");
            let splits2: Vec<_> = seperator2.split(&change).into_iter().collect();
            let change24 = splits2.as_slice()[0..][0];
            let change = [change24];
            println!("{:?}-{:?}",crypto_name,change[0]);
            wtr.write_record([crypto_name, price, change[0].to_string(), volume,full_string[0..].to_string()]).expect("Could not create selector.");
            break;};
        splits.pop();}}}
    wtr.flush().expect("Could not close file");
    println!("Done");}
