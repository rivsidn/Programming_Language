extern crate rand;

//这个程序没写完，决定从第三章开始学

use std::io;
use rand::Rng;

fn main() {
    println!("Guess the number!");

    let secret_number = rand::thread_rng().gen_range(1, 101);
    println!("The secret number is : {}", secret_number);

    println!("Please input your guess.");

    let mut guess = String::new();

    io::stdin().read_line(&mut guess)       //由调用者决定该变量是否可变
        .expect("Failed to read line");

    println!("you guessed: {}", guess);
}

