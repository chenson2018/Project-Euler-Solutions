use std::collections::HashMap;
use itertools::Itertools;

fn dist(n_faces: u32, n_dice: u32) -> HashMap<u32, f64> {
    let mut counts: HashMap<u32, u32> = HashMap::new();
    let mult = (0..n_dice).map(|_| (1..=n_faces)).multi_cartesian_product();

    let total = u32::pow(n_faces, n_dice) as f64;

    for x in mult {
        let count = counts.entry(x.iter().sum()).or_insert(0);
        *count += 1;
    }

    counts
        .iter()
        .map(|(face, count)| (*face, (*count as f64) / total))
        .collect()
}

// checks probability a > b
fn compare_dist(a: HashMap<u32, f64>, b: HashMap<u32, f64>) -> f64 {
    a.iter()
        .map(|(roll_a, p_a)| -> f64 {
            // sum all probabilities for rolls from b that are less
            p_a * b
                .iter()
                .filter_map(|(roll_b, p_b)| if roll_a > roll_b { Some(p_b) } else { None })
                .sum::<f64>()
        })
        .sum()
}

fn main() {
    let nine_d4 = dist(4, 9);
    let six_d6 = dist(6, 6);
    let ans = compare_dist(nine_d4, six_d6);
    println!("{:.7}", ans);
}
