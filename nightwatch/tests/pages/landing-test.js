module.exports = {
  'Check Basic': function(browser) {
    browser
      .url('http://127.0.0.1:9000/')
      .assert.containsText("h1", "nucl.ai", "It's nucl.ai!")
      .end();
  }
};