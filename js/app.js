(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.config = {
    header: {
      scrollSpeed: 500
    },
    thumbnails: {
      borderSize: 0.015
    }
  };

}).call(this);

(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.animate = {
    onAnimatedEnd: "webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend",
    onTransitonEnd: "transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd"
  };

}).call(this);

(function() {
  var descriptionInClass, descriptionOutClass, root, slideInClass, slideOutClass;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  slideInClass = "fadeInLeftBig";

  slideOutClass = "fadeOutRightBig";

  descriptionInClass = "fadeInRightBig";

  descriptionOutClass = "fadeOutLeftBig";

  $(function() {
    var select;
    select = function(collection, extras, menu, clicked, inClass, outClass) {
      var extra, selected, slideIn, _i, _j, _len, _len1, _results;
      slideIn = function(selected, collection, inClass, outClass) {
        if (selected.hasClass("selected")) {
          selected.addClass(outClass);
          selected.removeClass(inClass);
          selected.addClass(outClass);
          return selected.one(animate.onAnimatedEnd, function() {
            if (!menu.find("item[name='" + selected.attr('name') + "']").hasClass("selected")) {
              selected.removeClass("selected");
            }
            if (clicked.hasClass("selected")) {
              selected = collection.find("item[name='" + clicked.attr('name') + "']");
              selected.removeClass(outClass);
              selected.addClass("selected " + inClass);
              return selected.one(animate.onAnimatedEnd, function() {
                if (clicked.hasClass("selected")) {
                  selected.find("div.cover").removeClass("fadeIn");
                  return selected.find("div.cover").addClass("fadeOut");
                }
              });
            }
          });
        }
      };
      selected = collection.find("item.selected");
      for (_i = 0, _len = extras.length; _i < _len; _i++) {
        extra = extras[_i];
        extra.selected = extra.find("item.selected");
      }
      if (selected.find("div.cover").hasClass("fadeOut")) {
        selected.find("div.cover").removeClass("fadeOut");
        selected.find("div.cover").addClass("fadeIn");
        return selected.one(animate.onAnimatedEnd, function() {
          var _j, _len1, _results;
          slideIn(selected, collection, slideInClass, slideOutClass);
          _results = [];
          for (_j = 0, _len1 = extras.length; _j < _len1; _j++) {
            extra = extras[_j];
            _results.push(slideIn(extra.selected, extra, descriptionInClass, descriptionOutClass));
          }
          return _results;
        });
      } else {
        slideIn(selected, collection, slideInClass, slideOutClass);
        _results = [];
        for (_j = 0, _len1 = extras.length; _j < _len1; _j++) {
          extra = extras[_j];
          _results.push(slideIn(extra.selected, extra, descriptionInClass, descriptionOutClass));
        }
        return _results;
      }
    };
    return $("gallery").each(function() {
      var descriptions, galery, menu, slides;
      galery = $(this);
      menu = galery.find("menu");
      slides = galery.find("slides");
      descriptions = galery.find("descriptions");
      return menu.find("item").click(function() {
        var clicked, selected;
        clicked = $(this);
        selected = menu.find("item.selected");
        if (selected.is(clicked)) {
          return false;
        }
        selected.removeClass("selected");
        clicked.addClass("selected");
        return select(slides, [descriptions], menu, clicked, slideInClass, slideOutClass);
      });
    });
  });

}).call(this);

(function() {


}).call(this);

(function() {
  $(function() {
    var thumbnails;
    if ($("#section-people").length > 0) {
      return thumbnails = new Thumbnails("section-people", true, false);
    }
  });

}).call(this);

(function() {
  $(function() {
    var setSponsorsSize;
    setSponsorsSize = function() {
      return $("item.sponsor").each(function() {
        var sponsor;
        sponsor = $(this);
        return sponsor.height(sponsor.width());
      });
    };
    $(window).resize(function() {
      return setSponsorsSize();
    });
    return setSponsorsSize();
  });

}).call(this);

