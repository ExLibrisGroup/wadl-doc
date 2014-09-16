function hideRows() {
	// parse the query-string tags param and hide rows that have a non-empty tag
	// indicator and doesn't include the tags provided
	// <tr data-tags="get post">

	// Getting URL var by its name - http://jquery-howto.blogspot.co.il/2009/09/get-url-parameters-values-with-jquery.html
	var tagsRequestedInUrl = jQuery.getUrlVar('tags');
	if (tagsRequestedInUrl) {
		jQuery('tr[data-tags]').each(
				function() {
					var elem = jQuery(this);
					// elem.css('color','#D0D0D0');
					var tags = elem.attr('data-tags');
					// alert (tags);
					if (tags.toLowerCase().indexOf(
							tagsRequestedInUrl.toLowerCase()) >= 0) {
						// the tr is relevant to tagsRequestedInUrl - it's OK -
						// do nothing.
					} else {
						elem.hide();
					}
				});
	} else {
		// alert ("No tags in the URL. Try adding ?tags=post");
	}
}
