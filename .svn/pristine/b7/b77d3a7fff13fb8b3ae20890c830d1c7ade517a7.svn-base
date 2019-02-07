

/**
 * @author dante
 * @version $
 */
;
(function($) {
	$.fn.pagination = function(options) {
		options = $.extend( {
			page : 1,
			total : 0,
			pagesize : 15,
			transfer : null
		}, options);

		if (options.page == null || options.page == "")
			options.page = 1;

		var pages = Math.ceil(options.total / options.pagesize);
		if (pages < 1)
			pages = 1;

		var block = Math.ceil(options.page / 10);
		var start = block * 10 - 9;
		var end = block * 10;

		if (end > pages)
			end = pages;

		var $div = $("<div></div>");

		$("<img />").addClass("button").attr("title", "처음").attr("src", $.getUriWithContextPath("/images/skin/prv01_btn.gif")).appendTo($div).wrap(
				$("<a href='#' class='pagination'></a>").attr("page", "1"));
		$("<img />").addClass("button").attr("title", "이전 블럭").attr("src", $.getUriWithContextPath("/images/skin/prv02_btn.gif")).css( {
			"margin" : "0 5px"
		}).appendTo($div).wrap($("<a href='#' class='pagination'></a>").attr("page", (prevBlock = (start > 1) ? start - 1 : start)));

		for ( var i = start; i <= end; i++) {
			var $item = $("<span style='padding: 0 5px;'>" + i + "</span>").appendTo($div);

			$item.wrap($("<a href='#' class='pagination'></a>").attr("page", i).attr("title", i));
			if (options.page == i)
				$item.css( {
					"color" : "#1A599C",
					"font-weight" : "bold"
				});
		}

		$("<img />").addClass("button").attr("title", "다음 블럭").attr("src", $.getUriWithContextPath("/images/skin/next02_btn.gif")).css( {
			"margin" : "0 5px"
		}).appendTo($div).wrap($("<a href='#' class='pagination'></a>").attr("page", ((end < pages) ? end + 1 : end)));
		$("<img />").addClass("button").attr("title", "마지막").attr("src", $.getUriWithContextPath("/images/skin/next01_btn.gif")).appendTo($div).wrap(
				$("<a href='#' class='pagination'></a>").attr("page", pages));

		$div.find("a.pagination").unbind("click").bind("click", function() {
			if (options.transfer != null && jQuery.isFunction(options.transfer))
				options.transfer($(this).attr("page"));
			return false;
		}).end().appendTo(this.empty());
	};
})(jQuery);

;
(function($) {
	$.fn.codedriver = function(options) {
		options = jQuery.extend( {
			root : "",
			selectedValue : "",
			autoDraw : true,
			isClear : true,
			hasEmpty : false,
			emptyString : {
				key : "",
				value : "전체"
			},
			onComplete : null
		}, options);

		var $this = this;
		$.ajax( {
			url : $.getUriWithContextPath("/common/codedriver.json"),
			type : "POST",
			dataType : "json",
			data : {
				"root" : options.root
			},
			success : function(json) {
				if ($this.size() < 1)
					return false;
				if (options.isClear)
					$this.empty();
				if (options.autoDraw) {
					if (options.hasEmpty) {
						var $emptyoption = document.createElement("option");
						$($this).get(0).appendChild($emptyoption);
						$emptyoption.text = options.emptyString.value;
						$emptyoption.value = options.emptyString.key;
					}

					$(json).each(function() {
						var $option = document.createElement("option");
						$($this).get(0).appendChild($option);
						$option.text = this.coDetNm;
						$option.value = this.coDetId;

						if (options.selectedValue != "" && options.selectedValue == this.coDetId)
							$option.selected = "selected";
					});
				}

				if ($.isFunction(options.onComplete))
					options.onComplete(json);
			}
		});
	};
})(jQuery);

