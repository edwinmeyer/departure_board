# DepartureBoardClient -- A Ruby and Rails 5 Sample App 
## with RVM, Git, Github, Heroku, RSpec, NO database, and RubyMine
## Setup Notes
#### *Edwin W. Meyer*

## Introduction
*DepartureBoardClient* is a Ruby on Rails sample application that presents a trip departure board for a station with destination, trip & track numbers, expected departure times, and status.

These notes cover environment setup for this Ruby on Rails 5 app on Ubuntu 16.04 using RVM, Git, Github, and RSpec, with deployment to Heroku. Installation of the RubyMine IDE is also covered. No database is involved, since this demo app obtains its data from a static file.

## Setup Notes

### Install Ruby Version Manager (RVM)
- Note: the '$' character in the below command lines represents the terminal window command prompt.
```bash
$ sudo apt-get update # update list of available packages -- advisable for _all_ apt installations
$ gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3  # get public key for rvm
$ sudo apt-get install curl # required to install RVM
$ \curl -L https://get.rvm.io | bash -s stable # install RVM
$ source /home/edwin/.rvm/scripts/rvm # Adds rvm to ~/.bashrc
```
If RVM was previously installed, update it:
```bash
$ rvm get stable # use the default, don't use the automatic library installation option: --autolibs=enable
```

### General RVM Setup
Install the latest Ruby version into RVM. Install bundler into "global" gemset (for all gemsets using this Ruby version.)

Per http://railsapps.github.io/installrubyonrails-ubuntu.html :
```bash
$ rvm install ruby-2.4.0 # the latest ruby version released 12/25/2016.
$ rvm alias create default 2.4.0 # creates "default" as an alias for ruby-2.4.0
$ rvm use default --> Using /home/edwin/.rvm/gems/ruby-2.4.0 # See below if "RVM is not a function" is returned
$ gem -v --> 2.6.8 # now the 'gem' command is also available

# per https://gorails.com/setup/ubuntu/16.04 :
$ echo "gem: --no-ri --no-rdoc" > ~/.gemrc # Create .gemrc specifying no gem doc file installation -- Instead lookup info on the web
$ rvm gemset use global
$ gem install bundler # Successfully installed bundler-1.14.4 (into 'global' gemset for ruby-2.4.0)
```
or
```bash
$ rvm @global do gem install bundler
```

### Integrate RVM with Gnome-Terminal 
If you use the Gnome terminal window, the following may be necessary.
- In Terminal command bar | Edit | Profile Preferences :
  o click the Title tab & enter 'Profile name' as 'Rails' (or whatever you choose)
  o click the Command tab & check 'Run command as a login shell'
  o click the Close button.
- close terminal & reopen to project workspace directory (the directory in which 'departure_board' project will be created.) 
Otherwise `rvm use ...` returns "RVM is not a function"  


