// side length is layers * 2 - 1
fn odd_spiral(layers: usize) -> usize {
    let mut res = 1;
    let mut base = 1;

    for layer in 1..layers {
        res += 20 * layer + 4 * base;
        base = 8 * layer + base;
    }
    res
}

fn main() {
    let ans = odd_spiral(501);
    println!("{}", ans);
}
