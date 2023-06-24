// this returns a vector of the base factorial representation
// See https://en.wikipedia.org/wiki/Factorial_number_system
// I leave it in reverse order so it can be padded easily
fn base_factorial(n: u32) -> Vec<u32> {
    let mut quo = n;
    let mut div = 1;
    let mut rem;

    let mut res: Vec<u32> = Vec::new();

    while quo != 0 {
        (quo, rem) = (quo / div, quo % div);
        res.push(rem);
        div += 1;
    }
    res
}

// idx is zero indexed
fn lexicographic_n(n_digits: u32, idx: u32) -> Result<Vec<u32>, &'static str> {
    if idx >= (1..=n_digits).product() {
        Err("Requested index greater than n_digits!.")
    } else {
        let mut unused: Vec<u32> = (0..n_digits).collect();

        // pad and reverse
        let mut bf = base_factorial(idx);
        bf.resize(n_digits as usize, 0);

        Ok(bf
            .iter()
            .rev()
            .map(|fac_digit| unused.remove(*fac_digit as usize))
            .collect())
    }
}

fn main() {
    let ans = lexicographic_n(10, 999_999)
        .unwrap()
        .iter()
        .map(|x| x.to_string())
        .collect::<Vec<String>>()
        .join("");
    println!("{}", ans);
}
