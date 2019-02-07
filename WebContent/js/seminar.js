function fnInputCheck() {
	var form = document.educationInput;
	/*if(form.seminarTitle.value == null || form.seminarTitle.value.replace(/ /gi,"") == "") {
		alert("교육 제목을 입력해 주세요.");
		form.seminarTitle.focus();
		return false;
	}*/
	
	/*if(form.seminarCount.value == null || form.seminarCount.value.replace(/ /gi,"") == "") {
		alert("참여자 수를 입력해 주세요.");
		form.seminarCount.focus();
		return false;
	} else {
		var val = form.seminarCount.value;
		var re = /[^0-9|]/gi;
		if(re.test(val)) {
	        alert("참여자 수는 숫자만 가능 합니다.");
	        obj.focus();
	        return false;
	    } else {
	    	if(val <1 ) {
				alert("참여자 수는 1명 이상 입력해 주세요.");
				return false;
			}
	    }
	}*/
	
	/*if(form.seminarLectEmail.value == null || form.seminarLectEmail.value.replace(/ /gi,"") == "") {
		alert("이메일 주소를 입력해 주세요.");
		form.seminarLectEmail.focus();
		return false;
	} else {
		var val = form.seminarLectEmail.value;
		var bol = true;
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if (exptext.test(val)!=true){
		  alert('이메일 형식이 올바르지 않습니다.'); 
		  obj.focus();
		  return false;
		}
	}*/
	
	/*if(form.seminarPlace.value == null || form.seminarPlace.value.replace(/ /gi,"") == "") {
		alert("교육장소를 입력해 주세요.");
		form.seminarPlace.focus();
		return false;
	}*/
	
	/*if(form.seminarLectId.value == null || form.seminarLectId.value.replace(/ /gi,"") == "") {
		alert("담당자를 선택해 주세요.");
		form.seminarLectId.focus();
		return false;
	}
	
	if(form.seminarHost.value == null || form.seminarHost.value.replace(/ /gi,"") == "") {
		alert("주최를 입력해 주세요.");
		form.seminarHost.focus();
		return false;
	}*/
	
	/*if(form.eduDateFrom.value == null || form.eduDateFrom.value.replace(/ /gi,"") == "") {
		alert("교육기간을 선택해 주세요.");
		form.eduDateFrom.focus();
		return false;
	}
	
	if(form.eduDateTo.value == null || form.eduDateTo.value.replace(/ /gi,"") == "") {
		alert("교육기간을 선택해 주세요.");
		form.eduDateTo.focus();
		return false;
	}*/
	
	/*if(form.seminarTimeFrom.value > form.seminarTimeTo.value) {
		alert("교육 시간 선택이 잘못 되었습니다. \n\n다시 한번 확인 해 주세요.");
		form.seminarTimeFrom.focus();
		return false;
	}*/
	
	/*if(form.seminarEntryDateFrom.value == null || form.seminarEntryDateFrom.value.replace(/ /gi,"") == "") {
		alert("신청기간을 선택해 주세요.");
		form.seminarDateTo.focus();
		return false;
	}
	
	if(form.seminarEntryDateTo.value == null || form.seminarEntryDateTo.value.replace(/ /gi,"") == "") {
		alert("신청기간을 선택해 주세요.");
		form.seminarDateTo.focus();
		return false;
	}*/
	
	return true;
}