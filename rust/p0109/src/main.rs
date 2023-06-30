use itertools::Itertools;

fn main() {
    let singles: Vec<usize> = (1..=20).chain([25]).collect();
    let doubles: Vec<usize> = (1..=20).map(|x| x * 2).chain([50]).collect();
    let triples: Vec<usize> = (1..=20).map(|x| x * 3).collect();

    // I start with the doubles here, since we know they are all less than 100
    let mut count = doubles.len();

    // out on a throw and a double
    for x in vec![&singles, &doubles, &triples]
        .into_iter()
        .flat_map(|x| x)
    {
        count += doubles.iter().filter(|d| *d + x < 100).count();
    }

    // two throws and a double
    for x in vec![&singles, &doubles, &triples]
        .iter()
        .flat_map(|x| x.clone())
        .combinations_with_replacement(2)
    {
        let s: usize = x.into_iter().sum();
        count += doubles.iter().filter(|d| *d + s < 100).count();
    }

    println!("{}", count);
}
