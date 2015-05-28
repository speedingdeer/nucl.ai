var expect = require('chai').expect;

module.exports = {
  'Check Topics Thumbnails': function(browser) {
    browser
      .url(browser.globals.domain)
      .assert.elementNotPresent("#section-topics item.thumbnail a.selected")
      .assert.elementNotPresent("#section-topics item.description:visible")
      .click("#section-topics item.thumbnail a")
      .elements_count("#section-topics item.description:visible", function(val) {
        expect(val).to.equal(1); //exactly one description was expanded
      })
      .end();
  }
};