(function() {
  var LONG_INTERAL, SHORT_INTERVAL, effectIn, effectOut;

  effectIn = "flipInX";

  effectOut = "flipOutX";

  SHORT_INTERVAL = 450;

  LONG_INTERAL = 10000;

  $(function() {
    var change, idxCurrent, next, pair, select, testimonials;
    testimonials = $(".testimonial").toArray();
    idxCurrent = 0;
    pair = 0;
    change = function() {
      var interval;
      interval = LONG_INTERAL;
      if (idxCurrent % 2 !== 0) {
        interval = SHORT_INTERVAL;
      }
      return setTimeout(select, interval);
    };
    next = function(idx, incBy) {
      idx += incBy;
      if (idx === testimonials.length) {
        return 0;
      }
      if (idx === testimonials.length + 1) {
        return 1;
      }
      return idx;
    };
    select = function() {
      var nextIdx, wasCurrent;
      if (pair === 2) {
        return change();
      }
      pair += 1;
      $(testimonials[idxCurrent]).removeClass(effectIn);
      $(testimonials[idxCurrent]).addClass(effectOut);
      wasCurrent = idxCurrent;
      nextIdx = next(idxCurrent, 2);
      idxCurrent = next(idxCurrent, 1);
      change();
      return $(testimonials[wasCurrent]).one(animate.onAnimatedEnd, function() {
        pair -= 1;
        $(testimonials[wasCurrent]).removeClass("selected");
        $(testimonials[nextIdx]).removeClass(effectOut);
        return $(testimonials[nextIdx]).addClass("selected " + effectIn);
      });
    };
    return change();
  });

}).call(this);

(function() {
  $(function() {
    var thumbnails;
    if ($("#section-topics").length === 0) {
      return;
    }
    return thumbnails = new Thumbnails("section-topics", true, false);
  });

}).call(this);

(function() {
  var enableSections, root, scroll;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.scrollLocked = false;

  scroll = function(id, scrollTo) {
    var promise;
    root.scrollLocked = true;
    promise = $('html, body').animate({
      scrollTop: scrollTo
    }, config.header.scrollSpeed, function() {}).promise();
    return promise.done(function() {
      if (history.replaceState) {
        history.replaceState(null, null, "#" + id);
        return setTimeout(function() {
          return root.scrollLocked = false;
        }, 300);
      }
    });
  };

  root.scroll = scroll;

  enableSections = function() {
    var bottomEdge;
    if ($("content").length === $("content.visited").length) {
      return;
    }
    bottomEdge = $(window).scrollTop() + $(window).height();
    return $("section").each(function() {
      if ($(this).offset().top < bottomEdge) {
        return $(this).find("content, h2").addClass("visited");
      }
    });
  };

  $(window).load(function() {
    return root.scrollLocked = false;
  });

  $(function() {
    if (navigator.userAgent.match(/(iPad|iPhone|iPod)/g)) {
      $("html").addClass("ios");
    }
    $(window).scroll(function() {
      enableSections();
      if (!root.scrollLocked && window.location.hash !== "") {
        if ($(window.location.hash).offset().top * 0.95 > $(window).scrollTop() || $(window.location.hash).offset().top * 1.05 < $(window).scrollTop()) {
          if (history.replaceState) {
            return history.replaceState(null, null, ' ');
          }
        }
      }
    });
    return enableSections();
  });

  enableSections();

}).call(this);

