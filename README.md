# nucl.ai

Once [node/npm](http://nodejs.org) and [ruby](https://www.ruby-lang.org/en/downloads/)/[gem](https://rubygems.org/pages/download) are installed, set up development enviroment
```
npm install # for grunt and related
npm install -g grunt-cli # (as admin) for the grunt command line tool
npm install -g bower # (as admin) for the bower command line tool
gem install bundler # (as admin) for the bundler command line tool
bundle install # to test against to gh-pages gem (includes jekyll)
```

Deploy changes (assumed they are already in master)
```
grunt clean                 # clean all generated/synced assets
git commit                  # check in changes
git checkout gh-pages       # get to the right branch
git merge master            # get changes to preserve history in master
grunt build                 # build generate/sync assets
git commit -a               # commit all changes
git push [remote] gh-pages  # push to gh-pages
```

Run Server
```
grunt serve
```

Execute Jekyll out of Grunt
```
bundle exec jekyll (build/serve)
```

Run Test
```
grunt serve # run server and watch for file changes
# open new tab and type
grunt test [--headless=true|false] (default=true) # execute nightwatch tests by default in headless mode (phantom.js)
```

Execute Jekyll out of Grunt
```
bundle exec jekyll (build/serve)
```
