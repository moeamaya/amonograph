// Wheelzoom 1.1.2
// (c) 2012 jacklmoore.com | license: www.opensource.org/licenses/mit-license.php
!function($){
	var transparentPNG = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAACklEQVR4nGMAAQAABQABDQottAAAAABJRU5ErkJggg==";
	var defaults = {
		zoom: 0.10,
		size: 1.0,
		x: 0.5,
		y: 0.5
	};
	var wheel;

	if ( document.onmousewheel !== undefined ) { // Webkit/Opera/IE
		wheel = 'onmousewheel';
	}
	else if ( document.onwheel !== undefined) { // FireFox 17+
		wheel = 'onwheel';
	}

	$.fn.wheelzoom = function(options){
		var settings = $.extend({}, defaults, options);

		if (!this[0] || !wheel || !('backgroundSize' in this[0].style)) { // IE8-
			return this;
		}

		return this.each(function(){
			var img = this,
				$img = $(img);

			function loaded() {
				var width = $img.width(),
					height = $img.height(),
					bgWidth = width,
					bgHeight = height,
					bgPosX = 0,
					bgPosY = 0,
					offsetBorderX = parseInt($img.css('border-left-width'),10),
					offsetBorderY = parseInt($img.css('border-top-width'),10),
					offsetPaddingX = parseInt($img.css('padding-left'),10),
					offsetPaddingY = parseInt($img.css('padding-top'),10);

				function reset() {
					bgWidth = width;
					bgHeight = height;
					bgPosX = bgPosY = 0;
					updateBgStyle();
				}

				function updateBgStyle() {
					if (bgPosX > 0) {
						bgPosX = 0;
					} else if (bgPosX < width - bgWidth) {
						bgPosX = width - bgWidth;
					}

					if (bgPosY > 0) {
						bgPosY = 0;
					} else if (bgPosY < height - bgHeight) {
						bgPosY = height - bgHeight;
					}

					img.style.backgroundSize = bgWidth + 'px ' + bgHeight + 'px';
					img.style.backgroundPosition = (bgPosX+offsetPaddingX) + 'px ' + (bgPosY+offsetPaddingY) + 'px';
				}

				// Set initializer variables
				bgWidth = bgWidth * settings.size;
				bgHeight = bgHeight * settings.size;
				bgPosX = (width/2) - (bgWidth * settings.x);
				bgPosY = (height/2) - (bgHeight * settings.y);

				// Check if position coord at edge of image
				bgPosX = bgPosX < 0 ? bgPosX : 0;
				bgPosY = bgPosY < 0 ? bgPosY : 0;

				// set background image to preset dimesions and position
				$img.css({
					background: "url("+img.src+") 0 0 no-repeat",
					backgroundSize: bgWidth+'px ' + bgHeight+'px',
					backgroundPosition: (bgPosX+offsetPaddingX)+'px ' + (bgPosY+offsetPaddingY)+'px'
				}).bind('wheelzoom.reset', reset);

				// Explicitly set the size to the current dimensions,
				// as the src is about to be changed to a 1x1 transparent png.
				img.width = img.width || img.naturalWidth;
				img.height = img.height || img.naturalHeight;
				img.src = transparentPNG;

				// initializer variable set to 1 once wheelzoom fires
				var first = 0;

				img[wheel] = function (e) {
					//
					// Super bad hack to close scroll-to-zoom hint
					//
					if (first === 0) {
						$('.scroll-to-zoom').fadeOut();
						first = 1;
					};

					var deltaY = 0;

					e.preventDefault();

					if (e.deltaY) { // FireFox 17+
						deltaY = e.deltaY;
					} else if (e.wheelDelta) {
						deltaY = -e.wheelDelta;
					}

					// As far as I know, there is no good cross-browser way to get the cursor position relative to the event target.
					// We have to calculate the target element's position relative to the document, and subtrack that from the
					// cursor's position relative to the document.
					var offsetParent = $img.offset();
					var offsetX = e.pageX - offsetParent.left - offsetBorderX - offsetPaddingX;
					var offsetY = e.pageY - offsetParent.top - offsetBorderY - offsetPaddingY;

					// Record the offset between the bg edge and cursor:
					var bgCursorX = offsetX - bgPosX;
					var bgCursorY = offsetY - bgPosY;

					// Use the previous offset to get the percent offset between the bg edge and cursor:
					var bgRatioX = bgCursorX/bgWidth;
					var bgRatioY = bgCursorY/bgHeight;

					// Update the bg size:
					if (deltaY < 0) {
						bgWidth += bgWidth*settings.zoom;
						bgHeight += bgHeight*settings.zoom;
					} else {
						bgWidth -= bgWidth*settings.zoom;
						bgHeight -= bgHeight*settings.zoom;
					}

					// Take the percent offset and apply it to the new size:
					bgPosX = offsetX - (bgWidth * bgRatioX);
					bgPosY = offsetY - (bgHeight * bgRatioY);

					// Prevent zooming out beyond the starting size
					if (bgWidth <= width || bgHeight <= height) {
						reset();
					} else {
						updateBgStyle();
					}
				};

				// Make the background draggable
				img.onmousedown = function(e){
					var last = e;

					e.preventDefault();

					function drag(e) {
						e.preventDefault();
						bgPosX += (e.pageX - last.pageX);
						bgPosY += (e.pageY - last.pageY);
						last = e;
						updateBgStyle();
					}

					$(document)
					.on('mousemove', drag)
					.one('mouseup', function () {
						$(document).unbind('mousemove', drag);
					});
				};
			}

			if (img.complete) {
				loaded();
			} else {
				$img.one('load', loaded);
			}

		});
	};

	$.fn.wheelzoom.defaults = defaults;

}(window.jQuery);