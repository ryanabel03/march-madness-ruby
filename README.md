# Getting Started
1. Install ruby
```
rbenv install 2.3.8
```

2. Create your own strategy

Inherit from `strategies/base.rb` and implement the `decide_winner` method.
There is an example in `strategies/top_seeds.rb`.


3. Run your strategy
* Add a `require` for your strategy at the top of `runner.rb`
* Replace the last line of that file with your new strategy class
