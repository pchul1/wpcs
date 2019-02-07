// gis1 view
function Gis1View() {
	var sm;
	var tb;
	
	var gsvc;
	var gsvcURL = "http://118.37.180.151:5005/rest/services/Utilities/Geometry/GeometryServer";
	var tgl;
						
	// view init
	this.init = function() {
		etcInit();
		mapControlInit();
		mapSelectInit();
		topSliderInit();
		popupInit();
		drawSearchPanel();
	};
	
	// etc init : top logo, download btn, compare slider
	function etcInit() {
		$("#topLogo").bind("click", function() {
			location.href = nu;
		});
		
		$("#downloadMap1").bind("click", function() {
			location.href = '/ce/jsp/download.jsp?filename=' + url + '/download/gis_manual.hwp';
		});
		
		$("#downloadMap2").bind("click", function() {
			var newWin = window.open("about:blank");
			newWin.location.href = "http://www.me.go.kr/web/64/me/c3/me_sub3.do";
		});
		
		if (mtype == '07' || mtype == '11') {
			$("#compareSlider").bind("click", function(){
				var status = $(this).attr("status");
				var img = $(this).css("background-image");
				
				if (status == "hide") {
					$(this).attr("status", "show");
					$(this).css("background-image", img.replace("hide", "show"));
					
					slide('compareToolbar', 'left', '-250px');
				}
				else {
					$(this).attr("status", "hide");
					$(this).css("background-image", img.replace("show", "hide"));
					
					slide('compareToolbar', 'left', '0px');
				}
			});
		}
	};
	
	// map control btn init
	function mapControlInit() {
		var id = "mapControl";
		
		var $object = $("#" + id + " div[id*='" + id + "']");
		
		$object.each(function() {
			var $that = $(this);
			var className =$that.attr("id"); 
			
			$that.button({
				text: false,
				icons: {
					primary: className + "out"
				}
			}).click(function() {
				// out -> over
				var list = "이동|확대|축소|정보|측정";
				
				if($that.attr("status") == "out" && list.indexOf($that.attr("title")) > -1) {
					$object.each(function() {
						var id = $(this).attr("id");
						$(this).button("option", "icons", {primary: id + "out"});	
						$(this).attr("status", "out");
					}) ;
					
					$that.button("option", "icons", {primary: className + "over"});
					$that.attr("status", "over");
				} else if($that.attr("status") == "out" && list.indexOf($that.attr("title")) == -1) {
					$("#mapControl2").trigger("click");
				}
			});
		});
		
		$("#mapControl2").trigger("click");
	};
	
	// map select btn init
	function mapSelectInit() {
		$("#mapSelectBtn").buttonset();
	};
	
	// top slider init 
	function topSliderInit() {
		var id = "topSliderBtn";
		var $btn = $("#" + id);
		var $top = $("#top");
		
		$btn.bind("click", function() {
			var status = $(this).attr("status");
			var img = $(this).css("background-image");
			
			if(status == "hide") {
				$(this).attr("status", "show");
				$(this).css("background-image", img.replace("hide", "show"));
				
				slide('top', 'top', '-90px');
			} else {
				$(this).attr("status", "hide");
				$(this).css("background-image", img.replace("show", "hide"));
				
				slide('top', 'top', '0px');
			}
		});
	};

	// popup init : layer
	function popupInit() {
		var list = new Hash();
		
		if (mtype == '07' || mtype == '11') {
			// layer
			list.setItem('layerBox', {
				id: 'layerBox',
				width: 300,
				height: 250,
				title: '<img src="/ce/resources/images/common/popup_title_layer.png" />',
				close: false,
				position:  [72, 110],
				autoOpen: false,
				resizable: false,
				display: true
			});
			
			// timeLayer
			list.setItem('timeLayer', {
				id: 'timeLayer',
				width: 300,
				height: 120,
				title: '<img src="/ce/resources/images/common/popup_title_timeLayer.png" />',
				close: false,
				position:[124, 110],
				autoOpen: false,
				resizable: false,
				display: true
			});
			
			// compare
			list.setItem('compare', {
				id: 'compare',
				width: 400,
				height: 400,
				title: '<img src="/ce/resources/images/common/popup_title_compare.png" />',
				close: false,
				position: [176, 110],
				autoOpen: false,
				resizable: true,
				display: true
			});
		} else {
			$("#layerBox").css("display", "none");
			$("#timeLayer").css("display", "none");
			$("#compare").css("display", "none");
			
			$("#layerBoxNone").css("display", "none");
			$("#timeLayerNone").css("display", "none");
			$("#compareNone").css("display", "none");
		}
		
		// search
		list.setItem('searchBox', {
			id: 'searchBox',
			width: 310,
			height: 520,
			title: '<img src="/ce/resources/images/common/popup_title_search.png" />',
			close: false,
			position: [20, 110],
			autoOpen: false,
			resizable: true,
			display: true
		});
		
		for(var key in list.items) {
			var config = list.getItem(key);
			var box = 	dialogCustom(config);
		}
	};
	
	// search: draw search panel
	function drawSearchPanel() {
		// panel
		var $panel = $("#searchContent");
		
		$panel.accordion({
			heightStyle: "fill",
			animate: false,
			create: function(event, ui) {
				var $headers = $("#searchContent").find('h3');
				
				$headers.one("click", function() {
					var $this = $(this).text();
					
					if($this == "지하수측정망(일반지역)") {
						drawSearchPanel2();
					}
					
					else if($this == "토양측정망") {
						drawSearchPanel3();
					}
					
					else if($this == "골프장") {
						drawSearchPanel4();
					}
					
//					else if($this == "가축매몰지") {
//						drawSearchPanel5();
//					}
//					
//					else if($this == "지하수관정") {
//						drawSearchPanel6();
//					}
//					
//					else if($this == "실태조사지점") {
//						drawSearchPanel7();
//					}
				});
			}
		});
		
		// dialog resize evt
		$("#searchBox").on( "dialogresize", function() {
			$panel.accordion("refresh");
		})
		
		// 지하수측정망(오염우려지역)
		drawSearchPanel1();
	};
	
	// search: draw search panel : 지하수측정망(오염우려지역)
	function drawSearchPanel1() {
		// 비음용 -> 용도구분 o
//		$("input:radio[name='search_gwmptchg_cdrink']").change(function() {
//			var cdrink = $("#search_gwmptchg_cdrink1").is(":checked");
//			
//			if (cdrink) {
//				$("#search_gwmptchg_yongdo").attr("disabled", false);
//			} else {
//				$("#search_gwmptchg_yongdo").attr("disabled", true);
//			}
//		});
		
		// 시도
		$("#search_gwmptchg_sido").bind("change", function() {
			var sido = $("#search_gwmptchg_sido option:selected").val();
			
			// 시도 검색 -> 주소 검색 x, 반경 검색 x
			if (sido != "none") {
				$("#search_gwmptchg_addr").attr("disabled", true);
				
				$("#search_gwmptchg_mapS").attr("disabled", true);
				$("#search_gwmptchg_mapRadius").attr("disabled", true);
				$("input[id*='search_gwmptchg_mapx']").attr("disabled", true);
				$("input[id*='search_gwmptchg_mapy']").attr("disabled", true);
			} else {
				$("#search_gwmptchg_addr").attr("disabled", false);
				
				$("#search_gwmptchg_mapS").attr("disabled", false);
				$("#search_gwmptchg_mapRadius").attr("disabled", false);
				$("input[id*='search_gwmptchg_mapx']").attr("disabled", false);
				$("input[id*='search_gwmptchg_mapy']").attr("disabled", false);
			}
		});

		// 지점주소 -> 주소 검색 x, 반경 검색 x
		$("#search_gwmptchg_addr").bind("keydown", function() {
			var sido = $("#search_gwmptchg_addr").val();
			
			if(sido != "") {
				$("#search_gwmptchg_sido").attr("disabled", true);
				$("#search_gwmptchg_gu").attr("disabled", true);
				
				$("#search_gwmptchg_mapS").attr("disabled", true);
				$("#search_gwmptchg_mapRadius").attr("disabled", true);
				$("input[id*='search_gwmptchg_mapx']").attr("disabled", true);
				$("input[id*='search_gwmptchg_mapy']").attr("disabled", true);
			} else {
				$("#search_gwmptchg_sido").attr("disabled", false);
				$("#search_gwmptchg_gu").attr("disabled", false);
				
				$("#search_gwmptchg_mapS").attr("disabled", false);
				$("#search_gwmptchg_mapRadius").attr("disabled", false);
				$("input[id*='search_gwmptchg_mapx']").attr("disabled", false);
				$("input[id*='search_gwmptchg_mapy']").attr("disabled", false);
			}
		});
		
		// 좌표, 반경거리 -> 시도, 시군구, 주소 검색 x, 반경검색(직접입력)
		$("input[id*='search_gwmptchg_mapx'], input[id*='search_gwmptchg_mapy'], #search_gwmptchg_mapRadius").bind("keydown", function() {
			var x1 = $("#search_gwmptchg_mapx1").val();
			var x2 = $("#search_gwmptchg_mapx2").val();
			var x3 = $("#search_gwmptchg_mapx3").val();
			
			var y1 = $("#search_gwmptchg_mapy1").val();
			var y2 = $("#search_gwmptchg_mapy2").val();
			var y3 = $("#search_gwmptchg_mapy3").val();
			
			var r = $("#search_gwmptchg_mapRadius").val();
			
			if(x1 != "" || x2 != "" || x3 != "" || y1 != "" || y2 != "" || y3 != "" || r != "") {
				$("#search_gwmptchg_sido").attr("disabled", true);
				$("#search_gwmptchg_gu").attr("disabled", true);
				$("#search_gwmptchg_addr").attr("disabled", true);
				
				$("#search_gwmptchg_mapS").val("hand");
			} else {
				$("#search_gwmptchg_sido").attr("disabled", false);
				$("#search_gwmptchg_gu").attr("disabled", false);
				$("#search_gwmptchg_addr").attr("disabled", false);
				
				$("#search_gwmptchg_mapS").val("none");
			}
		});
		
		// 반경검색 지도에서 선택 -> 시도, 시군구, 주소검색 x, 반경거리, 좌표 x
		$("#search_gwmptchg_mapS").bind("change", function() {
			var ms = $("#search_gwmptchg_mapS option:selected").val();
			
			if(ms == 'direct') {
				$("#search_gwmptchg_sido").attr("disabled", true);
				$("#search_gwmptchg_gu").attr("disabled", true);
				$("#search_gwmptchg_addr").attr("disabled", true);
				
				$("#search_gwmptchg_mapRadius").attr("disabled", true);
				$("input[id*='search_gwmptchg_mapx']").attr("disabled", true);
				$("input[id*='search_gwmptchg_mapy']").attr("disabled", true);
			} else if(ms == 'hand') {  
				$("#search_gwmptchg_sido").attr("disabled", true);
				$("#search_gwmptchg_gu").attr("disabled", true);
				$("#search_gwmptchg_addr").attr("disabled", true);
				
				$("#search_gwmptchg_mapRadius").attr("disabled", false);
				$("input[id*='search_gwmptchg_mapx']").attr("disabled", false);
				$("input[id*='search_gwmptchg_mapy']").attr("disabled", false);
			} else {
				$("#search_gwmptchg_sido").attr("disabled", false);
				$("#search_gwmptchg_gu").attr("disabled", false);
				$("#search_gwmptchg_addr").attr("disabled", false);
				
				$("#search_gwmptchg_mapRadius").attr("disabled", true);
				$("input[id*='search_gwmptchg_mapx']").attr("disabled", true);
				$("input[id*='search_gwmptchg_mapy']").attr("disabled", true);
			}
		});
		
		// 조사년도
		drawSearchPanel1_gwmyr();
				
		// 조사항목
		drawSearchPanel1_iccode();
		
		// 환경청
		drawSearchPanel1_chgbn();
		
		// 용도구분
		drawSearchPanel1_yongdo();
		
		// 시도
		drawSearchPanel1_sido();
		
		// 시군구
		drawSearchPanel1_gu();
		
		// 반경선택
		drawSearchPanel1_map();
		
		// 검색하기
		drawSearchPanel1_search();
		
		// 초기화
		drawSearchPanel1_reset();
	};
	
	// search: draw search panel : 지하수측정망(오염우려지역) : 조사년도
	function drawSearchPanel1_gwmyr() {
		var gwmyr = new autoInput();
		
		gwmyr.init({
			id: 'search_gwmptchg_gwmyr',
			type: 'select',
			none: '연도',
			page: 'gis1',
			query: 21,
			column: 'YEAR',
			text: 'YEAR'
		});
		
		gwmyr.query();
	};
	
	// search: draw search panel : 지하수측정망(오염우려지역) : 조사항목
	function drawSearchPanel1_iccode() {
		var iccode = new autoInput();
		
		iccode.init({
			id: 'search_gwmptchg_iccode',
			type: 'select',
			none: '조사항목 선택',
			page: 'gis1',
			query: 25,
			column: 'CODE',
			text: 'NAME'
		});
		
		iccode.query();
	};
	
	// search: draw search panel : 지하수측정망(오염우려지역) : 용도구분
	function drawSearchPanel1_yongdo() {
		var yongdo = new autoInput();
		
		yongdo.init({
			id: 'search_gwmptchg_yongdo',
			type: 'select',
			none: '용도구분 선택',
			page: 'gis1',
			query: 2,
			column: 'CODE',
			text: 'NAME'
		});
		
		yongdo.query();
	};
	
	// search: draw search panel : 지하수측정망(오염우려지역) : 환경청
	function drawSearchPanel1_chgbn() {
		var chgbn = new autoInput();
		
		chgbn.init({
			id: 'search_gwmptchg_chgbn',
			type: 'select',
			none: '환경청 선택',
			page: 'gis1',
			query: 1,
			column: 'CODE',
			text: 'NAME'
		});
		
		chgbn.query();
	};
	
	// search: draw search panel : 지하수측정망(오염우려지역) : 시도
	function drawSearchPanel1_sido() {
		var sido = new autoInput();
		
		sido.init({
			id: 'search_gwmptchg_sido',
			type: 'select',
			none: '시도 선택',
			page: 'gis1',
			query: 3,
			column: 'CODE',
			text: 'NAME'
		});
		
		sido.query();
	};
	
	// search: draw search panel : 지하수측정망(오염우려지역) : 시군구
	function drawSearchPanel1_gu() {
		$("#search_gwmptchg_sido").bind("change", function() {
			var sidoVal = $("#search_gwmptchg_sido option:selected").val();
			
			if(sidoVal != "none") {
				var gu = new autoInput();
				
				gu.init({
					id: 'search_gwmptchg_gu',
					type: 'select',
					none: '시군구 선택',
					page: 'gis1',
					query: 4,
					column: 'CODE',
					text: 'NAME',
					cond: [
						{
							col: 'sido',
							val: sidoVal
						}
					]
				});
				
				gu.query();
			} else {
				$("#search_gwmptchg_gu").val("none");
				$("#search_gwmptchg_gu option[value!='none']").remove();
			}
		});
	};
	
	// search: draw search panel : 지하수측정망(오염우려지역) : 반경선택
	function drawSearchPanel1_map() {
		$("#search_gwmptchg_mapS").bind("change", function(e) {
			var $t = $(e.target);
			var sv = $t.find("option:selected").val();
			sm = gis1MapManager.getMap();
			
			// 지도에서 선택
			if(sv == "direct") {
				tb = new esri.toolbars.Draw(sm);
				tb.activate(esri.toolbars.Draw.LINE, {
					showTooltips: false
				});
				
				//dojo.connect(tb, "onDrawEnd", addGraphic);
				dojo.connect(tb, "onDrawEnd", function(geo) {
				    var obj = {
				        type: 'direct',
				        r: 'search_gwmptchg_mapRadius',
				        rh: 'search_gwmptchg_mapRadiusH',
				        x1: 'search_gwmptchg_mapx1',
				        x2: 'search_gwmptchg_mapx2',
				        x3: 'search_gwmptchg_mapx3',
				        y1: 'search_gwmptchg_mapy1',
				        y2: 'search_gwmptchg_mapy2',
				        y3: 'search_gwmptchg_mapy3',
				        x: 'search_gwmptchg_mapx',
				        y: 'search_gwmptchg_mapy'
				    };
				    
				    addGraphic(geo, obj);
			    });
			}
		});
	};
	
	// search: draw search panel : 지하수측정망(오염우려지역) : 검색하기
	function drawSearchPanel1_search() {
		$("#search_btn_search1").bind("click", function() {
			var $gwmyr = $("#search_gwmptchg_gwmyr");
			var $gwmod = $("#search_gwmptchg_gwmod");
			var $iccode = $("#search_gwmptchg_iccode");
			var $cdrink = $("input:radio[name='search_gwmptchg_cdrink']:checked");
			var $yongdo = $("#search_gwmptchg_yongdo");
			var $chgbn = $("#search_gwmptchg_chgbn");
			var $sido = $("#search_gwmptchg_sido");
			var $gu = $("#search_gwmptchg_gu");
			var $addr = $("#search_gwmptchg_addr");
			var $radius = $("#search_gwmptchg_mapRadiusH");
			var $x = $("#search_gwmptchg_mapx");
			var $y = $("#search_gwmptchg_mapy");
	
			// 연도 미선택 시
			if($gwmyr.val() == "none") {
				alert('연도를 선택하여 주시기 바랍니다');
				return;
			}
			
			// 반기 미선택 시
			if($gwmod.val() == "none") {
				alert('반기를 선택하여 주시기 바랍니다');
				return;
			}
			
			// 반경 - 직접 입력 검색 시
			if($("#search_gwmptchg_mapS option:selected").val() == 'hand') {
				sm = gis1MapManager.getMap();
				gsvc = new esri.tasks.GeometryService(gsvcURL);
				
				var pl = new esri.geometry.Polyline(sm.spatialReference);
				
				var r = parseFloat($("#search_gwmptchg_mapRadius").val());
				
		        var x1 = $("#search_gwmptchg_mapx1").val();
		        var x2 = $("#search_gwmptchg_mapx2").val();
		        var x3 = $("#search_gwmptchg_mapx3").val();
		        
		        var y1 = $("#search_gwmptchg_mapy1").val();
		        var y2 = $("#search_gwmptchg_mapy2").val();
		        var y3 = $("#search_gwmptchg_mapy3").val();
				
				var x = parseInt(x1) + (parseFloat(x2) / 60) + (parseFloat(x3) / 3600);
				var y = parseInt(y1) + (parseFloat(y2) / 60) + (parseFloat(y3) / 3600);
			
				// hidden x, y, r input
				$("#search_gwmptchg_mapx").val(x);
	        	$("#search_gwmptchg_mapy").val(y);
	        	$("#search_gwmptchg_mapRadiusH").val(r);

			    var pt1 = new esri.geometry.Point(x, y, new esri.SpatialReference({ wkid: 102100}));
			    
			    var r1 = r * 1000 / 111302.61697430261;
			    
				var pt2 = pt1.offset(r1, 0);
			    
				pl.addPath([pt1, pt2]);
				
				var obj = {
			        type: 'hand',
			        r: r,
			        x1: x1,
			        x2: x2,
			        x3: x3,
			        y1: y1,
			        y2: y2,
			        y3: y3,
			        x: 'search_gwmptchg_mapx',
			        y: 'search_gwmptchg_mapy'
			    };
			    
			    addGraphic(pl, obj);
			}
			
			var chgSearch = new autoInput();
			
			// 검색 결과 항목 지정
			var columnList = ['지점코드', '지점명', '용도', '음용여부', '환경청', '조사년도', '조사반기'];
			var columnWList = ['60px', '70px', '50px', '60px', '50px', '60px', '60px'];
			
			if($iccode.val() != "none") {
				columnList.push($iccode.find("option:selected").text());
				columnWList.push('100px');
				
				columnList.push('주소');
				columnWList.push('none');
			} else {
				columnList.push('주소');
				columnWList.push('none');
			}
			
			// 연도별 쿼리 선택
			var qn;
			
			if(parseInt($gwmyr.val()) <= 2009) qn = 5;
			else qn = 28;
			
			// 검색
			chgSearch.init({
				id: 'resultBox',
				type: 'markerTable',
				page: 'gis1',
				query: qn,
				column: columnList,
				columnW: columnWList,
				chart: 1,
				excel: 1,
				detail: true,
				detailID: 'resultDetailBox',
				detailColumn : ['지점코드', '지점명', '환경청', '조사년도', '조사반기', '음용여부', '용도', '주소', '수소이온농도(pH)', '총대장균군', '질산성질소(NO3-N)', '염소이온(Cl-)', '카드뮴(Cd)', '비소(As)', '시안(CN)', '수은(Hg)', '유기인', '페놀(Phenol)', '납(Pb)', '6가크롬(Cr+6)', '트리클로로에틸렌(TCE)', '테트라클로로에틸렌(PCE)', '1,1,1-TCE(1,1,1-TCE)', '벤젠(Benzene)', '톨루엔(Toluene)', '에틸벤젠(Ethyl Benzene)', '크실렌(Xylene)', '전기전도도(EC)'],
				cond: [
					{
						col: 'gwmyr',
						val: ($gwmyr.val() == "none") ? "" : $gwmyr.val()
					},
					{
						col: 'gwmod',
						val: ($gwmod.val() == "none") ? "" : $gwmod.val()
					},
					{
						col: 'cdrink',
						val: ($cdrink.val() == "A") ? "" : $cdrink.val()
					},
					{
						col: 'yongdo',
						val: ($yongdo.val() == "none" || $cdrink.val() != "01") ? "" : $yongdo.val()
					},
					{
						col: 'chgbn',
						val: ($chgbn.val() == "none") ? "" : $chgbn.val()
					},
					{
						col: 'sido',
						val: ($sido.val() == "none") ? "" : $sido.val()
					},
					{
						col: 'gu',
						val: ($gu.val() == "none") ? "" : $gu.val()
					},
					{
						col: 'addr',
						val: encodeURIComponent(encodeURIComponent($addr.val(), "UTF-8"))
					},
					{
						col: 'radius',
						val: ($radius.val() == "none") ? "" : $radius.val()
					},
					{
						col: 'x',
						val: ($x.val() == "none") ? "" : $x.val()
					},
					{
						col: 'y',
						val: ($y.val() == "none") ? "" : $y.val()
					}
				],
				mapManager: gis1MapManager,
				icon: {
					gubun: '1',
					year: $gwmyr.val(),
					cdrink: ($cdrink.val() == "A") ? "" : $cdrink.val(),
					yongdo: ($yongdo.val() == "none") ? "" : $yongdo.val(),
					jimok: "",
					iccode: ($iccode.val() == "none") ? "" : $iccode.val(),
					icname: ($iccode.val() == "none") ? "" : $iccode.find("option:selected").text()
				}
			});
			
			chgSearch.query();
		});
	};
	
	// search: draw search panel : 지하수측정망(오염우려지역) : 초기화
	function drawSearchPanel1_reset() {
		$("#search_btn_reset1").bind("click", function() {
			$("#search_gwmptchg_gwmyr").val("none");
			$("#search_gwmptchg_gwmod").val("none");
			$("input[name='search_gwmptchg_cdrink']").removeAttr("checked");
			$("input[name='search_gwmptchg_cdrink'][value='02']").prop('checked', true);
			$("#search_gwmptchg_yongdo").val("none");
			$("#search_gwmptchg_chgbn").val("none");
			$("#search_gwmptchg_sido").val("none");
			$("#search_gwmptchg_gu").val("none");
			$("#search_gwmptchg_addr").val("");
			
			$("#search_gwmptchg_mapS").val("none");
			$("#search_gwmptchg_mapRadius").val("");
			$("input[id*='search_gwmptchg_mapx']").val("");
			$("input[id*='search_gwmptchg_mapy']").val("");
			
			$("#search_gwmptchg_gu option[value!='none']").remove();
			
			$("#search_gwmptchg_gwmyr").attr("disabled", false);
			$("#search_gwmptchg_gwmod").attr("disabled", false);
			$("input[name='search_gwmptchg_cdrink']").attr("disabled", false);
			$("#search_gwmptchg_yongdo").attr("disabled", true);
			$("#search_gwmptchg_chgbn").attr("disabled", false);
			$("#search_gwmptchg_sido").attr("disabled", false);
			$("#search_gwmptchg_gu").attr("disabled", false);
			$("#search_gwmptchg_addr").attr("disabled", false);
			
			$("#search_gwmptchg_mapS").attr("disabled", false);
			$("#search_gwmptchg_mapRadius").attr("disabled", true);
			$("input[id*='search_gwmptchg_mapx']").attr("disabled", true);
			$("input[id*='search_gwmptchg_mapy']").attr("disabled", true);
			
			sm = gis1MapManager.getMap();
			
			if(sm.graphicsLayerIds.toString().indexOf('bufferSearch') > -1) {
				tgl.clear();
			}
		});
	};

	// search: draw search panel : 지하수측정망(일반지역)
	function drawSearchPanel2() {
		// 비음용 -> 용도구분 o
//		$("input:radio[name='search_gwmptsido_cdrink']").change(function() {
//			var cdrink = $("#search_gwmptsido_cdrink1").is(":checked");
//			
//			if (cdrink) {
//				$("#search_gwmptsido_yongdo").attr("disabled", false);
//			} else {
//				$("#search_gwmptsido_yongdo").attr("disabled", true);
//			}
//		});
		
		// 시도 검색 -> 주소 검색 x, 반경검색 x
		$("#search_gwmptsido_sido").bind("change", function() {
			var sido = $("#search_gwmptsido_sido option:selected").val();
			
			if (sido != "none") {
				$("#search_gwmptsido_addr").attr("disabled", true);
		
				$("#search_gwmptsido_mapS").attr("disabled", true);
				$("#search_gwmptsido_mapRadius").attr("disabled", true);
				$("input[id*='search_gwmptsido_mapx']").attr("disabled", true);
				$("input[id*='search_gwmptsido_mapy']").attr("disabled", true);
			} else {
				$("#search_gwmptsido_addr").attr("disabled", false);
		
				$("#search_gwmptsido_mapS").attr("disabled", false);
				$("#search_gwmptsido_mapRadius").attr("disabled", false);
				$("input[id*='search_gwmptsido_mapx']").attr("disabled", false);
				$("input[id*='search_gwmptsido_mapy']").attr("disabled", false);
			}
		});
		
		// 지점주소 -> 시도 검색 x, 반경검색 x
		$("#search_gwmptsido_addr").bind("keydown", function() {
			var sido = $("#search_gwmptsido_addr").val();
			
			if(sido != "") {
				$("#search_gwmptsido_sido").attr("disabled", true);
		
				$("#search_gwmptsido_mapS").attr("disabled", true);
				$("#search_gwmptsido_mapRadius").attr("disabled", true);
				$("input[id*='search_gwmptsido_mapx']").attr("disabled", true);
				$("input[id*='search_gwmptsido_mapy']").attr("disabled", true);
			} else {
				$("#search_gwmptsido_sido").attr("disabled", false);
		
				$("#search_gwmptsido_mapS").attr("disabled", false);
				$("#search_gwmptsido_mapRadius").attr("disabled", false);
				$("input[id*='search_gwmptsido_mapx']").attr("disabled", false);
				$("input[id*='search_gwmptsido_mapy']").attr("disabled", false);
			}
		});
		
		// 좌표, 반경거리 -> 시도, 주소 검색 x, 반경검색(직접입력)
		$("input[id*='search_gwmptsido_mapx'], input[id*='search_gwmptsido_mapy'], #search_gwmptsido_mapRadius").bind("keydown", function() {
			var x1 = $("#search_gwmptsido_mapx1").val();
			var x2 = $("#search_gwmptsido_mapx2").val();
			var x3 = $("#search_gwmptsido_mapx3").val();
			
			var y1 = $("#search_gwmptsido_mapy1").val();
			var y2 = $("#search_gwmptsido_mapy2").val();
			var y3 = $("#search_gwmptsido_mapy3").val();
			
			var r = $("#search_gwmptsido_mapRadius").val();
			
			if(x1 != "" || x2 != "" || x3 != "" || y1 != "" || y2 != "" || y3 != "" || r != "") {
				$("#search_gwmptsido_sido").attr("disabled", true);
				$("#search_gwmptsido_addr").attr("disabled", true);
				
				$("#search_gwmptsido_mapS").val("hand");
			} else {
				$("#search_gwmptsido_sido").attr("disabled", false);
				$("#search_gwmptsido_addr").attr("disabled", false);
				
				$("#search_gwmptsido_mapS").val("none");
			}
		});
		
		// 반경검색 지도에서 선택 -> 시도, 시군구, 주소검색 x, 반경거리, 좌표 x
		$("#search_gwmptsido_mapS").bind("change", function() {
			var ms = $("#search_gwmptsido_mapS option:selected").val();
			
			if(ms == 'direct') {
				$("#search_gwmptsido_sido").attr("disabled", true);
				$("#search_gwmptsido_addr").attr("disabled", true);
				
				$("#search_gwmptsido_mapRadius").attr("disabled", true);
				$("input[id*='search_gwmptsido_mapx']").attr("disabled", true);
				$("input[id*='search_gwmptsido_mapy']").attr("disabled", true);
			} else if(ms == 'hand') {  
				$("#search_gwmptsido_sido").attr("disabled", true);
				$("#search_gwmptsido_addr").attr("disabled", true);
				
				$("#search_gwmptsido_mapRadius").attr("disabled", false);
				$("input[id*='search_gwmptsido_mapx']").attr("disabled", false);
				$("input[id*='search_gwmptsido_mapy']").attr("disabled", false);
			} else {
				$("#search_gwmptsido_sido").attr("disabled", false);
				$("#search_gwmptsido_addr").attr("disabled", false);
				
				$("#search_gwmptsido_mapRadius").attr("disabled", true);
				$("input[id*='search_gwmptsido_mapx']").attr("disabled", true);
				$("input[id*='search_gwmptsido_mapy']").attr("disabled", true);
			}
		});
		
		// 조사년도
		drawSearchPanel2_gwmyr();
		
		// 용도구분
		drawSearchPanel2_year();
		
		// 조사항목
		drawSearchPanel2_iccode();
		
		// 시도
		drawSearchPanel2_sido();
		
		// 반경선택
		drawSearchPanel2_map();
		
		// 검색하기
		drawSearchPanel2_search();
		
		// 초기화
		drawSearchPanel2_reset();
	};
	
	// search: draw search panel : 지하수측정망(일반지역) : 조사년도
	function drawSearchPanel2_gwmyr() {
		var gwmyr = new autoInput();
		
		gwmyr.init({
			id: 'search_gwmptsido_gwmyr',
			type: 'select',
			none: '연도',
			page: 'gis1',
			query: 22,
			column: 'YEAR',
			text: 'YEAR'
		});
		
		gwmyr.query();
	};
	
	// search: draw search panel : 지하수측정망(일반지역) : 용도구분
	function drawSearchPanel2_year() {
		var yongdo = new autoInput();
		
		yongdo.init({
			id: 'search_gwmptsido_yongdo',
			type: 'select',
			none: '용도구분 선택',
			page: 'gis1',
			query: 6,
			column: 'CODE',
			text: 'NAME'
		});
		
		yongdo.query();
	};
	
	// search: draw search panel : 지하수측정망(일반지역) : 조사항목
	function drawSearchPanel2_iccode() {
		var iccode = new autoInput();
		
		iccode.init({
			id: 'search_gwmptsido_iccode',
			type: 'select',
			none: '조사항목 선택',
			page: 'gis1',
			query: 25,
			column: 'CODE',
			text: 'NAME'
		});
		
		iccode.query();
	};
	
	// search: draw search panel : 지하수측정망(일반지역) : 시도
	function drawSearchPanel2_sido() {
		var sido = new autoInput();
		
		sido.init({
			id: 'search_gwmptsido_sido',
			type: 'select',
			none: '시도 선택',
			page: 'gis1',
			query: 7,
			column: 'CODE',
			text: 'NAME'
		});
		
		sido.query();
	};
	
	// search: draw search panel : 지하수측정망(일반지역) : 반경선택
	function drawSearchPanel2_map() {
		$("#search_gwmptsido_mapS").bind("change", function(e) {
			var $t = $(e.target);
			var sv = $t.find("option:selected").val();
			sm = gis1MapManager.getMap();
			
			// 지도에서 선택
			if(sv == "direct") {
				tb = new esri.toolbars.Draw(sm);
				tb.activate(esri.toolbars.Draw.LINE, {
					showTooltips: false
				});
				
				//dojo.connect(tb, "onDrawEnd", addGraphic);
				dojo.connect(tb, "onDrawEnd", function(geo) {
				    var obj = {
				        type: 'direct',
				        r: 'search_gwmptsido_mapRadius',
				        rh: 'search_gwmptsido_mapRadiusH',
				        x1: 'search_gwmptsido_mapx1',
				        x2: 'search_gwmptsido_mapx2',
				        x3: 'search_gwmptsido_mapx3',
				        y1: 'search_gwmptsido_mapy1',
				        y2: 'search_gwmptsido_mapy2',
				        y3: 'search_gwmptsido_mapy3',
				        x: 'search_gwmptsido_mapx',
				        y: 'search_gwmptsido_mapy'
				    };
				    
				    addGraphic(geo, obj);
			    });
			}
		});
	};
	
	// search: draw search panel : 지하수측정망(일반지역) : 검색하기
	function drawSearchPanel2_search() {
		$("#search_btn_search2").bind("click", function() {
			var $gwmyr = $("#search_gwmptsido_gwmyr");
			var $gwmod = $("#search_gwmptsido_gwmod");
			var $cdrink = $("input:radio[name='search_gwmptsido_cdrink']:checked");
			var $yongdo = $("#search_gwmptsido_yongdo");
			var $iccode = $("#search_gwmptsido_iccode");
			var $sido = $("#search_gwmptsido_sido");
			var $addr = $("#search_gwmptsido_addr");
			var $radius = $("#search_gwmptsido_mapRadiusH");
			var $x = $("#search_gwmptsido_mapx");
			var $y = $("#search_gwmptsido_mapy");
			
			// 연도 미선택 시
			if($gwmyr.val() == "none") {
				alert('연도를 선택하여 주시기 바랍니다');
				return;
			}
			
			// 반기 미선택 시
			if($gwmod.val() == null) {
				alert('반기를 선택하여 주시기 바랍니다');
				return;
			}
			
			// 반경 - 직접 입력 검색 시
			if($("#search_gwmptsido_mapS option:selected").val() == 'hand') {
				sm = gis1MapManager.getMap();
				gsvc = new esri.tasks.GeometryService(gsvcURL);
				
				var pl = new esri.geometry.Polyline(sm.spatialReference);
				
				var r = parseFloat($("#search_gwmptsido_mapRadius").val());
				
		        var x1 = $("#search_gwmptsido_mapx1").val();
		        var x2 = $("#search_gwmptsido_mapx2").val();
		        var x3 = $("#search_gwmptsido_mapx3").val();
		        
		        var y1 = $("#search_gwmptsido_mapy1").val();
		        var y2 = $("#search_gwmptsido_mapy2").val();
		        var y3 = $("#search_gwmptsido_mapy3").val();
				
				var x = parseInt(x1) + (parseFloat(x2) / 60) + (parseFloat(x3) / 3600);
				var y = parseInt(y1) + (parseFloat(y2) / 60) + (parseFloat(y3) / 3600);
			
				// hidden x, y, r input
				$("#search_gwmptsido_mapx").val(x);
	        	$("#search_gwmptsido_mapy").val(y);
	        	$("#search_gwmptsido_mapRadiusH").val(r);
				
			    var pt1 = new esri.geometry.Point(x, y, new esri.SpatialReference({ wkid: 102100}));
			    
			    var r1 = r * 1000 / 111302.61697430261;
			    
				var pt2 = pt1.offset(r1, 0);
			    
				pl.addPath([pt1, pt2]);
				
				var obj = {
			        type: 'hand',
			        r: r,
			        x1: x1,
			        x2: x2,
			        x3: x3,
			        y1: y1,
			        y2: y2,
			        y3: y3,
			        x: 'search_gwmptsido_mapx',
			        y: 'search_gwmptsido_mapy'
			    };
			    
			    addGraphic(pl, obj);
			}
			
			var sidoSearch = new autoInput();
			
			// 검색 결과 항목 지정
			var columnList = ['지점코드', '지점명', '용도', '음용여부', '시도구분', '조사년도', '조사반기'];
			var columnWList = ['60px', '70px', '50px', '60px', '60px', '60px', '60px'];
			
			if($iccode.val() != "none") {
				columnList.push($iccode.find("option:selected").text());
				columnWList.push('100px');
				
				columnList.push('주소');
				columnWList.push('none');
			} else {
				columnList.push('주소');
				columnWList.push('none');
			}
			
			// 연도별 쿼리 선택
			var qn;
			
			if(parseInt($gwmyr.val()) <= 2009) qn = 8;
			else qn = 29;
			
			sidoSearch.init({
				id: 'resultBox',
				type: 'markerTable',
				page: 'gis1',
				query: qn,
				column: columnList,
				columnW: columnWList,
				excel: 2,
				chart: 2,
				detail: true,
				detailID: 'resultDetailBox',
				detailColumn : ['지점코드', '지점명', '시도구분', '조사년도', '조사반기', '음용여부', '용도', '주소', '수소이온농도(pH)', '총대장균군', '질산성질소(NO3-N)', '염소이온(Cl-)', '카드뮴(Cd)', '비소(As)', '시안(CN)', '수은(Hg)', '유기인', '페놀(Phenol)', '납(Pb)', '6가크롬(Cr+6)', '트리클로로에틸렌(TCE)', '테트라클로로에틸렌(PCE)', '1,1,1-TCE(1,1,1-TCE)', '벤젠(Benzene)', '톨루엔(Toluene)', '에틸벤젠(Ethyl Benzene)', '크실렌(Xylene)'],
				cond: [
					{
						col: 'gwmyr',
						val: ($gwmyr.val() == "none") ? "" : $gwmyr.val()
					},
					{
						col: 'gwmod',
						val: ($gwmod.val() == "none") ? "" : $gwmod.val()
					},
					{
						col: 'cdrink',
						val: ($cdrink.val() == "A") ? "" : $cdrink.val()
					},
					{
						col: 'yongdo',
						val: ($yongdo.val() == "none" || $cdrink.val() != "01") ? "" : $yongdo.val()
					},
					{
						col: 'sido',
						val: ($sido.val() == "none") ? "" : $sido.val()
					},
					{
						col: 'addr',
						val: encodeURIComponent(encodeURIComponent($addr.val(), "UTF-8"))
					},
					{
						col: 'radius',
						val: ($radius.val() == "none") ? "" : $radius.val()
					},
					{
						col: 'x',
						val: ($x.val() == "none") ? "" : $x.val()
					},
					{
						col: 'y',
						val: ($y.val() == "none") ? "" : $y.val()
					}
				],
				mapManager: gis1MapManager,
				icon: {
					gubun: '2',
					year: $gwmyr.val(),
					cdrink: ($cdrink.val() == "A") ? "" : $cdrink.val(),
					yongdo: ($yongdo.val() == "none") ? "" : $yongdo.val(),
					jimok: "",
					iccode: ($iccode.val() == "none") ? "" : $iccode.val(),
					icname: ($iccode.val() == "none") ? "" : $iccode.find("option:selected").text()
				}
			});
			
			sidoSearch.query();
		});
	};
	
	// search: draw search panel : 지하수측정망(일반지역) : 초기화
	function drawSearchPanel2_reset() {
		$("#search_btn_reset2").bind("click", function() {
			$("#search_gwmptsido_gwmyr").val("none");
			$("#search_gwmptsido_gwmod").val("none");
			$("input[name='search_gwmptsido_cdrink']").removeAttr("checked");
			$("input[name='search_gwmptsido_cdrink'][value='A']").prop('checked', true);
			$("#search_gwmptsido_yongdo").val("none");
			$("#search_gwmptsido_iccode").val("none");
			$("#search_gwmptsido_sido").val("none");
			$("#search_gwmptsido_addr").val("");
			
			$("#search_gwmptsido_mapS").val("none");
			$("#search_gwmptsido_mapRadius").val("");
			$("input[id*='search_gwmptsido_mapx']").val("");
			$("input[id*='search_gwmptsido_mapy']").val("");
			
			$("#search_gwmptsido_gwmyr").attr("disabled", false);
			$("#search_gwmptsido_gwmod").attr("disabled", false);
			$("input[name='search_gwmptsido_cdrink']").attr("disabled", false);
			$("#search_gwmptsido_yongdo").attr("disabled", true);
			$("#search_gwmptsido_iccode").attr("disabled", true);
			$("#search_gwmptsido_sido").attr("disabled", false);
			$("#search_gwmptsido_addr").attr("disabled", false);
			
			$("#search_gwmptsido_mapS").attr("disabled", false);
			$("#search_gwmptsido_mapRadius").attr("disabled", true);
			$("input[id*='search_gwmptsido_mapx']").attr("disabled", true);
			$("input[id*='search_gwmptsido_mapy']").attr("disabled", true);
			
			sm = gis1MapManager.getMap();
			
			if(sm.graphicsLayerIds.toString().indexOf('bufferSearch') > -1) {
				tgl.clear();
			}
		});
	};
	
	// search: draw search panel : 토양측정망
	function drawSearchPanel3() {
		// 시도, 시군구 -> 지점주소 검색 x, 반경 검색 x
		$("#search_smpt_sido").bind("change", function() {
			var sido = $("#search_smpt_sido option:selected").val();
			
			if (sido != "none") {
				$("#search_smpt_addr").attr("disabled", true);
		
				$("#search_smpt_mapS").attr("disabled", true);
				$("#search_smpt_mapRadius").attr("disabled", true);
				$("input[id*='search_smpt_mapx']").attr("disabled", true);
				$("input[id*='search_smpt_mapy']").attr("disabled", true);
			} else {
				$("#search_smpt_addr").attr("disabled", false);
		
				$("#search_smpt_mapS").attr("disabled", false);
				$("#search_smpt_mapRadius").attr("disabled", false);
				$("input[id*='search_smpt_mapx']").attr("disabled", false);
				$("input[id*='search_smpt_mapy']").attr("disabled", false);
			}
		});
		
		// 지점주소 -> 시도, 시군구 검색 x, 반경 검색 x
		$("#search_smpt_addr").bind("keydown", function() {
			var addr = $("#search_smpt_addr").val();
			
			if(addr != "") {
				$("#search_smpt_sido").attr("disabled", true);
				$("#search_smpt_gu").attr("disabled", true);
		
				$("#search_smpt_mapS").attr("disabled", true);
				$("#search_smpt_mapRadius").attr("disabled", true);
				$("input[id*='search_smpt_mapx']").attr("disabled", true);
				$("input[id*='search_smpt_mapy']").attr("disabled", true);
			} else {
				$("#search_smpt_sido").attr("disabled", false);
				$("#search_smpt_gu").attr("disabled", false);
		
				$("#search_smpt_mapS").attr("disabled", false);
				$("#search_smpt_mapRadius").attr("disabled", false);
				$("input[id*='search_smpt_mapx']").attr("disabled", false);
				$("input[id*='search_smpt_mapy']").attr("disabled", false);
			}
		});

		// 좌표, 반경거리 -> 시도, 시군구, 주소 검색 x, 반경검색(직접입력)
		$("input[id*='search_smpt_mapx'], input[id*='search_smpt_mapy'], #search_smpt_mapRadius").bind("keydown", function() {
			var x1 = $("#search_smpt_mapx1").val();
			var x2 = $("#search_smpt_mapx2").val();
			var x3 = $("#search_smpt_mapx3").val();
			
			var y1 = $("#search_smpt_mapy1").val();
			var y2 = $("#search_smpt_mapy2").val();
			var y3 = $("#search_smpt_mapy3").val();
			
			var r = $("#search_smpt_mapRadius").val();
			
			if(x1 != "" || x2 != "" || x3 != "" || y1 != "" || y2 != "" || y3 != "" || r != "") {
				$("#search_smpt_sido").attr("disabled", true);
				$("#search_smpt_gu").attr("disabled", true);
				$("#search_smpt_addr").attr("disabled", true);
				
				$("#search_smpt_mapS").val("hand");
			} else {
				$("#search_smpt_sido").attr("disabled", false);
				$("#search_smpt_gu").attr("disabled", false);
				$("#search_smpt_addr").attr("disabled", false);
				
				$("#search_smpt_mapS").val("none");
			}
		});
		
		// 반경검색 지도에서 선택 -> 시도, 시군구, 주소검색 x, 반경거리, 좌표 x
		$("#search_smpt_mapS").bind("change", function() {
			var ms = $("#search_smpt_mapS option:selected").val();
			
			if(ms == 'direct') {
				$("#search_smpt_sido").attr("disabled", true);
				$("#search_smpt_gu").attr("disabled", true);
				$("#search_smpt_addr").attr("disabled", true);
				
				$("#search_smpt_mapRadius").attr("disabled", true);
				$("input[id*='search_smpt_mapx']").attr("disabled", true);
				$("input[id*='search_smpt_mapy']").attr("disabled", true);
			} else if(ms == 'hand') {  
				$("#search_smpt_sido").attr("disabled", true);
				$("#search_smpt_gu").attr("disabled", true);
				$("#search_smpt_addr").attr("disabled", true);
				
				$("#search_smpt_mapRadius").attr("disabled", false);
				$("input[id*='search_smpt_mapx']").attr("disabled", false);
				$("input[id*='search_smpt_mapy']").attr("disabled", false);
			} else {
				$("#search_smpt_sido").attr("disabled", false);
				$("#search_smpt_gu").attr("disabled", false);
				$("#search_smpt_addr").attr("disabled", false);
				
				$("#search_smpt_mapRadius").attr("disabled", true);
				$("input[id*='search_smpt_mapx']").attr("disabled", true);
				$("input[id*='search_smpt_mapy']").attr("disabled", true);
			}
		});
		
		// 조사년도
		drawSearchPanel3_year();
		
		// 조사항목
		drawSearchPanel3_iccode();
		
		// 지목
		drawSearchPanel3_jimok();
				
		// 환경청
		drawSearchPanel3_contorg();
		
		// 시도
		drawSearchPanel3_sido();
		
		// 시군구
		drawSearchPanel3_gu();
		
		// 반경선택
		drawSearchPanel3_map();
		
		// 검색하기
		drawSearchPanel3_search();
		
		// 초기화
		drawSearchPanel3_reset();
	};
	
	// search: draw search panel : 토양측정망 : 조사년도
	function drawSearchPanel3_year() {
		var year = new autoInput();
		
		year.init({
			id: 'search_smpt_year',
			type: 'select',
			none: '조사년도 선택',
			page: 'gis1',
			query: 23,
			column: 'YEAR',
			text: 'YEAR'
		});
		
		year.query();
	};
	
	// search: draw search panel : 토양측정망 : 조사항목
	function drawSearchPanel3_iccode() {
		var iccode = new autoInput();
		
		iccode.init({
			id: 'search_smpt_iccode',
			type: 'select',
			none: '조사항목 선택',
			page: 'gis1',
			query: 27,
			column: 'CODE',
			text: 'NAME'
		});
		
		iccode.query();
	};
	
	// search: draw search panel : 토양측정망 : 지목
	function drawSearchPanel3_jimok() {
		var jimok = new autoInput();
		
		jimok.init({
			id: 'search_smpt_jimok',
			type: 'select',
			none: '지목 선택',
			page: 'gis1',
			query: 10,
			column: 'CODE',
			text: 'NAME'
		});
		
		jimok.query();
	};
	
	// search: draw search panel : 토양측정망 : 환경청
	function drawSearchPanel3_contorg() {
		var contorg = new autoInput();
		
		contorg.init({
			id: 'search_smpt_contorg',
			type: 'select',
			none: '환경청 선택',
			page: 'gis1',
			query: 9,
			column: 'CODE',
			text: 'NAME'
		});
		
		contorg.query();
	};

	// search: draw search panel : 토양측정망 : 시도
	function drawSearchPanel3_sido() {
		var sido = new autoInput();
		
		sido.init({
			id: 'search_smpt_sido',
			type: 'select',
			none: '시도 선택',
			page: 'gis1',
			query: 3,
			column: 'CODE',
			text: 'NAME'
		});
		
		sido.query();
	};

	// search: draw search panel : 토양측정망 : 시군구
	function drawSearchPanel3_gu() {
		$("#search_smpt_sido").bind("change", function() {
			var sidoVal = $("#search_smpt_sido option:selected").val();
			
			if(sidoVal != "none") {
				var gu = new autoInput();
				
				gu.init({
					id: 'search_smpt_gu',
					type: 'select',
					none: '시군구 선택',
					page: 'gis1',
					query: 4,
					column: 'CODE',
					text: 'NAME',
					cond: [
						{
							col: 'sido',
							val: sidoVal
						}
					]
				});
				
				gu.query();
			} else {
				$("#search_smpt_gu").val("none");
				$("#search_smpt_gu option[value!='none']").remove();
			}
		});
	};
	
	// search: draw search panel : 토양측정망 : 반경선택
	function drawSearchPanel3_map() {
		$("#search_smpt_mapS").bind("change", function(e) {
			var $t = $(e.target);
			var sv = $t.find("option:selected").val();
			sm = gis1MapManager.getMap();
			
			// 지도에서 선택
			if(sv == "direct") {
				tb = new esri.toolbars.Draw(sm);
				tb.activate(esri.toolbars.Draw.LINE, {
					showTooltips: false
				});
				
				//dojo.connect(tb, "onDrawEnd", addGraphic);
				dojo.connect(tb, "onDrawEnd", function(geo) {
				    var obj = {
				        type: 'direct',
				        r: 'search_smpt_mapRadius',
				        rh: 'search_smpt_mapRadiusH',
				        x1: 'search_smpt_mapx1',
				        x2: 'search_smpt_mapx2',
				        x3: 'search_smpt_mapx3',
				        y1: 'search_smpt_mapy1',
				        y2: 'search_smpt_mapy2',
				        y3: 'search_smpt_mapy3',
				        x: 'search_smpt_mapx',
				        y: 'search_smpt_mapy'
				    };
				    
				    addGraphic(geo, obj);
			    });
			}
		});
	};

	// search: draw search panel : 토양측정망 : 검색하기
	function drawSearchPanel3_search() {
		$("#search_btn_search3").bind("click", function() {
			var $year = $("#search_smpt_year");
			var $jimok = $("#search_smpt_jimok");
			var $contorg = $("#search_smpt_contorg");
			var $sido = $("#search_smpt_sido");
			var $gu = $("#search_smpt_gu");
			var $addr = $("#search_smpt_addr");
			var $iccode = $("#search_smpt_iccode");
			var $radius = $("#search_smpt_mapRadiusH");
			var $x = $("#search_smpt_mapx");
			var $y = $("#search_smpt_mapy");
			
			// 연도 미선택 시
			if($year.val() == "none") {
				alert('연도를 선택하여 주시기 바랍니다');
				return;
			}
			
			// 반경 - 직접 입력 검색 시
			if($("#search_smpt_mapS option:selected").val() == 'hand') {
				sm = gis1MapManager.getMap();
				gsvc = new esri.tasks.GeometryService(gsvcURL);
				
				var pl = new esri.geometry.Polyline(sm.spatialReference);
				
				var r = parseFloat($("#search_smpt_mapRadius").val());
				
		        var x1 = $("#search_smpt_mapx1").val();
		        var x2 = $("#search_smpt_mapx2").val();
		        var x3 = $("#search_smpt_mapx3").val();
		        
		        var y1 = $("#search_smpt_mapy1").val();
		        var y2 = $("#search_smpt_mapy2").val();
		        var y3 = $("#search_smpt_mapy3").val();
				
				var x = parseInt(x1) + (parseFloat(x2) / 60) + (parseFloat(x3) / 3600);
				var y = parseInt(y1) + (parseFloat(y2) / 60) + (parseFloat(y3) / 3600);
			
				// hidden x, y, r input
				$("#search_smpt_mapx").val(x);
	        	$("#search_smpt_mapy").val(y);
	        	$("#search_smpt_mapRadiusH").val(r);
				
			    var pt1 = new esri.geometry.Point(x, y, new esri.SpatialReference({ wkid: 102100}));
			    
			    var r1 = r * 1000 / 111302.61697430261;
			    
				var pt2 = pt1.offset(r1, 0);
			    
				pl.addPath([pt1, pt2]);
				
				var obj = {
			        type: 'hand',
			        r: r,
			        x1: x1,
			        x2: x2,
			        x3: x3,
			        y1: y1,
			        y2: y2,
			        y3: y3,
			        x: 'search_smpt_mapx',
			        y: 'search_smpt_mapy'
			    };
			    
			    addGraphic(pl, obj);
			}
			
			var smptSearch = new autoInput();
			
			// 검색 결과 항목 지정
			var columnList = ['지점코드', '지점명', '환경청', '지목', '면적', '조사년도'];
			var columnWList = ['60px', '80px', '50px', '50px', '50px', '60px'];
			
			if($iccode.val() != "none") {
				columnList.push($iccode.find("option:selected").text());
				columnWList.push('100px');
				
				columnList.push('주소');
				columnWList.push('none');
			} else {
				columnList.push('주소');
				columnWList.push('none');
			}
			
			// 연도별 쿼리, 상세정보 선택
			var qn;
			var dc;
			
			if (parseInt($year.val()) <= 2009) {
				qn = 11;
				dc = ['지점코드', '지점명', '환경청', '조사년도', '지목', '면적', '주소', '카드뮴(Cd)', '구리(Cu)', '비소(As)', '수은(Hg)', '납(Pb)', '6가크롬(Cr+6)', '아연(Zn)', '니켈(Ni)', '불소(F)', '유기인', '폴리클로리네이티드비페닐(PCB)', '시안(CN)', '페놀(Phenol)', '유류', 'BTEX', '석유계총탄화수소(TPH)', '트리클로로에틸렌(TCE)', '테트라클로로에틸렌(PCE)', '수소이온농도(pH)'];
			} else {
				qn = 30;
				dc = ['지점코드', '지점명', '환경청', '조사년도', '지목', '면적', '주소', '카드뮴(Cd)', '구리(Cu)', '비소(As)', '수은(Hg)', '납(Pb)', '6가크롬(Cr+6)', '아연(Zn)', '니켈(Ni)', '불소(F)', '유기인', '폴리클로리네이티드비페닐(PCB)', '시안(CN)', '페놀(Phenol)', '석유계총탄화수소(TPH)', '트리클로로에틸렌(TCE)', '테트라클로로에틸렌(PCE)', '벤젠(Benzene)', '톨루엔(Toluene)', '에틸벤젠(Ethyl Benzene)', '크실렌(Xylene)', '벤조(a)피렌(Benpy)'];
			} 
			
			smptSearch.init({
				id: 'resultBox',
				type: 'markerTable',
				page: 'gis1',
				query: qn,
				column: columnList,
				columnW: columnWList,
				excel: 3,
				chart: 3,
				detail: true,
				detailID: 'resultDetailBox',
				detailColumn : dc,
				cond: [
					{
						col: 'year',
						val: ($year.val() == "none") ? "" : $year.val()
					},
					{
						col: 'jimok',
						val: ($jimok.val() == "none") ? "" : $jimok.val()
					},
					{
						col: 'contorg',
						val: ($contorg.val() == "none") ? "" : $contorg.val()
					},
					{
						col: 'sido',
						val: ($sido.val() == "none") ? "" : $sido.val()
					},
					{
						col: 'gu',
						val: ($gu.val() == "none") ? "" : $gu.val()
					},
					{
						col: 'addr',
						val: encodeURIComponent(encodeURIComponent($addr.val(), "UTF-8"))
					},
					{
						col: 'radius',
						val: ($radius.val() == "none") ? "" : $radius.val()
					},
					{
						col: 'x',
						val: ($x.val() == "none") ? "" : $x.val()
					},
					{
						col: 'y',
						val: ($y.val() == "none") ? "" : $y.val()
					}
				],
				mapManager: gis1MapManager,
				icon: {
					gubun: '3',
					year: $year.val(),
					cdrink: "",
					yongdo: "",
					jimok: ($jimok.val() == "none") ? "" : $jimok.val(),
					iccode: ($iccode.val() == "none") ? "" : $iccode.val(),
					icname: ($iccode.val() == "none") ? "" : $iccode.find("option:selected").text()
				}
			});
			
			smptSearch.query();
		});
	};
	
	// search: draw search panel : 토양측정망 : 초기화
	function drawSearchPanel3_reset() {
		$("#search_btn_reset3").bind("click", function() {
			$("#search_smpt_year").val("none");
			$("#search_smpt_iccode").val("none");
			$("#search_smpt_jimok").val("none");
			$("#search_smpt_contorg").val("none");
			$("#search_smpt_sido").val("none");
			$("#search_smpt_gu").val("none");
			$("#search_smpt_addr").val("");
			
			$("#search_smpt_mapS").val("none");
			$("#search_smpt_mapRadius").val("");
			$("input[id*='search_smpt_mapx']").val("");
			$("input[id*='search_smpt_mapy']").val("");
			
			$("#search_smpt_gu option[value!='none']").remove();
			
			$("#search_smpt_year").attr("disabled", false);
			$("#search_smpt_iccode").attr("disabled", false);
			$("#search_smpt_jimok").attr("disabled", false);
			$("#search_smpt_contorg").attr("disabled", false);
			$("#search_smpt_sido").attr("disabled", false);
			$("#search_smpt_gu").attr("disabled", false);
			$("#search_smpt_addr").attr("disabled", false);
			
			$("#search_smpt_mapS").attr("disabled", false);
			$("#search_smpt_mapRadius").attr("disabled", true);
			$("input[id*='search_smpt_mapx']").attr("disabled", true);
			$("input[id*='search_smpt_mapy']").attr("disabled", true);
			
			sm = gis1MapManager.getMap();
			
			if(sm.graphicsLayerIds.toString().indexOf('bufferSearch') > -1) {
				tgl.clear();
			}
		});
	};

	// search: draw search panel : 골프장
	function drawSearchPanel4() {
		// 시도, 시군구 -> 지점주소 x, 반경검색 x
		$("#search_golf_sido").bind("change", function() {
			var sido = $("#search_golf_sido option:selected").val();
			
			if(sido != "none") {
				$("#search_golf_addr").attr("disabled", true);
		
				$("#search_golf_mapS").attr("disabled", true);
				$("#search_golf_mapRadius").attr("disabled", true);
				$("input[id*='search_golf_mapx']").attr("disabled", true);
				$("input[id*='search_golf_mapy']").attr("disabled", true);
			}
			else {
				$("#search_golf_addr").attr("disabled", false);
		
				$("#search_golf_mapS").attr("disabled", false);
				$("#search_golf_mapRadius").attr("disabled", false);
				$("input[id*='search_golf_mapx']").attr("disabled", false);
				$("input[id*='search_golf_mapy']").attr("disabled", false);
			}
		});
		
		// 지점주소 -> 시도, 시군구 x, 반경검색 x
		$("#search_golf_addr").bind("keydown", function() {
			var addr = $("#search_golf_addr").val();
			
			if(addr != "") {
				$("#search_golf_sido").attr("disabled", true);
				$("#search_golf_gu").attr("disabled", true);
		
				$("#search_golf_mapS").attr("disabled", true);
				$("#search_golf_mapRadius").attr("disabled", true);
				$("input[id*='search_golf_mapx']").attr("disabled", true);
				$("input[id*='search_golf_mapy']").attr("disabled", true);
			} else {
				$("#search_golf_sido").attr("disabled", false);
				$("#search_golf_gu").attr("disabled", false);
		
				$("#search_golf_mapS").attr("disabled", false);
				$("#search_golf_mapRadius").attr("disabled", false);
				$("input[id*='search_golf_mapx']").attr("disabled", false);
				$("input[id*='search_golf_mapy']").attr("disabled", false);
			}
		});
		
		// 좌표, 반경거리 -> 시도, 시군구, 주소 검색 x, 반경검색(직접입력)
		$("input[id*='search_golf_mapx'], input[id*='search_golf_mapy'], #search_golf_mapRadius").bind("keydown", function() {
			var x1 = $("#search_golf_mapx1").val();
			var x2 = $("#search_golf_mapx2").val();
			var x3 = $("#search_golf_mapx3").val();
			
			var y1 = $("#search_golf_mapy1").val();
			var y2 = $("#search_golf_mapy2").val();
			var y3 = $("#search_golf_mapy3").val();
			
			var r = $("#search_golf_mapRadius").val();
			
			if(x1 != "" || x2 != "" || x3 != "" || y1 != "" || y2 != "" || y3 != "" || r != "") {
				$("#search_golf_sido").attr("disabled", true);
				$("#search_golf_gu").attr("disabled", true);
				$("#search_golf_addr").attr("disabled", true);
				
				$("#search_golf_mapS").val("hand");
			} else {
				$("#search_golf_sido").attr("disabled", false);
				$("#search_golf_gu").attr("disabled", false);
				$("#search_golf_addr").attr("disabled", false);
				
				$("#search_golf_mapS").val("none");
			}
		});
		
		// 반경검색 지도에서 선택 -> 시도, 시군구, 주소검색 x, 반경거리, 좌표 x
		$("#search_golf_mapS").bind("change", function() {
			var ms = $("#search_golf_mapS option:selected").val();
			
			if(ms == 'direct') {
				$("#search_golf_sido").attr("disabled", true);
				$("#search_golf_gu").attr("disabled", true);
				$("#search_golf_addr").attr("disabled", true);
				
				$("#search_golf_mapRadius").attr("disabled", true);
				$("input[id*='search_golf_mapx']").attr("disabled", true);
				$("input[id*='search_golf_mapy']").attr("disabled", true);
			} else if(ms == 'hand') {  
				$("#search_golf_sido").attr("disabled", true);
				$("#search_golf_gu").attr("disabled", true);
				$("#search_golf_addr").attr("disabled", true);
				
				$("#search_golf_mapRadius").attr("disabled", false);
				$("input[id*='search_golf_mapx']").attr("disabled", false);
				$("input[id*='search_golf_mapy']").attr("disabled", false);
			} else {
				$("#search_golf_sido").attr("disabled", false);
				$("#search_golf_gu").attr("disabled", false);
				$("#search_golf_addr").attr("disabled", false);
				
				$("#search_golf_mapRadius").attr("disabled", true);
				$("input[id*='search_golf_mapx']").attr("disabled", true);
				$("input[id*='search_golf_mapy']").attr("disabled", true);
			}
		});
		
		// 연도
		drawSearchPanel4_year();
		
		// 시도
		drawSearchPanel4_sido();
		
		// 시군구
		drawSearchPanel4_gu();
		
		// 반경선택
		drawSearchPanel4_map();
		
		// 검색하기
		drawSearchPanel4_search();
		
		// 초기화
		drawSearchPanel4_reset();
	};
	
	// search: draw search panel : 골프장 : 등록년도
	function drawSearchPanel4_year() {
		var year = new autoInput();
		
		year.init({
			id: 'search_golf_year',
			type: 'select',
			none: '연도',
			page: 'gis1',
			query: 12,
			column: 'YEAR',
			text: 'YEAR'
		});
		
		year.query();
	};
	
	// search: draw search panel : 골프장 : 시도
	function drawSearchPanel4_sido() {
		// sido
		var sido = new autoInput();
		
		sido.init({
			id: 'search_golf_sido',
			type: 'select',
			none: '시도 선택',
			page: 'gis1',
			query: 3,
			column: 'CODE',
			text: 'NAME'
		});
		
		sido.query();
	};

	// search: draw search panel : 골프장 : 시군구
	function drawSearchPanel4_gu() {
		// gu
		$("#search_golf_sido").bind("change", function() {
			var sidoVal = $("#search_golf_sido option:selected").val();
			
			if(sidoVal != "none") {
				var gu = new autoInput();
				
				gu.init({
					id: 'search_golf_gu',
					type: 'select',
					none: '시군구 선택',
					page: 'gis1',
					query: 4,
					column: 'CODE',
					text: 'NAME',
					cond: [
						{
							col: 'sido',
							val: sidoVal
						}
					]
				});
				
				gu.query();
			} else {
				$("#search_golf_gu").val("none");
				$("#search_golf_gu option[value!='none']").remove();
			}
		});
	};
	
	// search: draw search panel : 지하수측정망(오염우려지역) : 반경선택
	function drawSearchPanel4_map() {
		$("#search_golf_mapS").bind("change", function(e) {
			var $t = $(e.target);
			var sv = $t.find("option:selected").val();
			sm = gis1MapManager.getMap();
			
			// 지도에서 선택
			if(sv == "direct") {
				tb = new esri.toolbars.Draw(sm);
				tb.activate(esri.toolbars.Draw.LINE, {
					showTooltips: false
				});
				
				//dojo.connect(tb, "onDrawEnd", addGraphic);
				dojo.connect(tb, "onDrawEnd", function(geo) {
				    var obj = {
				        type: 'direct',
				        r: 'search_golf_mapRadius',
				        rh: 'search_golf_mapRadiusH',
				        x1: 'search_golf_mapx1',
				        x2: 'search_golf_mapx2',
				        x3: 'search_golf_mapx3',
				        y1: 'search_golf_mapy1',
				        y2: 'search_golf_mapy2',
				        y3: 'search_golf_mapy3',
				        x: 'search_golf_mapx',
				        y: 'search_golf_mapy'
				    };
				    
				    addGraphic(geo, obj);
			    });
			}
		});
	};
	
	// search: draw search panel : 골프장 : 검색하기
	function drawSearchPanel4_search() {
		$("#search_btn_search4").bind("click", function() {
			var $year = $("#search_golf_year");
			var $mod = $("#search_golf_mod");
			var $sido = $("#search_golf_sido");
			var $gu = $("#search_golf_gu");
			var $addr = $("#search_golf_addr");
			var $name = $("#search_golf_name");
			var $radius = $("#search_golf_mapRadiusH");
			var $x = $("#search_golf_mapx");
			var $y = $("#search_golf_mapy");
			
			// 연도 미선택 시
			if($year.val() == "none") {
				alert('연도를 선택하여 주시기 바랍니다');
				return;
			}
			
			// 반기 미선택 시
			if($mod.val() == "none") {
				alert('반기를 선택하여 주시기 바랍니다');
				return;
			}
			
			// 반경 - 직접 입력 검색 시
			if($("#search_golf_mapS option:selected").val() == 'hand') {
				sm = gis1MapManager.getMap();
				gsvc = new esri.tasks.GeometryService(gsvcURL);
				
				var pl = new esri.geometry.Polyline(sm.spatialReference);
				
				var r = parseFloat($("#search_golf_mapRadius").val());
				
		        var x1 = $("#search_golf_mapx1").val();
		        var x2 = $("#search_golf_mapx2").val();
		        var x3 = $("#search_golf_mapx3").val();
		        
		        var y1 = $("#search_golf_mapy1").val();
		        var y2 = $("#search_golf_mapy2").val();
		        var y3 = $("#search_golf_mapy3").val();
				
				var x = parseInt(x1) + (parseFloat(x2) / 60) + (parseFloat(x3) / 3600);
				var y = parseInt(y1) + (parseFloat(y2) / 60) + (parseFloat(y3) / 3600);
			
				// hidden x, y, r input
				$("#search_golf_mapx").val(x);
	        	$("#search_golf_mapy").val(y);
	        	$("#search_golf_mapRadiusH").val(r);
				
			    var pt1 = new esri.geometry.Point(x, y, new esri.SpatialReference({ wkid: 102100}));
			    
			    var r1 = r * 1000 / 111302.61697430261;
			    
				var pt2 = pt1.offset(r1, 0);
			    
				pl.addPath([pt1, pt2]);
				
				var obj = {
			        type: 'hand',
			        r: r,
			        x1: x1,
			        x2: x2,
			        x3: x3,
			        y1: y1,
			        y2: y2,
			        y3: y3,
			        x: 'search_golf_mapx',
			        y: 'search_golf_mapy'
			    };
			    
			    addGraphic(pl, obj);
			}
			
			var golfSearch = new autoInput();
			
			// 연도별 쿼리 선택
			var qn;
			
			if (parseInt($year.val()) <= 2009) {
				qn = 13;
			} else {
				qn = 31;
			} 
			
			golfSearch.init({
				id: 'resultBox',
				type: 'markerTable',
				page: 'gis1',
				query: qn,
				column: ['지점코드', '지점명', '등록년도', '등록반기', '주소'],
				columnW: ['70px', '150px', '60px', '60px', 'none'],
				excel: 4,
				chart: 4,
				detail: true,
				detailID: 'resultDetailBox',
				detailColumn : ['지점코드', '지점명', '주소', '등록년도', '등록반기', '홀수', '시도구분', '총면적', '골프장유형', '농약사용면적', '농약미사용면적', '농약사용량 실물량', '농약사용량 성분량', '사용면적대비농약사용량 실물량', '사용면적대비농약사용량 성분량', '총면적대비농약사용량 실물량', '총면적대비농약사용량 성분량'],
				cond: [
					{
						col: 'year',
						val: ($year.val() == "none") ? "" : $year.val()
					},
					{
						col: 'mod',
						val: ($mod.val() == "none") ? "" : $mod.val()
					},
					{
						col: 'sido',
						val: ($sido.val() == "none") ? "" : $sido.val()
					},
					{
						col: 'gu',
						val: ($gu.val() == "none") ? "" : $gu.val()
					},
					{
						col: 'addr',
						val: encodeURIComponent(encodeURIComponent($addr.val(), "UTF-8"))
					},
					{
						col: 'name',
						val: encodeURIComponent(encodeURIComponent($name.val(), "UTF-8"))
					},
					{
						col: 'radius',
						val: ($radius.val() == "none") ? "" : $radius.val()
					},
					{
						col: 'x',
						val: ($x.val() == "none") ? "" : $x.val()
					},
					{
						col: 'y',
						val: ($y.val() == "none") ? "" : $y.val()
					}
				],
				mapManager: gis1MapManager
			});
			
			golfSearch.query();
		});
	};

	// search: draw search panel : 골프장 : 초기화
	function drawSearchPanel4_reset() {
		$("#search_btn_reset4").bind("click", function() {
			$("#search_golf_year").val("none");
			$("#search_golf_mod").val("none");
			$("#search_golf_sido").val("none");
			$("#search_golf_gu").val("none");
			$("#search_golf_addr").val("");
			$("#search_golf_name").val("");
			
			$("#search_golf_mapS").val("none");
			$("#search_golf_mapRadius").val("");
			$("input[id*='search_golf_mapx']").val("");
			$("input[id*='search_golf_mapy']").val("");
			
			$("#search_golf_gu option[value!='none']").remove();
			
			$("#search_golf_year").attr("disabled", false);
			$("#search_golf_mod").attr("disabled", false);
			$("#search_golf_sido").attr("disabled", false);
			$("#search_golf_gu").attr("disabled", false);
			$("#search_golf_addr").attr("disabled", false);
			$("#search_golf_name").attr("disabled", false);
			
			$("#search_golf_mapS").attr("disabled", false);
			$("#search_golf_mapRadius").attr("disabled", true);
			$("input[id*='search_golf_mapx']").attr("disabled", true);
			$("input[id*='search_golf_mapy']").attr("disabled", true);
			
			sm = gis1MapManager.getMap();
			
			if(sm.graphicsLayerIds.toString().indexOf('bufferSearch') > -1) {
				tgl.clear();
			}
		});
	};

//	// search: draw search panel: 가축매몰지 
//	function drawSearchPanel5() {
//		// 연도/반기 선택 -> 일자 x
//		$("#search_bg_year, #search_bg_mod").bind("change", function() {
//			var year = $("#search_bg_year option:selected").val();
//			var mod = $("#search_bg_mod option:selected").val();
//			
//			if (year != "none" || mod != "none") {
//				$("#search_bg_start").attr("disabled", true);
//				$("#search_bg_end").attr("disabled", true);
//			} else {
//				$("#search_bg_start").attr("disabled", false);
//				$("#search_bg_end").attr("disabled", false);
//			}
//		});
//		
//		// 일자 선택 -> 연도/반기 x
//		$("#search_bg_start, #search_bg_end").bind("change", function() {
//			var start = $("#search_bg_start").val();
//			var end = $("#search_bg_end").val();
//			
//			if(start != "" || end != "") {
//				$("#search_bg_year").attr("disabled", true);
//				$("#search_bg_mod").attr("disabled", true);
//			} else {
//				$("#search_bg_year").attr("disabled", false);
//				$("#search_bg_mod").attr("disabled", false);
//			}
//		});
//		
//		// 시도, 시군구 검색 -> 주소 검색 x
//		$("#search_bg_sido").bind("change", function() {
//			var sido = $("#search_bg_sido option:selected").val();
//			
//			if (sido != "none") {
//				$("#search_bg_addr").attr("disabled", true);
//			} else {
//				$("#search_bg_addr").attr("disabled", false);
//			}
//		});
//		
//		// 지점주소 -> 시도, 시군구 검색 x
//		$("#search_bg_addr").bind("keydown", function() {
//			var sido = $("#search_bg_addr").val();
//			
//			if(sido != "") {
//				$("#search_bg_sido").attr("disabled", true);
//				$("#search_bg_gu").attr("disabled", true);
//			} else {
//				$("#search_bg_sido").attr("disabled", false);
//				$("#search_bg_gu").attr("disabled", false);
//			}
//		});
//		// 일자
//		drawSearchPanel5_date();
//		
//		// 연도
//		drawSearchPanel5_year();
//		
//		// 시도
//		drawSearchPanel5_sido();
//		
//		// 시군구
//		drawSearchPanel5_gu();
//		
//		// 검색하기
//		drawSearchPanel5_search();
//		
//		// 초기화
//		drawSearchPanel5_reset();
//	};
//	
//	// search: draw search panel: 가축매몰지 - 일자
//	function drawSearchPanel5_date() {
//		$.ajax({
//			type: "get",
//			url: '/jsp/getQueryData.jsp?page=gis1&query=14',
//			success: function(data) {
//				var r = data.d;
//				var defaultDate = r[0].STARTMIN;
//				var startYear = new Date(r[0].STARTMIN);
//				var endYear = new Date(r[0].STARTMAX);
//				
//				startYear = startYear.getFullYear();
//				endYear = endYear.getFullYear();
//				
//				// 일자
//				$("#search_bg_start, #search_bg_end").datepicker({
//					showAnim: 'slideDown',
//					showOtherMonths: false,
//					selectOtherMonths: true,
//					changeMonth: true,
//					changeYear: true,
//					showMonthAfterYear: true,
//					dateFormat: 'yy-mm-dd',
//					showOn: "button",
//					buttonImage: "/ce/resources/images/gis1/search_btn_calendar_add.png",
//					buttonImageOnly: true,
//					closeText: "닫기",
//					dayNames: ["일", "월", "화", "수", "목", "금", "토"],
//					dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
//					dayNamesShort: ["일", "월", "화", "수", "목", "금", "토"],
//					monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
//					monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
//					defaultDate: defaultDate, 
//					yearRange: startYear + ":" + endYear
//				});
//				
//				// 일자 삭제
//				$("#search_bg_dateDel").bind("click", function() {
//					$("#search_bg_start").val("");
//					$("#search_bg_end").val("");
//					
//					$("#search_bg_year").attr("disabled", false);
//					$("#search_bg_mod").attr("disabled", false);
//				});
//			}
//		});
//	};
//	
//	// search: draw search panel: 가축매몰지 - 연도
//	function drawSearchPanel5_year() {
//		var year = new autoInput();
//		
//		year.init({
//			id: 'search_bg_year',
//			type: 'select',
//			none: '연도',
//			page: 'gis1',
//			query: 15,
//			column: 'YEAR',
//			text: 'YEAR'
//		});
//		
//		year.query();
//	};
//	
//	// search: draw search panel: 가축매몰지 - 시도
//	function drawSearchPanel5_sido() {
//		var sido = new autoInput();
//		
//		sido.init({
//			id: 'search_bg_sido',
//			type: 'select',
//			none: '시도 선택',
//			page: 'gis1',
//			query: 3,
//			column: 'CODE',
//			text: 'NAME'
//		});
//		
//		sido.query();
//	};
//	
//	// search: draw search panel: 가축매몰지 - 시군구
//	function drawSearchPanel5_gu() {
//		$("#search_bg_sido").bind("change", function() {
//			var sidoVal = $("#search_bg_sido option:selected").val();
//			
//			if(sidoVal != "none") {
//				var gu = new autoInput();
//				
//				gu.init({
//					id: 'search_bg_gu',
//					type: 'select',
//					none: '시군구 선택',
//					page: 'gis1',
//					query: 4,
//					column: 'CODE',
//					text: 'NAME',
//					cond: [
//						{
//							col: 'sido',
//							val: sidoVal
//						}
//					]
//				});
//				
//				gu.query();
//			} else {
//				$("#search_bg_gu").val("none");
//				$("#search_bg_gu option[value!='none']").remove();
//			}
//		});
//	};
//	
//	// search: draw search panel: 가축매몰지 - 검색하기
//	function drawSearchPanel5_search() {
//		$("#search_btn_search5").bind("click", function() {
//			$("#mapControl7").trigger("click");
//			
//			var $year = $("#search_bg_year");
//			var $mod = $("#search_bg_mod");
//			var $start = $("#search_bg_start");
//			var $end = $("#search_bg_end");
//			var $sido = $("#search_bg_sido");
//			var $gu = $("#search_bg_gu");
//			var $addr = $("#search_bg_addr");
//			
//			var bgSearch = new autoInput();
//			
//			bgSearch.init({
//				id: 'resultBox',
//				type: 'markerTable',
//				page: 'gis1',
//				query: 16,
//				column: ['지점코드', '매몰년도', '매몰반기', '매몰시작일자', '매몰종료일자', '매몰축종', '매몰두수', '주소'],
//				columnW: ['55px', '55px', '55px', '75px', '75px', '55px', '55px', 'none'],
//				detail: false,
//				cond: [
//					{
//						col: 'year',
//						val: ($year.val() == "none") ? "" : $year.val()
//					},
//					{
//						col: 'mod',
//						val: ($mod.val() == "none") ? "" : $mod.val()
//					},
//					{
//						col: 'start',
//						val: ($start.val() == "none") ? "" : $start.val()
//					},
//					{
//						col: 'end',
//						val: ($end.val() == "none") ? "" : $end.val()
//					},
//					{
//						col: 'sido',
//						val: ($sido.val() == "none") ? "" : $sido.val()
//					},
//					{
//						col: 'gu',
//						val: ($gu.val() == "none") ? "" : $gu.val()
//					},
//					{
//						col: 'addr',
//						val: encodeURIComponent(encodeURIComponent($addr.val(), "UTF-8"))
//					}
//				],
//				mapManager: gis1MapManager
//			});
//			
//			bgSearch.query();
//		});
//	};
//	
//	// search: draw search panel: 가축매몰지 - 초기화
//	function drawSearchPanel5_reset() {
//		$("#search_btn_reset5").bind("click", function() {
//			$("#search_bg_year").val("none");
//			$("#search_bg_mod").val("none");
//			$("#search_bg_start").val("");
//			$("#search_bg_end").val("");
//			$("#search_bg_sido").val("none");
//			$("#search_bg_gu").val("none");
//			$("#search_bg_addr").val("");
//			
//			$("#search_bg_gu option[value!='none']").remove();
//			
//			$("#search_bg_year").attr("disabled", false);
//			$("#search_bg_mod").attr("disabled", false);
//			$("#search_bg_start").attr("disabled", false);
//			$("#search_bg_end").attr("disabled", false);
//			$("#search_bg_sido").attr("disabled", false);
//			$("#search_bg_gu").attr("disabled", false);
//			$("#search_bg_addr").attr("disabled", false);
//		});
//	};
//	
//	// search: draw search panel: 지하수관정
//	function drawSearchPanel6() {
//		// 시도, 시군구 -> 지점주소 x
//		$("#search_gw_sido").bind("change", function() {
//			var sido = $("#search_gw_sido option:selected").val();
//			
//			if(sido != "none") {
//				$("#search_gw_addr").attr("disabled", true);
//			}
//			else {
//				$("#search_gw_addr").attr("disabled", false);
//			}
//		});
//		
//		// 지점주소 -> 시도, 시군구 x
//		$("#search_gw_addr").bind("keydown", function() {
//			var addr = $("#search_gw_addr").val();
//			
//			if(addr != "") {
//				$("#search_gw_sido").attr("disabled", true);
//				$("#search_gw_gu").attr("disabled", true);
//			} else {
//				$("#search_gw_sido").attr("disabled", false);
//				$("#search_gw_gu").attr("disabled", false);
//			}
//		});
//		
//		// 이용용도
//		drawSearchPanel6_use();
//		
//		// 시도
//		drawSearchPanel6_sido();
//		
//		// 시군구
//		drawSearchPanel6_gu();
//		
//		// 검색하기
//		drawSearchPanel6_search();
//		
//		// 초기화
//		drawSearchPanel6_reset();
//	};
//	
//	// search: draw search panel: 지하수관정 - 이용용도
//	function drawSearchPanel6_use() {
//		var use = new autoInput();
//		
//		use.init({
//			id: 'search_gw_use',
//			type: 'select',
//			none: '이용용도 선택',
//			page: 'gis1',
//			query: 17,
//			column: 'CODE',
//			text: 'NAME'
//		});
//		
//		use.query();
//	};
//	
//	// search: draw search panel: 지하수관정 - 시도
//	function drawSearchPanel6_sido() {
//		var sido = new autoInput();
//		
//		sido.init({
//			id: 'search_gw_sido',
//			type: 'select',
//			none: '시도 선택',
//			page: 'gis1',
//			query: 3,
//			column: 'CODE',
//			text: 'NAME'
//		});
//		
//		sido.query();
//	};
//	
//	// search: draw search panel: 지하수관정 - 시군구
//	function drawSearchPanel6_gu() {
//		$("#search_gw_sido").bind("change", function() {
//			var sidoVal = $("#search_gw_sido option:selected").val();
//			
//			if(sidoVal != "none") {
//				var gu = new autoInput();
//				
//				gu.init({
//					id: 'search_gw_gu',
//					type: 'select',
//					none: '시군구 선택',
//					page: 'gis1',
//					query: 4,
//					column: 'CODE',
//					text: 'NAME',
//					cond: [
//						{
//							col: 'sido',
//							val: sidoVal
//						}
//					]
//				});
//				
//				gu.query();
//			} else {
//				$("#search_gw_gu").val("none");
//				$("#search_gw_gu option[value!='none']").remove();
//			}
//		});
//	};
//	
//	// search: draw search panel: 지하수관정 - 검색하기
//	function drawSearchPanel6_search() {
//		$("#search_btn_search6").bind("click", function() {
//			$("#mapControl7").trigger("click");
//			
//			var $use = $("#search_gw_use");
//			var $report = $("input:radio[name='search_gw_report']:checked");
//			var $sido = $("#search_gw_sido");
//			var $gu = $("#search_gw_gu");
//			var $addr = $("#search_gw_addr");
//			
//			var gwSearch = new autoInput();
//			
//			gwSearch.init({
//				id: 'resultBox',
//				type: 'markerTable',
//				page: 'gis1',
//				query: 18,
//				column: ['지점코드', '이용용도', '관정신고여부', '주소'],
//				columnW: ['60px', '100px', '80px', 'none'],
//				detail: false,
//				cond: [
//					{
//						col: 'use',
//						val: ($use.val() == "none") ? "" : $use.val()
//					},
//					{
//						col: 'report',
//						val: ($report.val() == "A") ? "" : $report.val()
//					},
//					{
//						col: 'sido',
//						val: ($sido.val() == "none") ? "" : $sido.val()
//					},
//					{
//						col: 'gu',
//						val: ($gu.val() == "none") ? "" : $gu.val()
//					},
//					{
//						col: 'addr',
//						val: encodeURIComponent(encodeURIComponent($addr.val(), "UTF-8"))
//					}
//				],
//				mapManager: gis1MapManager
//			});
//			
//			gwSearch.query();
//		});
//	};
//	
//	// search: draw search panel: 지하수관정 - 초기화
//	function drawSearchPanel6_reset() {
//		$("#search_btn_reset6").bind("click", function() {
//			$("#search_gw_use").val("none");
//			$("input[name='search_gw_report']").removeAttr("checked");
//			$("input[name='search_gw_report'][value='A']").prop('checked', true);
//			$("#search_gw_sido").val("none");
//			$("#search_gw_gu").val("none");
//			$("#search_gw_addr").val("");
//			
//			$("#search_gw_gu option[value!='none']").remove();
//			
//			$("#search_gw_use").attr("disabled", false);
//			$("#search_gw_report").attr("disabled", false);
//			$("#search_gw_sido").attr("disabled", false);
//			$("#search_gw_gu").attr("disabled", false);
//			$("#search_gw_addr").attr("disabled", false);
//		});
//	};
//	
//	// search: draw search panel: 실태조사지점
//	function drawSearchPanel7() {
//		// 시도, 시군구 -> 지점주소 x
//		$("#search_radioact_sido").bind("change", function() {
//			var sido = $("#search_radioact_sido option:selected").val();
//			
//			if(sido != "none") {
//				$("#search_radioact_addr").attr("disabled", true);
//			}
//			else {
//				$("#search_radioact_addr").attr("disabled", false);
//			}
//		});
//		
//		// 지점주소 -> 시도, 시군구 x
//		$("#search_radioact_addr").bind("keydown", function() {
//			var addr = $("#search_radioact_addr").val();
//			
//			if(addr != "") {
//				$("#search_radioact_sido").attr("disabled", true);
//				$("#search_radioact_gu").attr("disabled", true);
//			} else {
//				$("#search_radioact_sido").attr("disabled", false);
//				$("#search_radioact_gu").attr("disabled", false);
//			}
//		});
//		
//		// 굴착년도
//		drawSearchPanel7_digyear();
//		
//		// 조사년도
//		drawSearchPanel7_year();
//		
//		// 시도
//		drawSearchPanel7_sido();
//		
//		// 시군구
//		drawSearchPanel7_gu();
//		
//		// 검색
//		drawSearchPanel7_search();
//		
//		// 초기화
//		drawSearchPanel7_reset();
//	};
//	
//	// search: draw search panel: 실태조사지점 - 굴착년도
//	function drawSearchPanel7_digyear() {
//		var year = new autoInput();
//		
//		year.init({
//			id: 'search_radioact_digyear',
//			type: 'select',
//			none: '굴착년도 선택',
//			page: 'gis1',
//			query: 19,
//			column: 'YEAR',
//			text: 'YEAR'
//		});
//		
//		year.query();
//	};
//	
//	// search: draw search panel: 실태조사지점 - 조사년도
//	function drawSearchPanel7_year() {
//		var year = new autoInput();
//		
//		year.init({
//			id: 'search_radioact_year',
//			type: 'select',
//			none: '조사년도 선택',
//			page: 'gis1',
//			query: 24,
//			column: 'YEAR',
//			text: 'YEAR'
//		});
//		
//		year.query();
//	};
//	
//	// search: draw search panel: 실태조사지점 - 시도
//	function drawSearchPanel7_sido() {
//		var sido = new autoInput();
//		
//		sido.init({
//			id: 'search_radioact_sido',
//			type: 'select',
//			none: '시도 선택',
//			page: 'gis1',
//			query: 3,
//			column: 'CODE',
//			text: 'NAME'
//		});
//		
//		sido.query();
//	};
//	
//	// search: draw search panel: 실태조사지점 - 시군구
//	function drawSearchPanel7_gu() {
//		$("#search_radioact_sido").bind("change", function() {
//			var sidoVal = $("#search_radioact_sido option:selected").val();
//			
//			if(sidoVal != "none") {
//				var gu = new autoInput();
//				
//				gu.init({
//					id: 'search_radioact_gu',
//					type: 'select',
//					none: '시군구 선택',
//					page: 'gis1',
//					query: 4,
//					column: 'CODE',
//					text: 'NAME',
//					cond: [
//						{
//							col: 'sido',
//							val: sidoVal
//						}
//					]
//				});
//				
//				gu.query();
//			} else {
//				$("#search_radioact_gu").val("none");
//				$("#search_radioact_gu option[value!='none']").remove();
//			}
//		});
//	};
//	
//	// search: draw search panel: 실태조사지점 - 검색
//	function drawSearchPanel7_search() {
//		$("#search_btn_search7").bind("click", function() {
//			$("#mapControl7").trigger("click");
//			
//			var $year = $("#search_radioact_year");
//			var $digyear = $("#search_radioact_digyear");
//			var $use = $("input:radio[name='search_radioact_use']:checked");
//			var $sido = $("#search_radioact_sido");
//			var $gu = $("#search_radioact_gu");
//			var $addr = $("#search_radioact_addr");
//			
//			var radioactSearch = new autoInput();
//			
//			radioactSearch.init({
//				id: 'resultBox',
//				type: 'markerTable',
//				page: 'gis1',
//				query: 20,
//				column: ['지점코드', '지점명',  '굴착년도', '조사년도', '음용여부', '주소'],
//				columnW: ['60px', '70px', '55px', '55px', '55px', 'none'],
//				detail: true,
//				detailID: 'resultDetailBox',
//				detailColumn : ['지점코드', '지점명', '굴착년도', '조사년도', '음용여부', '심도', '사용인구', '사용량', '지질', '시료', '우라늄', '라돈', '전알파', '수온', 'PH', 'EH', 'EC', 'DO', '주소'],
//				
//				cond: [
//					{
//						col: 'year',
//						val: ($year.val() == "none") ? "" : $year.val()
//					},
//					{
//						col: 'digyear',
//						val: ($digyear.val() == "none") ? "" : $digyear.val()
//					},
//					{
//						col: 'use',
//						val: ($use.val() == "A") ? "" : encodeURIComponent(encodeURIComponent($use.val(), "UTF-8"))
//					},
//					{
//						col: 'sido',
//						val: ($sido.val() == "none") ? "" : $sido.val()
//					},
//					{
//						col: 'gu',
//						val: ($gu.val() == "none") ? "" : $gu.val()
//					},
//					{
//						col: 'addr',
//						val: encodeURIComponent(encodeURIComponent($addr.val(), "UTF-8"))
//					}
//				],
//				mapManager: gis1MapManager
//			});
//			
//			radioactSearch.query();
//		});
//	};
//	
//	// search: draw search panel: 실태조사지점 - 초기화
//	function drawSearchPanel7_reset() {
//		$("#search_btn_reset7").bind("click", function() {
//			$("#search_radioact_year").val("none");
//			$("#search_radioact_digyear").val("none");
//			$("input[id='search_radioact_use']").removeAttr("checked");
//			$("input[id='search_radioact_use'][value='A']").prop('checked', true);
//			$("#search_radioact_sido").val("none");
//			$("#search_radioact_gu").val("none");
//			$("#search_radioact_addr").val("");
//			
//			$("#search_radioact_gu option[value!='none']").remove();
//			
//			$("#search_radioact_year").attr("disabled", false);
//			$("#search_radioact_digyear").attr("disabled", false);
//			$("#search_radioact_use").attr("disabled", false);
//			$("#search_radioact_sido").attr("disabled", false);
//			$("#search_radioact_gu").attr("disabled", false);
//			$("#search_radioact_addr").attr("disabled", false);
//		});
//	};

	function addGraphic(geometry, obj) {
		tb.deactivate(); 
        sm.graphics.clear();
        gsvc = new esri.tasks.GeometryService(gsvcURL);
		
		if(sm.graphicsLayerIds.toString().indexOf('bufferSearch') == -1) {
			tgl = new esri.layers.GraphicsLayer({
				id: 'bufferSearch'
			});
	        sm.addLayer(tgl);
		} else {
			tgl.clear();
		}
		
		// 지도에서 선택
		if(obj.type == 'direct') {
			var tp1 = new esri.geometry.Point(geometry.paths[0][0], new esri.SpatialReference({ wkid:102113}));
			
    	    var lon = tp1.getLongitude();
			var lat = tp1.getLatitude();

			// hidden x, y input
			$("#" + obj.x).val(lon);
        	$("#" + obj.y).val(lat);
			
			// x, y input
			var lonA1 = parseInt(lon);
    		var lonB1 = (lon - lonA1) * 60;
    		var lonA2 = parseInt(lonB1); 
    		var lonA3 = (lonB1 - lonA2) * 60;
    		lonA3 = lonA3.toFixed(3);
    				
    		var latA1 = parseInt(lat);
    		var latB1 = (lat - latA1) * 60;
    		var latA2 = parseInt(latB1); 
    		var latA3 = (latB1 - latA2) * 60;
    		latA3 = latA3.toFixed(3);
        
            $("#" + obj.x1).val(lonA1);
            $("#" + obj.x2).val(lonA2);
            $("#" + obj.x3).val(lonA3);
            
            $("#" + obj.y1).val(latA1);
            $("#" + obj.y2).val(latA2);
            $("#" + obj.y3).val(latA3);
			
	        // line 
    	    var lineSymbol = new esri.symbol.CartographicLineSymbol(
    			esri.symbol.CartographicLineSymbol.STYLE_SOLID,
    			new dojo.Color([255,0,0]), 2, 
    			esri.symbol.CartographicLineSymbol.CAP_ROUND,
    			esri.symbol.CartographicLineSymbol.JOIN_MITER, 5
    		);
    		
            tgl.add(new esri.Graphic(geometry, lineSymbol));
			
			// length
			var lengthParams = new esri.tasks.LengthsParameters();
            lengthParams.polylines = [geometry];
            lengthParams.lengthUnit = esri.tasks.GeometryService.UNIT_KILOMETER;
            
            gsvc.lengths(lengthParams, function(r) {
				$("#" + obj.rh).val(r.lengths[0]);
                $("#" + obj.r).val(r.lengths[0].toFixed(3));
            
    			// circle
                var params = new esri.tasks.BufferParameters();
        		params.geometries  = [tp1];
        		params.distances = [r.lengths[0]];
        		params.unit = esri.tasks.GeometryService.UNIT_KILOMETER;
        		params.bufferSpatialReference = new esri.SpatialReference({wkid: 102100});
        		params.outSpatialReference = sm.spatialReference;
        		gsvc.buffer(params);
        		
        		dojo.connect(gsvc, "onBufferComplete", function(geometries) {
    				var symbol = new esri.symbol.SimpleFillSymbol(
    				    esri.symbol.SimpleFillSymbol.STYLE_SOLID, 
    				    new esri.symbol.SimpleLineSymbol("dashdot", 
    				    new dojo.Color([203, 137, 22]), 2), 
    				    new dojo.Color([203, 137, 22, 0.4])
    			    );
    				
    		        tgl.add(new esri.Graphic(geometries[0], symbol));
    	        });
			});
		} 
		
		// 직접 입력
		else {
			var tp1 = geometry.paths[0][0];
        	var tp2 = geometry.paths[0][1];
        			    			
    	    tp1 = new esri.geometry.Point([tp1[0], tp1[1]], new esri.SpatialReference({ wkid:4326}));
    	    tp2 = new esri.geometry.Point([tp2[0], tp2[1]], new esri.SpatialReference({ wkid:4326}));
    		
			// hidden x, y, r input
//			$("#" + obj.x).val(tp1.getLongitude());
//        	$("#" + obj.y).val(tp1.getLatitude());
//        	$("#" + obj.rh).val(obj.r);
			
			gsvc.project([tp1, tp2], new esri.SpatialReference({ wkid:102113}), function(projectedPoints) {
                pt = projectedPoints;
                
                tp1 = projectedPoints[0];
                tp2 = projectedPoints[1];
                
		        // line 
                var lineSymbol = new esri.symbol.CartographicLineSymbol(
        			esri.symbol.CartographicLineSymbol.STYLE_SOLID,
        			new dojo.Color([255,0,0]), 2, 
        			esri.symbol.CartographicLineSymbol.CAP_ROUND,
        			esri.symbol.CartographicLineSymbol.JOIN_MITER, 5
        		);
        		
        		geometry.removePath(0);
        		geometry.addPath([tp1, tp2]);
        		
                tgl.add(new esri.Graphic(geometry, lineSymbol));
                
                // circle
                var params = new esri.tasks.BufferParameters();
        		params.geometries  = [tp1];
        		params.distances = [obj.r];
        		params.unit = esri.tasks.GeometryService.UNIT_KILOMETER;
        		params.bufferSpatialReference = new esri.SpatialReference({wkid: 102100});
        		params.outSpatialReference = sm.spatialReference;
        		
        		gsvc.buffer(params, function(geometries) {
    				var symbol = new esri.symbol.SimpleFillSymbol(
    				    esri.symbol.SimpleFillSymbol.STYLE_SOLID, 
    				    new esri.symbol.SimpleLineSymbol("dashdot", 
    				    new dojo.Color([203, 137, 22]), 2), 
    				    new dojo.Color([203, 137, 22, 0.4])
    			    );
    				
    		        tgl.add(new esri.Graphic(geometries[0], symbol));
    		    });
            });
		}

	};
};