module.exports = {
  'Demo aigamedev test': function(browser) {
    browser
      .url('http://www.aigamedev.com')
      .assert.containsText("#container", "Featured Highlights", "Has text")
      .end();
  }
};