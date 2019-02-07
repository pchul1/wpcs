var compatible = (document.getElementsByTagName && document.createElement);
	
if (compatible){
	document.write('<link rel="stylesheet" type="text/css" href="'+ROOT_PATH+'js/js_popup.css" />');
}

window.onload=function(){
	var newsList = document.getElementById('pop_news_con');
	var lists = newsList.getElementsByTagName('li');
	var listsP = newsList.getElementsByTagName('p');
	var listsLength = lists.length;
	var listsPLength = listsP.length;

	function allCloseList(){
		for (var i = 0; i < listsLength; i++){
			lists[i].className = 'listClose';
		}
	}

	for (var j = 0; j < listsPLength; j++){
		if (listsP[j].className == 'tit') {
			listsP[j].onclick = function(){
				allCloseList()
				this.parentNode.parentNode.parentNode.className = 'listOpen'
			}
		}
	}
}