(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  $(function() {
    var expanded, links, navigation, selectNavPosition, splash;
    navigation = $(".navigation");
    splash = $("section.splash-screen");
    links = $(".navigation a");
    links.each(function() {
      var hash;
      this.jQlink = $(this);
      hash = this.jQlink.attr("href") ? this.jQlink.attr("href").split("#")[1] : "";
      this.jQscrollTo = $("#" + hash);
      if (!hash || hash === "") {
        return this.jQsection = [];
      } else {
        return this.jQsection = $("section." + hash);
      }
    });
    expanded = $(".navigation a.expanded");
    $('html').click(function() {
      expanded = $(".navigation a.expanded");
      expanded.toggleClass("expanded");
      expanded.parent().toggleClass("expanded");
      return expanded = $(".navigation a.expanded");
    });
    links.each(function() {
      return this.jQlink.click(function(event) {
        var linkHref;
        event.stopPropagation();
        if (this.jQlink.hasClass("expandable") && !(this.jQlink.hasClass("disabled"))) {
          this.jQlink.toggleClass("expanded");
          this.jQlink.parent().toggleClass("expanded");
          if (expanded.length === 1 && expanded[0] !== this.jQlink[0]) {
            expanded.toggleClass("expanded");
            expanded.parent().toggleClass("expanded");
          }
          expanded = $(".navigation a.expanded");
          return false;
        }
        if (expanded.length === 1) {
          expanded.toggleClass("expanded");
          expanded.parent().toggleClass("expanded");
          expanded = $(".navigation a.expanded");
        }
        if (this.jQlink.hasClass("disabled")) {
          return false;
        }
        if (!(this.jQlink.attr("href"))) {
          return;
        }
        linkHref = this.jQlink.attr("href");
        if (linkHref.substring(0, 1) === "/") {
          return true;
        }
        root.scroll(this.jQscrollTo.attr("id"), this.jQscrollTo.offset().top);
        return false;
      });
    });
    selectNavPosition = function() {
      var linkToSelect;
      linkToSelect = null;
      links.each(function() {
        if (this.jQsection.length === 0) {
          return;
        }
        if ($(window).scrollTop() + navigation.height() >= -1 + this.jQsection.offset().top && $(window).scrollTop() + navigation.height() < this.jQsection.offset().top + this.jQsection.height()) {
          if (navigation.hasClass("sticky")) {
            return linkToSelect = this.jQlink;
          }
        }
      });
      navigation.find("item.selected").removeClass("selected");
      if (linkToSelect) {
        if (linkToSelect.hasClass("logo")) {
          linkToSelect.parent().parent().addClass("selected");
        }
        return linkToSelect.parent().addClass("selected");
      }
    };
    return $(window).scroll(function() {
      if ($(this).scrollTop() > splash.height() - navigation.height()) {
        navigation.addClass("sticky");
      } else {
        navigation.removeClass("sticky");
      }
      if ($("sections.page").length > 0) {
        return;
      }
      return selectNavPosition();
    });
  });

}).call(this);

(function() {


}).call(this);

(function() {
  $(function() {
    var thumbnails;
    if ($("#section-tracks").length === 0) {
      return;
    }
    return thumbnails = new Thumbnails("section-tracks", true, true);
  });

}).call(this);

