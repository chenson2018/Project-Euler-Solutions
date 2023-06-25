use itertools::Itertools;

fn con_int(s: &[u64]) -> u64 {
    s.iter()
        .enumerate()
        .fold(0, |acc, (idx, next)| acc + u64::pow(10, idx as u32) * next)
}

fn main() {
    let ans: u64 = (1..=9)
        .permutations(9)
        .filter_map(|p| {
            let res = con_int(&p[5..]);

            // X * XXXX case
            let one = con_int(&p[0..=0]);
            let and_four = con_int(&p[1..=4]);

            // XX * XXX case
            let two = con_int(&p[0..=1]);
            let and_three = con_int(&p[2..=4]);

            if one * and_four == res || two * and_three == res {
                Some(res)
            } else {
                None
            }
        })
        .unique()
        .sum();

    println!("{}", ans);
}
