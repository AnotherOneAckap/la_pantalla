'use strict';

( function ( global ) {
	const s = function () {
		this.currentTemplate = document.querySelector('#schedule-current-template').innerHTML;

		Mustache.parse(this.CurrentTemplate);
	};

	s.prototype.updateCurrent = function ( hall_id, data ) {
		document.querySelector('#schedule-hall-' + hall_id).innerHTML = data ? Mustache.render( this.currentTemplate, data ) : null;
	};

	window.Schedule = s;
} )( window );