(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  $(function() {
    var days, speakers;
    speakers = $("section.program-schedule p.speakers");
    speakers.each(function() {
      var idx, studio, studios, _i, _len, _results;
      if ($(this).find(".studio").length > 1) {
        studios = [];
        $(this).find(".studio").each(function() {
          return studios.push($(this));
        });
        _results = [];
        for (idx = _i = 0, _len = studios.length; _i < _len; idx = ++_i) {
          studio = studios[idx];
          if (idx < studios.length - 1) {
            if (studio.html() === studios[idx + 1].html()) {
              _results.push(studio.remove());
            } else {
              _results.push(void 0);
            }
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      }
    });
    days = $("section.program-schedule table.talks-list");
    days.each(function() {
      var day, talks, talksArray;
      day = $(this);
      talks = day.find("div.track");
      talksArray = [];
      talks.each(function() {
        return talksArray.push($(this));
      });
      talksArray.sort(function(a, b) {
        var aTime, bTime;
        aTime = a.attr("time") !== "" ? a.attr("time") : "11:59 pm";
        bTime = b.attr("time") !== "" ? b.attr("time") : "11:59 pm";
        return new Date("2001/01/01 " + aTime) - new Date("2001/01/01 " + bTime);
      });
      day.find("td").html("");
      day.append(talksArray);
      return day.removeClass("not-initialized");
    });
    return $(".button-expand").click(function() {
      var button, name, talksList;
      button = $(this);
      button.toggleClass("expanded");
      name = $(this).attr("name");
      talksList = $("table.talks-list[name='" + name + "']");
      talksList.removeClass("not-expanded");
      if (!button.hasClass("expanded")) {
        talksList.addClass("zoomOut");
      } else {
        talksList.removeClass("zoomOut");
      }
      return talksList.one(animate.onAnimatedEnd, function() {
        if (!button.hasClass("expanded")) {
          return talksList.addClass("not-expanded");
        }
      });
    });
  });

}).call(this);

(function() {
  $(function() {
    var hoverIn, hoverOut, hoverToggle, scrollToEventbriteTickets;
    hoverIn = function() {
      return hoverToggle("in", $(this));
    };
    hoverOut = function() {
      return hoverToggle("out", $(this));
    };
    hoverToggle = function(inOut, cell) {
      var wrap;
      wrap = cell.parent().parent();
      if (cell.parent().hasClass("invisible")) {
        return;
      }
      cell.parent().find(".centered-cell").each(function() {
        if (!$(this).parent().hasClass("titlerow") && !$(this).parent().hasClass("invisible")) {
          if (inOut === "in") {
            $(this).addClass("hovered");
          }
          if (inOut === "out") {
            return $(this).removeClass("hovered");
          }
        }
      });
      if (cell.hasClass("all-access")) {
        wrap.find(".all-access .centered-cell").each(function() {
          if (inOut === "in") {
            $(this).addClass("hovered");
          }
          if (inOut === "out") {
            return $(this).removeClass("hovered");
          }
        });
      }
      if (cell.hasClass("conference")) {
        return wrap.find(".conference .centered-cell").each(function() {
          if (inOut === "in") {
            $(this).addClass("hovered");
          }
          if (inOut === "out") {
            return $(this).removeClass("hovered");
          }
        });
      }
    };
    $("div.table").hover(hoverIn, hoverOut);
    scrollToEventbriteTickets = function() {
      return $('html, body').animate({
        scrollTop: $("#purchase").offset().top
      }, config.header.scrollSpeed);
    };
    $(".buy-tickets-link").click(function() {
      scrollToEventbriteTickets();
      return false;
    });
    if ($(".tickets.prices").length === 0) {
      return;
    }
    return $(".tickets.prices .centered-cell, .conference-good .centered-cell").click(function() {
      if ($(this).parent().parent().attr("name") === "Access to the Main Amphitheatre") {
        window.location = "/program/overview/#main-amphitheatre";
        return false;
      }
      if ($(this).parent().parent().attr("name") === "Access to the Masterclass Room") {
        window.location = "/program/overview/#masterclass-room";
        return false;
      }
      if ($(this).parent().parent().attr("name") === "Access to the Open Laboratory") {
        window.location = "/program/overview/#open-laboratories";
        return false;
      }
      return scrollToEventbriteTickets();
    });
  });

}).call(this);

(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  $(function() {
    var thumbnails;
    if ($("#section-tracks-menu").length > 0) {
      thumbnails = new Thumbnails("section-tracks-menu", true, true);
    }
    if ($("#track-content").length > 0) {
      thumbnails = new Thumbnails("track-content", true, true);
    }
    if ($("#section-tracks-people").length > 0) {
      thumbnails = new Thumbnails("section-tracks-people", true, true);
    }
    $("h3 a, li a.scrollable").click(function() {
      var id;
      id = $(this).attr("href").split("#")[1];
      root.scroll(id, $("#" + id).offset().top);
      return false;
    });
    return $(".tracks-people .track-topic a").click(function() {
      var id;
      id = $(this).attr("href").split("#")[1];
      if ($("#" + id).length > 0) {
        root.scroll(id, $("#" + id).offset().top);
      }
      return false;
    });
  });

}).call(this);

