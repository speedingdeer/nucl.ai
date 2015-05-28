module.exports = {
  'Check Title': function(browser) {
    browser
      .url(browser.globals.domain)
      .assert.containsText("h1", "nucl.ai", "It's nucl.ai!")
      .end();
  }
};