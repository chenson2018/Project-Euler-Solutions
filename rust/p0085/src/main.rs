use itertools::Itertools;

fn calc_rectangles(x: isize, y: isize) -> isize {
    (1..=x)
        .cartesian_product(1..=y)
        .map(|(xp, yp)| (x - xp + 1) * (y - yp + 1))
        .sum()
}

fn main() {
    let mut x = 1;
    let mut y = 1;

    // fix one var, increase the other unti in excess of 2_000_00
    // we we get to a row that starts by exceeding 2_000_000, we know we can stop
    let mut res: Vec<(isize, isize, isize)> = Vec::new();
    let target = 2_000_000;

    loop {
        loop {
            let comb = calc_rectangles(x, y);
            res.push((x, y, comb));

            if comb >= target {
                y = 1;
                break;
            } else {
                y += 1;
            }
        }
        x += 1;

        if calc_rectangles(x, y) >= target {
            break;
        }
    }

    let (x_ans, y_ans, _) = res
        .iter()
        .min_by_key(|(_, _, c)| (target - c).abs())
        .unwrap();

    println!("{}", x_ans * y_ans);
}
