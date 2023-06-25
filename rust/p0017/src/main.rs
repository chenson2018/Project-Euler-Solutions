use std::collections::HashMap;

fn main() {
    let map: HashMap<u16, &'static str> = HashMap::from([
        (1, "one"),
        (2, "two"),
        (3, "three"),
        (4, "four"),
        (5, "five"),
        (6, "six"),
        (7, "seven"),
        (8, "eight"),
        (9, "nine"),
        (10, "ten"),
        (11, "eleven"),
        (12, "twelve"),
        (13, "thirteen"),
        (14, "fourteen"),
        (15, "fifteen"),
        (16, "sixteen"),
        (17, "seventeen"),
        (18, "eighteen"),
        (19, "nineteen"),
        (20, "twenty"),
        (30, "thirty"),
        (40, "forty"),
        (50, "fifty"),
        (60, "sixty"),
        (70, "seventy"),
        (80, "eighty"),
        (90, "ninety"),
        (1000, "one thousand"),
    ]);

    let mut ans = 0;

    for i in 1..=1000 {
        let two_digits = i % 100;

        let two_d_str = {
            if two_digits == 0 {
                "".to_string()
            } else if two_digits <= 20 {
                map.get(&two_digits).unwrap().to_string()
            } else {
                let tens_int = (two_digits / 10) * 10;

                let ones_int = two_digits % 10;
                let ones = if ones_int == 0 {
                    ""
                } else {
                    map.get(&ones_int).unwrap()
                };

                format!("{} {}", map.get(&tens_int).unwrap(), ones)
            }
        };

        let hundred = (i / 100) % 10;
        let hs = if hundred == 0 {
            "".to_string()
        } else {
            let and = if two_digits == 0 { "" } else { " and " };
            format!("{} hundred{}", map.get(&hundred).unwrap(), and)
        };

        let fin = if i == 1000 {
            "one thousand".to_string()
        } else {
            format!("{}{}", hs, two_d_str)
        };

        ans += fin.chars().filter(|c| c != &'-' && c != &' ').count();
    }

    println!("{}", ans);
}
