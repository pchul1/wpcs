function dialogCustom(config) {
	var $obj = $("#" + config.id);
	
	var box = $obj.dialog({
		bgiframe: true,
		closeOnEscape: false,
//		draggable: true,
		autoOpen: config.autoOpen,
		resizable: config.resizable, 
		width: config.width,
		height: config.height,
		position: config.position,
		create: function(event, ui) {
			var $objP = $(this).parent();
			
			var $block = $obj.parent();
			var $none = $("#" + config.id + "None");
					
			// size
			$block.css({
				width: config.width,
				height: config.height
			});
						
			// title
			$objP.find('.ui-dialog-title').empty();
			$objP.find('.ui-dialog-title').append(config.title);
			
			// close
			if(!config.close)
				$objP.find('.ui-dialog-titlebar-close').css("display", "none");
				
			// display
			if(config.display) {
				// display btn img (title)
				$objP.find('.ui-dialog-titlebar-close').after("<div class='ui-dialog-display'></div>");
				
				// display btn click (title)
				$objP.find('.ui-dialog-display').bind("click", function() {
					$none.css({
						display: "block",
						left: $objP.css("left"),
						top: $objP.css("top")
					});
					
					$block.css({
						display: "none"
					});
				});
				
				// display btn drag, click (box)
				$none
					.draggable()
					.css({
						left: config.position[0],
						top: config.position[1]
					})
					.click(function() {
						if ($(this).is('.ui-draggable-dragging') ) {
			            	return;
			            }
						
						$none.css({
							display: "none"
						});
						
						$block.css({
							display: "block",
							left: $none.css("left"),
							top: $none.css("top")
						});
					});
			}
		},
		open: function(event, ui) {
			// open
			if(!config.open)
				config.open;
		}
	});
	
	return box;
}