### Install Nokogiri
Used by all Rails apps and takes time to install. So do it once in the global gemset.
```bash
$ gem install nokogiri # Successfully installed nokogiri-1.7.0.1
```
- Note: If you get "ERROR: Failed to build gem native extension", the following may fix it:
(See http://stackoverflow.com/questions/23661011/installing-nokogiri-on-ubuntu-debian-linux)
```bash
sudo apt-get install libgmp-dev liblzma-dev zlib1g-dev # install as root user
```

### Install Node.js
Since Rails 3.1, a JavaScript runtime has been needed for development on Ubuntu Linux. Install the Node.js server-side JavaScript environment.
```bash
$ sudo apt-get install nodejs
```
- Note: If Node.js _not_ installed, add "gem 'therubyracer'" to each Rails app Gemfile 

### Install Git
```bash
$ sudo apt-get install git # version 2.7.4 is installed
```
- Note: The latest version can be installed from https://git-scm.com/downloads, but this is not usually necessary.

### Create Project Directory 
This is often prescribed as to be done during Rails app creation. However, doing this initially allows more flexibility, particularly for RVM setup.
```bash
$ mkdir departure_board
$ cd departure_board # further work done inside project directory
```

### RVM Setup for App / Install Rails
Specify the Ruby version to be used and create a gemset for the project. Install Rails into that gemset.
```bash
$ `rvm use ruby-2.4.0@departure_board --create --ruby-version` # this also creates .ruby-version and .ruby-gemset files in app root
$ gem install rails --version=5.0.1 # Install Rails latest version released 12/21/2016 into the "departure_board" gemset
```

### Create Rails App Structure that Uses No Database
Perform "rails new" with these options:
- "--skip-sprockets" -- we don't need the complexity of the asset pipeline in this demo app,
- "--skip-active-record" to use no database, 
- "--test-framework:rspec" to use the RSpec test framework, and  ## DO WE WANT THIS?
- "-T" to omit unit/mini-test file generation. (The app uses Rspec instead.)
```bash
$ rails new . --skip-sprockets --skip-active-record --test-framework:rspec -T
```
- Note 1: If "Can't find the libpq-fe.h header" is returned, perform:
```bash
$ sudo apt-get install libpq-dev # per http://askubuntu.com/questions/286617/error-cant-find-the-libpq-fe-h-header
```

- Note 2: per https://github.com/rails/rails/issues/27450:  
The native extensions for json gem versions < 1.8.5 will not compile when Ruby 2.4.0 is used.

### Create Application Elements Using Rails Generate Commands
This is a simple way of creating basic functional app with controllers, models & views from the command line.
```bash
$ rails generate scaffold DepartureBoard carrier:string scheduledtime:string destination:string trip:string track:string status:string
$ rake -T # list rake tasks as a smoke test
```
- Add to routes.rb : 
```ruby
root 'departure_board#index'
```

### Smoke Test Skeletal Rails App
```bash
$ rails server -e development -p 3000 # run from a separate console -- default environment & port explicitly provided
```
In a web browser:
`localhost:3000` # The "Welcome to Rails" static page is displayed

### Create a Git Repository
Placing the app in a git repository is a requirement for later deploying the app to Heroku.
- Per https://devcenter.heroku.com/articles/getting-started-with-rails4#store-your-app-in-git:
```bash
$ git init # Performed in the 'departure_board' app root directory 
$ git add .
$ git commit -m "initial commit of app with basic features"
```

### Create new Github Repository and Push local Repo
- Create a new 'departure_board' repo on Github per https://help.github.com/articles/creating-a-new-repository/
> https://<your github account>/departure_board # open repo dashboard
- Click 'Clone or download' button
- Click the clipboard with arrow icon to copy the project url to clipboard
- per https://help.github.com/articles/adding-an-existing-project-to-github-using-the-command-line :
- in local departure_board project root:
$ git remote add origin git@github.com:<your github account>/departure_board.git # sets remote url in local repo
$ git remote -v # verify new remote URL added properly. Returns, e.g.:
```bash
heroku	https://git.heroku.com/secure-castle-96417.git (fetch)
heroku	https://git.heroku.com/secure-castle-96417.git (push)
origin	git@github.com:edwinmeyer/departure_board.git (fetch)
origin	git@origin.com:edwinmeyer/departure_board.git (push)
```
Now there are two separate remotes: 'origin' & 'heroku'. These are independent of each other. Pushing to origin updates the Github repo; pushing to heroku installs the changes on Heroku.  

$ git push -f origin master # push repo to Github account. (have been developing in 'master' branch) -- '-f' overwrites irrelevant existing content

### Develop the Application
_So that you have something to deploy_

### Heroku Setup Prior to App Deployment
#### Download and Install Heroku Toolbelt CLI
Per https://toolbelt.heroku.com/debian :
```bash
$ wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
```
Note: This does not install git, contrary to some indications in web search results.

#### Add to Gemfile: 
```ruby
  ruby "2.4.0" # Add following the 'source' line to give Heroku the exact Ruby version
  gem 'rails_12factor', group: :production 
```
```bash
$ bundle install # and install
```

#### Commit into Git Repo
```bash
$ git add . 
$ git commit -m "update Gemfile for Heroku"
$ git push origin master
```

### Create Heroku Account and Deploy Application
Create a free account at https://signup.heroku.com/. Enter first name, last name, email, and company name. Select Ruby as primary development language. Also create a password.

```bash
$ heroku login # provide email and password used by Heroku account
```
- Note: The Heroku Toolbelt is installed upon first login

```bash
$ heroku create # Creates empty Heroku app & returns app name 'secure-castle-96417'
```
- Note: The Heroku application id 'secure-castle-96417' is that created by myself. Yours will be different.
- Following deployment, the app will be accessible using the url https://secure-castle-96417.herokuapp.com/
- Additionally, the 'heroku' remote https://git.heroku.com/secure-castle-96417.git has been added to git. (Use 'heroku' rather than 'origin' to interact with the app's repository on Heroku.)

```bash
$ git config --list | grep heroku # list the just-created remotes for heroku 
```
- Note: The remotes for Github are created below.

```bash
$ git push heroku master # Now deploy the app to Heroku
```

Note: Execute `$ heroku run rake db:migrate` for an application that uses a database (Postgres for Heroku) to perform the DB migrations.  
This app has no database, so this step is omitted.
` 
### Run the App on Heroku
```bash
$ heroku ps:scale web=1 # Ensure one dyno is running the web process type
# Returns "Scaling dynos... done, now running web at 1:Free"
$ heroku ps # check the state of the app’s dynos. Returns:
```

```bash
=== web (Free): `bin/rails server -p $PORT -e $RAILS_ENV`
web.1: up 2017/02/25 20:55:25 -0700 (~ 2m ago)
```

### View application in web browser
```bash
$ heroku open # Performs any necessary updates and opens the 'secure-castle-96417' app in the default web browser
```
or

`https://secure-castle-96417.herokuapp.com` # directly access the app in a browser


### Setup Application for RSpec Tests
In test-driven development, the tests would come first, but this would confuse the workflow and is an uncessessary complication for such a simple app. 

Add to Gemfile:
```ruby
group :development, :test do
  gem "rspec-rails", "~> 3.1.0"
  gem "factory_girl_rails", "~> 4.4.1"
end
group :test do
  gem "faker", "~> 1.4.3"
  gem "capybara", "~> 2.4.3"
  gem "database_cleaner", "~> 1.3.0"
  gem "launchy", "~> 2.4.2"
  gem "selenium-webdriver", "~> 2.43.0"
end
```
```bash
$ bundle install # and install
$ rails generate rspec:install
```
- Add to spec/rails_helper.rb:
`require 'capybara/rails'`

####  Commit and Push the repository with RSpec environment to Github and Heroku.
$ git add . # Add all new/changed code
$ git commit -m 'Add RSpec code'
- The following commands look similar, but they do quite different things:
$ git push origin master # push changes to Github repp
$ git push heroku master # intall changes into Heroku app

### Setup Java for RubyMine
RubyMine is a popular commercial Ruby IDE sold by jetbrains.com. It is a Java app, and a Java Development Kit must be installed.

- Install Oracle JDK 8 on Ubuntu per http://stackoverflow.com/questions/10178601/rubymine-on-linux & http://mattslay.com/installing-rubymine-4-on-ubuntu-12-04/

- Open http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
- download "Linux x64" jdk-8u66-linux-x64.tar.gz into ~/Downloads
Per https://docs.oracle.com/javase/8/docs/technotes/guides/install/linux_jdk.html#BJFJJEFG 
```bash
$ cd ~/apps
$ tar zxvf ~/Downloads/jdk-8u66-linux-x64.tar.gz # installed into ~/apps/jdk1.8.0_66
$ echo "export RUBYMINE_JDK=/home/edwin/apps/jdk1.8.0_66" >> ~/.bash_profile # so RubyMine can find it
```
