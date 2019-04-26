# URL shortener API demo

### Heroku Demo
front-end: https://shourtenedurldemo.netlify.com
API: https://bc-url-shrt.herokuapp.com/top


### Overview
The solution consists of:

1. A based36, 6 characters long generated hash for the shortened link.
2. An activerecord model for storing the details of the shortened link including the counter to store the link visit frequency.
3. A controller to redirect the user to the particular link, when they click on the shortened url. This controller will get a sanitized link from the database.

### Requirements:
```
ruby 2.4.2
Rails 5.2.3
yarn 1.3.2
```

### Setup the local env

Bring up the rails api
```
bundle install
rails db:migrate
```

### Run tests
```
bundle exec rspec
```

### Start the server
```
bin/delayed_job start
rails s

cd front_end/vue_renderer/
yarn install
yarn dev
```


### Sample Requests
```
curl -X POST -d "original_url=facebook.com" https://bc-url-shrt.herokuapp.com/short_it
  -> {"success":true,"short_url":"bc-url-shrt.herokuapp.com/isxoc0"}

curl -l https://bc-url-shrt.herokuapp.com/isxoc0
  -> <html><body>You are being <a href="http://facebook.com">redirected</a>.</body></html>

curl https://bc-url-shrt.herokuapp.com/sanitize/isxoc0
  -> {"url":"http://facebook.com"}

curl https://bc-url-shrt.herokuapp.com/top.json
  -> [{"id":2,"title":"Facebook - Log In or Sign Up","url":"http://facebook.com"},{"id":1,"title":"Google","url":"http://google.com"}]
```