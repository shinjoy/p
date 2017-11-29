/*!
 * jQuery Modal (minified)
 * Copyright (c) 2015 CreativeDream
 * Website http://creativedream.net/plugins
 * Version: 1.2.3 (10-04-2015)
 * Requires: jQuery v1.7.1 or later
 */
function modal(t) {
    return $.cModal(t)
}! function(t) {
    t.cModal = function(n) {
        var e, o = {
                type: "default",
                title: null,
                text: null,
                size: "normal",
                buttons: [{
                    text: "OK",
                    val: !0,
                    onClick: function() {
                        return !0
                    }
                }],
                center: !0,
                autoclose: !1,
                callback: null,
                onShow: null,
                animate: !0,
                closeClick: !0,
                closable: !0,
                theme: "default",
                background: null,
                zIndex: 1050,
                buttonText: {
                    ok: "OK",
                    yes: "Yes",
                    cancel: "Cancel"
                },
                template: '<div class="modal-box"><div class="modal-inner"><div class="modal-title"><a class="modal-close-btn"></a></div><div class="modal-text"></div><div class="modal-buttons"></div></div></div>',
                _classes: {
                    box: ".modal-box",
                    boxInner: ".modal-inner",
                    title: ".modal-title",
                    content: ".modal-text",
                    buttons: ".modal-buttons",
                    closebtn: ".modal-close-btn"
                }
            },
            n = t.extend({}, o, n),
            a = t("<div id='modal-window' />").hide(),
            l = n._classes.box,
            s = a.append(n.template),
            i = {
                init: function() {
                    t("#modal-window").remove(), i._setStyle(), i._modalShow(), i._modalConent(), a.on("click", "a.modal-btn", function() {
                        i._modalBtn(t(this))
                    }).on("click", n._classes.closebtn, function() {
                        e = !1, i._modalHide()
                    }).click(function(t) {
                        n.closeClick && "modal-window" == t.target.id && (e = !1, i._modalHide())
                    }), t(window).bind("keyup", i._keyUpF).resize(function() {
                        var t = n.animate;
                        n.animate = !1, i._position(), n.animate = t
                    })
                },
                _setStyle: function() {
                    a.css({
                        position: "fixed",
                        width: "100%",
                        height: "100%",
                        top: "0",
                        left: "0",
                        "z-index": n.zIndex,
                        overflow: "auto"
                    }), a.find(n._classes.box).css({
                        position: "absolute"
                    })
                },
                _keyUpF: function(t) {
                    switch (t.keyCode) {
                        case 13:
                            if (s.find("input:not(.modal-prompt-input),textarea").is(":focus")) return !1;
                            i._modalBtn(a.find(n._classes.buttons + " a.modal-btn" + ("undefined" != typeof i.btnForEKey && a.find(n._classes.buttons + " a.modal-btn:eq(" + i.btnForEKey + ")").size() > 0 ? ":eq(" + i.btnForEKey + ")" : ":last-child")));
                            break;
                        case 27:
                            i._modalHide()
                    }
                },
                _modalShow: function() {
                    t("body").css({
                        overflow: "hidden",
                        width: t("body").innerWidth()
                    }).append(s)
                },
                _modalHide: function(o) {
                    if (n.closable === !1) return !1;
                    e = "undefined" == typeof e ? !1 : e;
                    var s = function() {
                        if (null != n.callback && "function" == typeof n.callback && 0 == n.callback(e, a, i.actions) ? !1 : !0) {
                            a.fadeOut(200, function() {
                                t(this).remove(), t("body").css({
                                    overflow: "",
                                    width: ""
                                })
                            });
                            var o = 100 * parseFloat(t(l).css("top")) / parseFloat(t(l).parent().css("height"));
                            t(l).stop(!0, !0).animate({
                                top: o + (n.animate ? 3 : 0) + "%"
                            }, "fast")
                        }
                    };
                    o ? setTimeout(function() {
                        s()
                    }, o) : s(), t(window).unbind("keyup", i._keyUpF)
                },
                _modalConent: function() {
                    var e = n._classes.title,
                        o = n._classes.content,
                        s = n._classes.buttons,
                        d = n.buttonText,
                        c = ["alert", "confirm", "prompt","customer"],
                        u = ["xenon", "atlant", "reseted"];
                    if (-1 == t.inArray(n.type, c) && "default" != n.type && t(l).addClass("modal-type-" + n.type), t(l).addClass(n.size && null != n.size ? "modal-size-" + n.size : "modal-size-normal"), n.theme && null != n.theme && "default" != n.theme && t(l).addClass((-1 == t.inArray(n.theme, u) ? "" : "modal-theme-") + n.theme), n.background && null != n.background && a.css("background-color", n.background), n.title || null != n.title ? t(e).prepend("<h3>" + n.title + "</h3>") : t(e).remove(), "prompt" == n.type ? n.text = (null != n.text ? n.text : "") + '<input type="text" name="modal-prompt-input" class="modal-prompt-input" autocomplete="off" autofocus="on" />' : "", t(o).html(n.text), n.buttons || null != n.buttons) {
                        var r = "";
                        switch (n.type) {
                            case "alert":
                                r = '<a class="modal-btn' + (n.buttons[0].addClass ? " " + n.buttons[0].addClass : "") + '">' + d.ok + "</a>";
                                break;
                            case "confirm":
                                r = '<a class="modal-btn' + (n.buttons[0].addClass ? " " + n.buttons[0].addClass : "") + '">' + d.cancel + '</a><a class="modal-btn ' + (n.buttons[1] && n.buttons[1].addClass ? " " + n.buttons[1].addClass : "btn-light-blue") + '">' + d.yes + "</a>";
                                break;
                            case "prompt":
                                r = '<a class="modal-btn' + (n.buttons[0].addClass ? " " + n.buttons[0].addClass : "") + '">' + d.cancel + '</a><a class="modal-btn ' + (n.buttons[1] && n.buttons[1].addClass ? " " + n.buttons[1].addClass : "btn-light-blue") + '">' + d.ok + "</a>";
                                break;
							case "customer":
								r = '';
								break;	
                            default:
                                n.buttons.length > 0 && t.isArray(n.buttons) ? t.each(n.buttons, function(t, n) {
                                    var e = n.addClass && "undefined" != typeof n.addClass ? " " + n.addClass : "";
                                    r += '<a class="modal-btn' + e + '">' + n.text + "</a>", n.eKey && (i.btnForEKey = t)
                                }) : r += '<a class="modal-btn">' + d.ok + "</a>"
                        }
                        t(s).html(r)
                        
                        if(n.type == "customer") $(".modal-buttons").hide();
                    } else t(s).remove();
                    if ("prompt" == n.type && $(".modal-prompt-input").focus(), n.autoclose) {
                        var m = n.buttons || null != n.buttons ? 32 * t(o).text().length : 900;
                        i._modalHide(900 > m ? 900 : m)
                    }
                    a.fadeIn(200, function() {
                        null != n.onShow ? n.onShow(i.actions) : null
                    }), i._position()
                },
                _position: function() {
                    var e, o, a;
                    n.center ? (e = {
                        top: t(window).height() < t(l).outerHeight() ? 1 : 50,
                        left: 50,
                        marginTop: t(window).height() < t(l).outerHeight() ? 0 : -t(l).outerHeight() / 2,
                        marginLeft: -t(l).outerWidth() / 2
                    }, o = {
                        top: e.top - (n.animate ? 3 : 0) + "%",
                        left: e.left + "%",
                        "margin-top": e.marginTop,
                        "margin-left": e.marginLeft
                    }, a = {
                        top: e.top + "%"
                    }) : (e = {
                        top: t(window).height() < t(l).outerHeight() ? 1 : 10,
                        left: 50,
                        marginTop: 0,
                        marginLeft: -t(l).outerWidth() / 2
                    }, o = {
                        top: e.top - (n.animate ? 3 : 0) + "%",
                        left: e.left + "%",
                        "margin-top": e.marginTop,
                        "margin-left": e.marginLeft
                    }, a = {
                        top: e.top + "%"
                    }), t(l).css(o).stop(!0, !0).animate(a, "fast")
                },
                _modalBtn: function(o) {
                    var l = !1,
                        s = n.type,
                        d = o.index(),
                        c = n.buttons[d];
                    if (t.inArray(s, ["alert", "confirm", "prompt"]) > -1) e = l = 1 == d ? !0 : !1, "prompt" == s && (e = l = l && a.find("input.modal-prompt-input").size() > 0 != 0 ? a.find("input.modal-prompt-input").val() : !1), i._modalHide();
                    else {
                        if (o.hasClass("btn-disabled")) return !1;
                        e = l = c && c.val ? c.val : !0, (!c.onClick || c.onClick(t.extend({
                            val: l,
                            bObj: o,
                            bOpts: c
                        }, i.actions))) && i._modalHide()
                    }
                    e = l
                },
                actions: {
                    html: a,
                    close: function() {
                        i._modalHide()
                    },
                    getModal: function() {
                        return a
                    },
                    getBox: function() {
                        return a.find(n._classes.box)
                    },
                    getInner: function() {
                        return a.find(n._classes.boxInner)
                    },
                    getTitle: function() {
                        return a.find(n._classes.title)
                    },
                    getContet: function() {
                        return a.find(n._classes.content)
                    },
                    getButtons: function() {
                        return a.find(n._classes.buttons).find("a")
                    },
                    setTitle: function(t) {
                        return a.find(n._classes.title + " h3").html(t), a.find(n._classes.title + " h3").size() > 0
                    },
                    setContent: function(t) {
                        return a.find(n._classes.content).html(t), a.find(n._classes.content).size() > 0
                    }
                }
            };
        return i.init(), i.actions
    }
}(jQuery);