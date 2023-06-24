// from https://rob.co.bb/posts/2019-02-10-modular-exponentiation-in-rust/
fn mod_pow(mut base: usize, mut exp: usize, modulus: usize) -> usize {
    if modulus == 1 {
        return 0;
    }
    let mut result = 1;
    base = base % modulus;
    while exp > 0 {
        if exp % 2 == 1 {
            result = result * base % modulus;
        }
        exp = exp >> 1;
        base = base * base % modulus
    }
    result
}

fn n_repeat(n: usize) -> usize {
    let mut power = 1;
    let mut remainders: Vec<usize> = Vec::new();
    let mut rem;

    loop {
        rem = mod_pow(10, power, n);

        if rem == 0 {
            return 0;
        } else if remainders.contains(&rem) {
            return remainders.len()
        } else {
            power += 1;
            remainders.push(rem);
        }
    }

}

fn main() {
    let (ans, _) = (2..1000)
        .map(|x| (x, n_repeat(x)))
        .max_by_key(|(_, rep)| *rep)
        .unwrap();

    println!("{}", ans);
}
