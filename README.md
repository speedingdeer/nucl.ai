# nucl.ai

Set up development enviroment
```
npm install # for grunt and related
bower install # for bower components (lib/)
bundle install # to test against to gh-pages gem (includes jekyll)
```

Deploy changes (assumed they are already in master)
```
grunt clean # clean all generated/synced assets
git commit # check in changes
git checkout gh-pages # get to the right branch
git rebase|merge master # get changes (rebase or merge becasue the history is kept in master - minified files don't have to have too much sens)
git grunt build # build generate/sync assets
git commit # deploy to github pages
```

Run Server
```
grunt serve
```

Execute Jekyll out of Grunt
```
bundle exec jekyll (build/serve)
```
