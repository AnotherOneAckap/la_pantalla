'use strict';

(function ( global ) {
		const debug = false;
		var w = {};

		w.element = document.querySelector('#time');

		w.render = function () {
			w.element.textContent = w.now.format('HH:mm');
		};

		w.run = function () {
			w.render();
			if ( w.onTick ) {
				w.onTick();
			}

			const delay = parseInt( global.params('delay') ) || 60;
			const step  = parseInt( global.params('step')  ) || null;

			// syncronize to 00 seconds
			const syncDelay = 1000 - w.now.milliseconds() + 1000 * ( delay == 60 ? delay - w.now.seconds() : 0 );

			if ( debug ) {
				console.log('Watch: started with delay=' + delay + ' step=' + step);
				console.log('Watch: syncDelay=' + syncDelay);
			}

			setTimeout( function () {
				w.render();

				w.interval = setInterval( function () {
					if ( debug ) console.log('Watch: tick ' + w.now.toISOString());

					let m = moment();

					if ( step ) {
						m = w.now.add( step, 'minutes' );
					}

					w.now = m;
					w.render();
					if ( w.onTick ) {
						w.onTick();
					}
				}, delay * 1000 );
			}, syncDelay );
		};

		global.watch = w;
})( window );