(function() {
  $(function() {
    var initialize;
    initialize = function() {
      var latLng, map, mapCanvas, mapOptions, marker;
      mapCanvas = document.getElementById('venue-map-canvas');
      if (mapCanvas === null) {
        return;
      }
      latLng = new google.maps.LatLng(48.217192, 16.353283);
      mapOptions = {
        scrollwheel: false,
        center: latLng,
        zoom: 17,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      map = new google.maps.Map(mapCanvas, mapOptions);
      return marker = new google.maps.Marker({
        position: latLng,
        map: map
      });
    };
    return google.maps.event.addDomListener(window, 'load', initialize);
  });

}).call(this);

(function() {
  $(window).load(function() {
    var backgroundImage;
    backgroundImage = assets.audienceGif;
    return $("<img />").attr('src', backgroundImage).load(function() {
      if ($("div.splash-screen-wrap.audience-gif").length > 0) {
        return $("div.splash-screen-wrap").css('background-image', 'url("' + backgroundImage + '")');
      }
    });
  });

  $(function() {
    $('logo-wrap').addClass("rotated");
    $('logo-wrap').removeClass("opacity0");
    return $('titles').removeClass("opacity0");
  });

}).call(this);

(function() {
  var Thumbnails, root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  Thumbnails = (function() {
    function Thumbnails(sectionId, animated, justSize, drawSvg) {
      var selectedId, that;
      this.animated = animated;
      this.justSize = justSize;
      this.drawSvg = drawSvg;
      that = this;
      this.section = $("#" + sectionId);
      if (this.section.length !== 1) {
        console.warn("Can't discover section " + section_selector);
        return;
      }
      this.paper = Raphael(sectionId, "100%", "100%");
      this.svg = this.section.find("svg");
      this.wraps = this.section.find("thumbnail-wrap");
      this.shortBios = this.section.find("div.short-bio-wrap");
      this.thumbnails = this.section.find("a.thumbnail");
      this.checkBckgImg();
      $(window).resize(function() {
        that.setThumbnailSize();
        if (that.svg && that.svg.find("path").length > 0) {
          that.clearLine();
          return that.drawLine();
        }
      });
      this.thumbnails.each(function() {
        var t;
        this.jQthumbnail = $(this);
        this.jQdescription = that.section.find(".description[name='" + $(this).attr('name') + "']");
        this.jQtitle = that.section.find("item.thumbnail .thumbnail-title[name='" + $(this).attr('name') + "']");
        t = this;
        return t.jQthumbnail.hover(function() {
          return t.jQtitle.addClass("hover");
        }, function() {
          return t.jQtitle.removeClass("hover");
        });
      });
      this.setThumbnailSize();
      if (this.justSize) {
        this.thumbnails.each(function() {
          if (this.jQthumbnail.hasClass("disabled")) {
            this.jQthumbnail.click(function() {
              return false;
            });
          }
          if (this.jQthumbnail.hasClass("scrollable")) {
            return this.jQthumbnail.click(function() {
              var id;
              id = $(this).attr("href").split("#")[1];
              root.scroll(id, $(".tracks-people #" + id).offset().top).done(function() {
                if (!$(".tracks-people #thumbnail-id-" + id).hasClass("selected")) {
                  return $(".tracks-people #thumbnail-id-" + id).click();
                }
              });
              return false;
            });
          }
        });
        return;
      }
      this.selected = this.thumbnails.filter(".selected");
      if (this.selected.length === 0) {
        this.selected = null;
      }
      animated = this.animated;
      if (!this.animated) {
        this.thumbnailsNotAnimated();
      }
      if (this.animated) {
        this.thumbnailsAnimated();
      }
      if (window.location.hash !== "") {
        selectedId = window.location.hash.substring(1);
        this.section.find("#thumbnail-id-" + selectedId).click();
      }
    }

    Thumbnails.prototype.fadeOut = function(t) {
      t.jQdescription.removeClass("fadeInLeft");
      return t.jQdescription.addClass("fadeOutRight");
    };

    Thumbnails.prototype.fadeIn = function(t) {
      t.jQdescription.addClass("fadeInLeft");
      return t.jQdescription.removeClass("fadeOutRight");
    };

    Thumbnails.prototype.selectThumbnail = function(t) {
      t.jQthumbnail.addClass("selected");
      t.jQtitle.addClass("selected");
      if (!this.animated) {
        return t.jQdescription.addClass("selected");
      }
    };

    Thumbnails.prototype.deselectThumbnail = function(t) {
      t.jQthumbnail.removeClass("selected");
      t.jQtitle.removeClass("selected");
      if (!this.animated) {
        return t.jQdescription.removeClass("selected");
      }
    };

    Thumbnails.prototype.thumbnailsAnimated = function() {
      var that;
      that = this;
      return this.thumbnails.each(function() {
        var t;
        t = this;
        return t.jQthumbnail.click(function() {
          var wasSelected;
          if (that.selected) {
            if (t === that.selected) {
              that.deselectThumbnail(t);
              that.selected = null;
              that.clearLine();
              that.fadeOut(t);
              t.jQdescription.one(animate.onAnimatedEnd, function() {
                if (that.selected !== t) {
                  return t.jQdescription.removeClass("selected");
                }
              });
            } else {
              that.clearLine();
              that.deselectThumbnail(that.selected);
              that.selectThumbnail(t);
              wasSelected = that.selected;
              that.selected = t;
              if (wasSelected.jQdescription.hasClass("fadeInLeft")) {
                that.fadeOut(wasSelected);
                wasSelected.jQdescription.one(animate.onAnimatedEnd, function() {
                  if (that.selected !== wasSelected) {
                    wasSelected.jQdescription.removeClass("selected");
                    if (that.selected && that.selected.jQdescription.hasClass("fadeOutRight")) {
                      wasSelected = that.selected;
                      that.selected.jQdescription.addClass("selected");
                      that.fadeIn(that.selected);
                      return wasSelected.jQdescription.one(animate.onAnimatedEnd, function() {
                        if (that.selected === wasSelected && that.selected && that.selected.jQdescription.hasClass("fadeInLeft")) {
                          return that.drawLine();
                        }
                      });
                    }
                  }
                });
              } else {
                t.jQdescription.addClass("selected");
                that.fadeIn(t);
                that.selected = t;
                t.jQdescription.one(animate.onAnimatedEnd, function() {
                  if (that.selected === t) {
                    that.selected.jQdescription.addClass("selected");
                    return that.drawLine();
                  }
                });
              }
            }
          } else {
            that.clearLine();
            that.selectThumbnail(t);
            that.selected = t;
            if (that.section.find("item.description.selected").length === 0) {
              t.jQdescription.addClass("selected");
              that.fadeIn(t);
              t.jQdescription.one(animate.onAnimatedEnd, function() {
                if (that.selected === t && that.selected.jQdescription.hasClass("fadeInLeft")) {
                  that.selected.jQdescription.addClass("selected");
                  return that.drawLine();
                }
              });
            } else {
              that.section.find("item.description.selected").one(animate.onAnimatedEnd, function() {
                if (that.selected === t) {
                  that.fadeIn(t);
                  that.selected.jQdescription.addClass("selected");
                  return that.selected.jQdescription.one(animate.onAnimatedEnd, function() {
                    if (that.selected === t && that.selected.jQdescription.hasClass("fadeInLeft")) {
                      return that.drawLine();
                    }
                  });
                }
              });
            }
          }
          return false;
        });
      });
    };

    Thumbnails.prototype.thumbnailsNotAnimated = function() {
      var that;
      that = this;
      return this.thumbnails.each(function() {
        var t;
        t = this;
        return t.jQthumbnail.click(function() {
          if (that.selected) {
            if (t === that.selected) {
              that.deselectThumbnail(t);
              that.selected = null;
              return that.clearLine();
            } else {
              that.clearLine();
              that.deselectThumbnail(that.selected);
              that.selectThumbnail(t);
              that.selected = t;
              return that.drawLine();
            }
          } else {
            that.selectThumbnail(t);
            that.selected = t;
            return that.drawLine();
          }
        });
      });
    };

    Thumbnails.prototype.checkBckgImg = function() {
      return this.thumbnails.each(function() {
        var thumbnail, thumbnailBckgImg, thumbnailUrl;
        thumbnail = $(this);
        thumbnailBckgImg = thumbnail.css("background-image");
        thumbnailUrl = thumbnailBckgImg.substring(4, thumbnailBckgImg.length - 1);
        if (thumbnailUrl.charAt(0) === '"' || thumbnailUrl.charAt(0) === "'") {
          thumbnailUrl = thumbnailUrl.slice(1, -1);
        }
        return $('<img/>').attr('src', thumbnailUrl).load(function() {
          return $(this).remove();
        }).error(function() {
          $(this).remove();
          thumbnail.css("background-image", "");
          return thumbnail.addClass("logo");
        });
      });
    };

    Thumbnails.prototype.setThumbnailSize = function() {
      var fullSize, height;
      this.wraps.each(function() {
        var wrap;
        wrap = $(this);
        return wrap.height(wrap.width());
      });
      fullSize = this.wraps.first().width();
      this.thumbnails.each(function() {
        var borderWidth;
        borderWidth = fullSize * config.thumbnails.borderSize;
        if (borderWidth < 1) {
          borderWidth = 1;
        }
        this.jQthumbnail.css({
          "border-width": borderWidth
        });
        return this.jQthumbnail.css({
          "opacity": 1
        });
      });
      height = this.wraps.first().height();
      return this.shortBios.each(function() {
        return $(this).height(height);
      });
    };

    Thumbnails.prototype.clearLine = function() {
      if (!this.svg) {
        return;
      }
      return this.svg.find("path").remove();
    };

    Thumbnails.prototype.drawLine = function() {
      var endX, endY, line, originalEndY, startX, startY, thumbnail, title;
      if (!this.svg) {
        return;
      }
      thumbnail = this.selected;
      title = thumbnail.jQdescription.find(".thumbnail-title");
      thumbnail = thumbnail.jQthumbnail;
      startY = thumbnail.offset().top - this.section.offset().top + thumbnail.outerHeight();
      startX = thumbnail.offset().left + thumbnail.width() / 2;
      if (thumbnail.hasClass("column-first") && title.offset().left <= startX) {
        return;
      }
      if (thumbnail.hasClass("column-last") && title.offset().left >= startX) {
        return;
      }
      endY = title.offset().top + title.outerHeight() - this.section.offset().top;
      originalEndY = endY;
      if (thumbnail.hasClass("column-first")) {
        endX = title.offset().left + title.width();
      } else if (thumbnail.hasClass("column-last")) {
        endX = title.offset().left;
      } else {
        endY = endY - title.outerHeight();
      }
      if (thumbnail.hasClass("column-first") || thumbnail.hasClass("column-last") || thumbnail.hasClass("column-middle")) {
        line = this.paper.path("M" + startX + " " + startY + "L " + startX + " " + endY + " L " + endX + " " + endY);
      }
      if (!thumbnail.hasClass("column-first") && !thumbnail.hasClass("column-last")) {
        return this.paper.path("M " + title.offset().left + " " + originalEndY + "L " + (title.offset().left + title.width()) + " " + originalEndY);
      }
    };

    return Thumbnails;

  })();

  root.Thumbnails = Thumbnails;

}).call(this);

(function() {
  var defaultOptions, mobileOptions;

  defaultOptions = {
    scaleColor: false,
    trackColor: 'rgba(255,255,255,0.3)',
    barColor: '#E7F7F5',
    lineWidth: 8,
    lineCap: 'butt',
    size: 105,
    animate: {
      duration: 1000,
      enabled: true
    }
  };

  mobileOptions = {
    lineWidth: 4,
    size: 50
  };

  $(function() {
    var getScale, update;
    getScale = function(clock) {
      if (clock.hasClass("days")) {
        return 31;
      }
      if (clock.hasClass("hours")) {
        return 24;
      }
      return 60;
    };
    update = function(clocks) {
      var clock, percents, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = clocks.length; _i < _len; _i++) {
        clock = clocks[_i];
        percents = clock.find(".value").html() * 100 / getScale(clock);
        clock.data('easyPieChart').update(percents);
        _results.push(setTimeout(function() {}));
      }
      return _results;
    };
    return $("timer-dashboard").each(function() {
      var clocks, options, timer;
      timer = $(this);
      clocks = [];
      options = timer.parent().hasClass("mobile") ? $.extend({}, defaultOptions, mobileOptions) : defaultOptions;
      timer.find("clock").each(function() {
        return clocks.push($(this).easyPieChart(options));
      });
      return timer.countdown(timer.attr("count-to"), function(event) {
        if (event.strftime('%S') !== timer.find(".seconds").find(".value").html()) {
          timer.find(".days").find(".value").html(event.strftime('%D'));
          timer.find(".hours").find(".value").html(event.strftime('%H'));
          timer.find(".minutes").find(".value").html(event.strftime('%M'));
          timer.find(".seconds").find(".value").html(event.strftime('%S'));
          return update(clocks);
        }
      });
    });
  });

}).call(this);
