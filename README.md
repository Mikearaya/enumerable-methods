# Ruby Enumerable Methods [![Run on Repl.it](https://repl.it/badge/github/Mikearaya/enumerable-methods)](https://repl.it/github/Mikearaya/enumerable-methods)
my version of Ruby’s enumerable methods. Custom implementation of the Enumerable module method, methods that provides lots of handy iteration capabilities

## Getting Started

To get a local copy up and running follow these simple example steps.

- Clone or download this repository to your local workstation.

### Prerequisites

Since all the code is written using ruby `Ruby Runtime >= 1.9` is required to interpret the code. if you don't have ruby runtime installed on your computer
follow the instruction for your specific operating system on the [official installation guide](https://www.ruby-lang.org/en/documentation/installation/)

### Usage

After you have downloaded and have a local copy on your computer, open the folder using your terminal/commandline window and run

`ruby iterators.rb`

## Contents
**1. #my_each method**
  Implementation of [`#each`](https://ruby-doc.org/core-2.7.1/Enumerable.html#method-i-each_with_index)
**2. #my_each_with_index method**
  Implementation of [`#each_with_index`](https://ruby-doc.org/core-2.7.1/Enumerable.html#method-i-each_with_index)
**3. #my_select (#my_find_all, #my_filter) method**
  Implementation of [`#select, find_all, filter`](https://ruby-doc.org/core-2.7.1/Enumerable.html#method-i-select)
**4. #my_all? method**
  Implementation of [`#all?`](https://ruby-doc.org/core-2.7.1/Enumerable.html#method-i-all-3F)
**5. #my_any? method**
  Implementation of [`#any?`](https://ruby-doc.org/core-2.7.1/Enumerable.html#method-i-any-3F)
**6. #my_none? method**
  Implementation of [`#none?`](https://ruby-doc.org/core-2.7.1/Enumerable.html#method-i-none-3F)
**7. #my_count method**
  Implementation of [`#count`](https://ruby-doc.org/core-2.7.1/Enumerable.html#method-i-count)
**8. #my_map method**
   Customize Implementation of [`#map`](https://ruby-doc.org/core-2.7.1/Enumerable.html#method-i-map). this method will now take `Proc` as an argument unlike the original one. if both `Proc` and `block` is given `Proc` will have precedence
**9. #my_inject (#my_reduce) method**
  Implementation of [`#inject, (#reduce)`](https://ruby-doc.org/core-2.7.1/Enumerable.html#method-i-inject)
**10. #multiply_els method**
   New method only created for testing `my_inject` method

## Authors

👤 **Mikael Araya**

- Github: [@mikearaya](https://github.com/mikearaya)
- Twitter: [@mikearaya12](https://twitter.com/mikearaya12)
- Linkedin: [linkedin](https://linkedin.com/in/mikael-araya)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is [MIT](lic.url) licensed.
