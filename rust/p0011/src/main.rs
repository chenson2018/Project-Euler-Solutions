use ::ndarray::{Array2, Axis};

fn main() {
    let input_str = std::fs::read_to_string("input.txt").expect("Unable to read input.");

    let input: Vec<Vec<u64>> = input_str
        .lines()
        .map(|line| {
            line.split(" ")
                .map(|num_str| num_str.parse().unwrap())
                .collect()
        })
        .collect();

    let mut arr = Array2::<u64>::default((20, 20));
    for (i, mut row) in arr.axis_iter_mut(Axis(0)).enumerate() {
        for (j, col) in row.iter_mut().enumerate() {
            *col = input[i][j];
        }
    }

    let mut ans = 0;

    for four in arr.windows([1, 4]) {
        ans = std::cmp::max(ans, four.product());
    }

    for four in arr.windows([4, 1]) {
        ans = std::cmp::max(ans, four.product());
    }

    for row in 0..17 {
        for col in 0..17 {
            ans = std::cmp::max(
                ans,
                input[row][col]
                    * input[row + 1][col + 1]
                    * input[row + 2][col + 2]
                    * input[row + 3][col + 3],
            )
        }
    }

    for row in 0..17 {
        for col in 3..20 {
            ans = std::cmp::max(
                ans,
                input[row][col]
                    * input[row + 1][col - 1]
                    * input[row + 2][col - 2]
                    * input[row + 3][col - 3],
            )
        }
    }

    println!("{}", ans);
}
