var seleniumLauncher = require('selenium-launcher');

module.exports = function(grunt){
	var selenium = null;

	var End = function(){
		if (selenium && selenium.kill) {
			selenium.kill();
		}
	}

	grunt.registerTask('seleniumLaunch', 'Start a selenium remote.', function(){
		done = this.async();
		seleniumLauncher(function(err, sel){
			selenium = sel;
			process.env.SELENIUM_LAUNCHER_PORT = selenium.port;
			done();
		});
	});

	grunt.registerTask('seleniumClose', 'Shut down any selenium that was started.', function(){
			End();
	});
};
