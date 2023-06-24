use ndarray::{arr1, arr2, ArrayBase, Dim, OwnedRepr};
use std::{collections::HashMap, hash::Hash};

fn primitives(layers: usize) -> Vec<Vec<ArrayBase<OwnedRepr<isize>, Dim<[usize; 1]>>>> {
    let a = arr2(&[[1, -2, 2], [2, -1, 2], [2, -2, 3]]);
    let b = arr2(&[[1, 2, 2], [2, 1, 2], [2, 2, 3]]);
    let c = arr2(&[[-1, 2, 2], [-2, 1, 2], [-2, 2, 3]]);

    let mut res = vec![vec![arr1(&[3, 4, 5])]];

    for _ in 0..layers {
        let mut p = Vec::new();
        for node in res.last().cloned().unwrap() {
            p.push(a.dot(&node));
            p.push(b.dot(&node));
            p.push(c.dot(&node));
        }
        res.push(p);
    }
    res
}

fn mode<T, I>(numbers: T) -> Option<I>
where
    T: IntoIterator<Item = I>,
    I: Copy + Hash + Eq,
{
    let mut counts = HashMap::new();

    numbers.into_iter().max_by_key(|&n| {
        let count = counts.entry(n).or_insert(0);
        *count += 1;
        *count
    })
}

fn main() {
    // cheating a bit by taking the number of layers needed
    // don't feel like making it check for perimiter elsewhere or take a closure
    let prims = primitives(14);
    let perimiter_limit = 1000;

    let primitive_perimiters: Vec<isize> = prims
        .iter()
        .flatten()
        .map(|col| col.sum())
        .filter(|x| x <= &perimiter_limit)
        .collect();

    let all_perimiters: Vec<isize> = primitive_perimiters
        .iter()
        .map(|p| {
            let mut res = Vec::new();
            let mut mult = *p;

            while mult < perimiter_limit {
                res.push(mult);
                mult += p;
            }

            res
        })
        .flatten()
        .collect();

    println!("{:?}", mode(all_perimiters).unwrap());
}
