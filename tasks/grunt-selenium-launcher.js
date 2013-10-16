var seleniumLauncher = require('selenium-launcher');

module.exports = function(grunt){
	var selenium = null;

	var End = function(){
		if (selenium && selenium.kill) {
			selenium.kill();
		}
	};

	// NO FULLY AUTOMATED TESTS FOR THIS
	// There is a semi-auto test via `grunt testExit`, but requires user confirmation.
	process.on('exit', End);

	grunt.registerTask('seleniumLaunch', 'Start a selenium remote.', function(){
		done = this.async();
		seleniumLauncher(function(err, sel){
			selenium = sel;
			process.env.SELENIUM_LAUNCHER_PORT = selenium.port
			process.env.SELENIUM_HUB = "http://localhost:" + process.env.SELENIUM_LAUNCHER_PORT + "/wd/hub"
			done();
		});
	});
};
