$(document).ready(function(){
	var colorCount = 0
	var maxColorsCount = 5
	function colorDiv(id){
		return ("<div id='palette_" + id + "' hex='" + id + "' class='left' style='cursor: pointer; width: 33%; visibility: visible; zoom: 1; opacity: 1;'><input type='hidden' name='photo[color_attributes][][hex]' value='" + id + "'><div title='#" + id + "' class='palette_item' style='background-color: #" + id + ";'></div></div>") 
	};

	$("div.smallbox").on("mouseover", function(e){
		$(this).css("opacity", 0.7)
	});

	$("div.smallbox").on("mouseout", function(e){
		$(this).css("opacity", 1)
	});

	$("div.smallbox").on("click", function(e){
		var self = $(this) 
		var boxId = (self.attr('id'))
		if (self.hasClass("selected")) {
			$('#color_palette_tr #palette_' + boxId ).remove()
			self.removeClass("selected");
			colorCount -= 1;
		}else{
			if (colorCount < maxColorsCount) {
				self.addClass("selected");
				$('#color_palette_tr').append(colorDiv(boxId))
				colorCount += 1;
			}else{
				alert("You can choose at most " + maxColorsCount + " colors");
			}
		}
	});


});