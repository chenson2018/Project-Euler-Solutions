use itertools::Itertools;

fn pentagonal(n: isize) -> isize {
    (n * (3 * n - 1)) / 2
}

fn main() {
    let pent: Vec<isize> = (1..=2400).map(pentagonal).rev().collect();

    for ((_idx1, p1), (_idx2, p2)) in pent
        .iter()
        .enumerate()
        .cartesian_product(pent.iter().enumerate())
    {
        let sum = p1 + p2;
        let dif = p1 - p2;
        match (
            pent.iter().position(|x| x == &sum),
            pent.iter().position(|x| x == &dif),
        ) {
            (Some(_sum_idx), Some(_dif_idx)) => {
                println!("{}", dif);
                break;
            }
            _ => (),
        }
    }
}
