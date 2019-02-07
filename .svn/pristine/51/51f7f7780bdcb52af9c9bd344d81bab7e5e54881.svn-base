function fnTargetCheck(){
	var i = 0
	var sTargetMe = $("input:[name='sTargetMe[]']");
	$("input:[name='sChkMe[]']").each(
			function(){
				if(this.checked){
					sTargetMe[i].value="Y";
				}else{
					sTargetMe[i].value="N";
				}
				i++;
			}
	);
	
	
	i = 0
	var sTargetGov = $("input:[name='sTargetGov[]']");
	$("input:[name='sChkGov[]']").each(
			function(){
				if(this.checked){
					sTargetGov[i].value="Y";
				}else{
					sTargetGov[i].value="N";
				}
				i++;
			}
	);
	
	i = 0
	var sTargetKeco = $("input:[name='sTargetKeco[]']");
	$("input:[name='sChkKeco[]']").each(
			function(){
				if(this.checked){
					sTargetKeco[i].value="Y";
				}else{
					sTargetKeco[i].value="N";
				}
				i++;
			}
	);
	
	i = 0
	var sTargetArea = $("input:[name='sTargetArea[]']");
	
	$("input:[name='sChkArea[]']").each(
			function(){
				if(this.checked){
					sTargetArea[i].value="Y";
				}else{
					sTargetArea[i].value="N";
				}
				i++;
			}
	);
	
	i = 0
	var sTargetSigongsa = $("input:[name='sTargetSigongsa[]']");
	$("input:[name='sChkSigongsa[]']").each(
			function(){
				if(this.checked){
					sTargetSigongsa[i].value="Y";
				}else{
					sTargetSigongsa[i].value="N";
				}
				i++;
			}
	);
	
	i = 0
	var sTargetEtc = $("input:[name='sTargetEtc[]']");
	$("input:[name='sChkEtc[]']").each(
			function(){
				if(this.checked){
					sTargetEtc[i].value="Y";
				}else{
					sTargetEtc[i].value="N";
				}
				i++;
			}
	);
	
	var i = 0
	var gTargetMe = $("input:[name='gTargetMe[]']");
	$("input:[name='gChkMe[]']").each(
			function(){
				if(this.checked){
					gTargetMe[i].value="Y";
				}else{
					gTargetMe[i].value="N";
				}
				i++;
			}
	);
	
	
	i = 0
	var gTargetGov = $("input:[name='gTargetGov[]']");
	$("input:[name='gChkGov[]']").each(
			function(){
				if(this.checked){
					gTargetGov[i].value="Y";
				}else{
					gTargetGov[i].value="N";
				}
				i++;
			}
	);
	
	i = 0
	var gTargetKeco = $("input:[name='gTargetKeco[]']");
	$("input:[name='gChkKeco[]']").each(
			function(){
				if(this.checked){
					gTargetKeco[i].value="Y";
				}else{
					gTargetKeco[i].value="N";
				}
				i++;
			}
	);
	
	i = 0
	var gTargetArea = $("input:[name='gTargetArea[]']");
	
	$("input:[name='gChkArea[]']").each(
			function(){
				if(this.checked){
					gTargetArea[i].value="Y";
				}else{
					gTargetArea[i].value="N";
				}
				i++;
			}
	);
	
	i = 0
	var gTargetSigongsa = $("input:[name='gTargetSigongsa[]']");
	$("input:[name='gChkSigongsa[]']").each(
			function(){
				if(this.checked){
					gTargetSigongsa[i].value="Y";
				}else{
					gTargetSigongsa[i].value="N";
				}
				i++;
			}
	);
	
	i = 0
	var gTargetEtc = $("input:[name='gTargetEtc[]']");
	$("input:[name='gChkEtc[]']").each(
			function(){
				if(this.checked){
					gTargetEtc[i].value="Y";
				}else{
					gTargetEtc[i].value="N";
				}
				i++;
			}
	);
}

//숫자+소수점
function only_num_point(obj){
	var val = obj.value;
	
	var re = /[^0-9|.]/gi;
	
	obj.value = val.replace(re, '');
	
	var split = val.split(".");
	
	if(split.length > 2){	//콤마 1개 이상 못들어오도록
		obj.value = val.substr(0, val.length-1);
	}
	
	if(!(parseInt(obj.value)<100000)){	//값을 100000이하로 제한
		obj.value = val.substr(0, val.length-1);
	}
}
