# TravBook
I've been there before.

### Dependencies
* PostgreSQL
* Ruby
* Bundler

### Setup
1. Install **PostgreSQL**

	``` Shell
	brew install postgresql
	```

2. Install **Ruby**
   ``` Shell
   brew install rbenv ruby-build
   rbenv install 2.3.0
   rbenv global 2.3.0
   gem install bundler
   ```

3. Install the bundle
   
   ``` Shell
   bundle install
   ```
   
   If you encounter problems building **nokogiri** with native extensions, run the following command first:

	``` Shell
	xcode-select --install
	```

4. Setup the database
   
   ``` Shell
   # run `brew info postgresql` to checkout how to start it at login
   postgres -D /usr/local/var/postgres
   bundle exec rake db:setup
   ```

5. Start the app
   
   ``` Shell
   bundle exec rails-api server
   ```
