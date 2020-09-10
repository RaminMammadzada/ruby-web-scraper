![](https://img.shields.io/badge/Microverse-blueviolet)

Microverse Ruby Project #3 -> Tic Tac Toe game (with Object Oriented Programming)

# ruby-tic-tac-toe

![screenshot](./images/output.png)

This is a fashion follower application for helping individuals or companies to find out which kind of products are recommended more than other in the category if the interest.
The project is a web scraper and uses [kimurai](https://github.com/vifreefly/kimuraframework) gem to fetch data from Single Page Application.
By default, the script is implemented brings the top 5 reviewed products from the specific category in the Trendyol.com.
User can also specify price range from command line interface, if needed.
Both the category and the price range can be given from command line interface. 
The category can be composed of several words, but it must be given in Turkish language.

- [x] Miltestone 1 - CLI user interface is implemented.
- [x] Miltestone 2 - Implement logic to retrieve data from webpage and store them in json file.
- [x] Miltestone 3 - Update codebase to follow OOP principles
- [x] Miltestone 4 - Scraping data from Single Page Application
- [x] Miltestone 5 - Rspec tests

# Rules To Run

- The category can be composed of several words, but it must be given in Turkish language. You can see the examples below:
> If user enters ```hp bilgisar``` (computer means "bilgisayar" mean in Turkish) and 300-4000 as an price range, then it will search all computers with the hp brand that costs between 300 and 4000 Turkish Lira.

> If user enters ```nike siyah erkek ayakkabi```, it will search for ```black nike shoes for men```. 

## Built With

- Kimurai (in the backend of this gem [nokagiri](https://github.com/sparklemotion/nokogiri) gem is used)
- Ruby
- Rspec
- Rubocop

## Live Demo

[Live Demo Link]()

## Getting Started

To get a local copy up and running follow these simple example steps.

### Install
Besides the live demo link, you can run those functions in you own local environment. 
In order to run, you need to install RUBY in your computer. For windows you can go to [Ruby installer](https://rubyinstaller.org/) and for MAC and LINUX you can go to [Ruby official site](https://www.ruby-lang.org/en/downloads/) for intructions on how to intall it.
Then you can clone the project by typing ```git clone https://github.com/RaminMammadzada/ruby-web-scraper.git```

### Run app
1. Type ```./bin/main.rb``` in the root file of the project. 
You can also type ```ruby bin/main.rb``` in the root file of the project.
2. Follow the instructions given in command line interface.
    - Enter the category keywords
    ![screenshot of step 1](./images/step1_screenshot.png)
    - Enter the price range (you can also skip by pressing Enter)
    ![screenshot of step 2](./images/step2_screenshot.png)
    - Press Enter and wait some moment to get the results. The time to get the data depends on the amount of the product data.
    ![screenshot of step 3](./images/step3_screenshot.png)
        - All of the fetched products' informations are saved to [product_search_result.json](product_search_result.json) file.
        ![screenshot of step 3](images/step3b_screenshot.png)
        - If there is no product found, then it means there is no matching category forr your keywords or you gave the price range too narrow. You should run the app again and try another keywords or price range.
        ![screenshot of step 3](images/step3a_screenshot.png)
    - Here you go! You got the 5 most reviewed products with their informations.
    ![screenshot of step 4](./images/step4_screenshot.png)
     
### Run tests
In the terminal you just have to put the following command: 
```rspec```

## Testing the script

This script was tested using [RSpec](https://rspec.info/) which is a ruby testing tool. All public methods are tested.

### Install

- In a terminal window type ```gem install rspec```
- Once rspec install has finished, go to project directory and type ```rspec --init```
- You will see a folder spec and a file [.rspec](.rspec)
- Inside spec folder you'll see a [spec_helper.rb](spec/spec_helper.rb) file.

### Run the test
- Open a terminal window and type ```rspec```
- All tests should be passed:
![screenshot of tests](./images/tests_screenshot.png)



## Authors

👤 **Ramin Mammadzada**

- Github: [@RaminMammadzada](https://github.com/RaminMammadzada)
- Twitter: [@RaminMammadzada](https://twitter.com/RaminMammadzada)
- Linkedin: [@RaminMammadzada](https://www.linkedin.com/in/raminmammadzada) 

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Microverse
- Odin project

## 📝 License

This project is [MIT](lic.url) licensed.
