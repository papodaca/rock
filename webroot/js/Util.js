define([], function() {
	return {
		'contains': function(s, subS) {
			if (s.indexOf(subS) !== -1) {
				return true;
			} else {
				return false;
			}
		}
	};
});