;
(function($) {
	$.fn.commonDatepicker = function(options) {
		options = jQuery.extend( {
			showOn : "button",
			buttonImage : $.getUriWithContextPath("/images/skin/icon_calendar.gif"),
			buttonImageOnly : true
		}, options);

		$.datepicker.setDefaults(options);

		$(this).datepicker();

		$("img.ui-datepicker-trigger").css( {
			"padding-left" : "2px",
			"cursor" : "pointer"
		}).attr("align", "absmiddle");
	};
})(jQuery);

jQuery(function($) {
	$.extend( {
		toIntegersAtLease : function(n) {
			return n < 10 ? '0' + n : n.toString();
		},
		getFirstday : function() {
			var today = new Date();
			var date = [];
			date.push(today.getFullYear());
			date.push($.toIntegersAtLease(today.getMonth() + 1));
			date.push('01');
			return date.join("-");
		},
		getToday : function() {
			var today = new Date();
			var date = [];
			date.push(today.getFullYear());
			date.push($.toIntegersAtLease(today.getMonth() + 1));
			date.push($.toIntegersAtLease(today.getDate()));
			return date.join("-");
		},
		getYesterday : function() {
			var dateString = $.getToday();
			var dateArray = dateString.split("-");
			var today = new Date(dateArray[0], dateArray[1] - 1, dateArray[2] - 1);
			var date = [];
			date.push(today.getFullYear());
			date.push($.toIntegersAtLease(today.getMonth() + 1));
			date.push($.toIntegersAtLease(today.getDate()));
			return date.join("-");
		},
		getDate : function(date) {
			if (date == null || date == "" || !(/^\d{4}[\/-]\d{1,2}[\/-]\d{1,2}$/.test(date)))
				return null;
			var iDate = date.split("-");
			return new Date(iDate[0], iDate[1] - 1, iDate[2]);
		},
		getIndicator : function() {
			return $("<img />").attr("src", function() {
				return $.getUriWithContextPath("/js/jquery/ui/style/images/ajax-loader.gif");
			}).css( {
				"width" : "32px",
				"height" : "32px"
			});
		},
		getCCTVUrl : function(ip) {
			return "http://" + ip + "/app/live/sim/single.asp";
		}
	});

	if ($("input.firstday").val() == "")
		$("input.firstday").val($.getFirstday());
	if ($("input.today").val() == "")
		$("input.today").val($.getToday());
	if ($("input.yesterday").val() == "")
		$("input.yesterday").val($.getYesterday());

	$(window).ajaxError(function(event, XMLHttpRequest, ajaxOptions, thrownError) {
		if (XMLHttpRequest.status == "500") {
			alert("요청을 처리중 오류가 발생했습니다.\n관리자에게 문의하십시오.")
		} else if (XMLHttpRequest.status == "404") {
			alert("페이지를 찾을 수 없습니다.\n관리자에게 문의하십시오.")
		} else {
			// alert("Error code : " + XMLHttpRequest.status + "\n" +
			// XMLHttpRequest.statusText);
			if (XMLHttpRequest.responseText != "") {
				if (XMLHttpRequest.responseText.indexOf("{") == 0) {
					if (typeof XMLHttpRequest.responseText.status != "undefined") {
						alert(XMLHttpRequest.responseText.status);
					} else {
						alert("알수없는 오류가 발생했습니다.\n관리자에게 문의하십시오.");
					}
				} else {
					if (XMLHttpRequest.responseText.indexOf(".jpg") > 0) {
						if ($.browser.msie && XMLHttpRequest.responseText.indexOf("applet") > 0) {
							alert("오류가 발생했습니다.\n관리자에게 문의하십시오.");
						} else {
							$("#container").hide().html(XMLHttpRequest.responseText).show();
						}
					} else {
						$("body").append(XMLHttpRequest.responseText);
					}
				}
			} else {
				alert("알수없는 오류가 발생했습니다.\n관리자에게 문의하십시오.");
			}
		}

	});

});