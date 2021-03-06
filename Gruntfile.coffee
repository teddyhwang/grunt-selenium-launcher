module.exports = (grunt)->

	grunt.registerTask 'drive', 'Drive webdriverjs on SELENIUM_LAUNCHER_PORT.', ->
		done = this.async()
		webdriver = require("selenium-webdriver")
		driver = new webdriver.Builder()
			.usingServer(process.env.SELENIUM_HUB)
			.withCapabilities(webdriver.Capabilities.firefox())
			.build()
		driver.get("http://www.google.com")
		driver.getTitle()
			.then (title)->
				title is "Google"
			.then (isTitle)->
				if not isTitle then grunt.log.error 'Incorrect title'
				driver.quit()
			.then done, done

	grunt.loadTasks './tasks'

	grunt.registerTask 'default', ['selenium-launch', 'drive']

	grunt.registerTask 'testExit', 'Launch a selenium server, end the process, and let the user check if it was closed.', ->
		grunt.log.warn 'Starting a selenium server, then exiting.\nCheck with `ps -a` that no java selenium processes are still running.\n'
		grunt.task.run ['selenium-launch']

	grunt.registerTask 'testInduceFailure', ->
		grunt.log.warn '''
			Run `SELENIUM_VERSION=2.32.0:BBADBEEF grunt testInduceFailure`
			to attempt starting an invalid selenium version.
			This will result in an error, triggering the error printing.
			Run with --force to continue other tests.
		'''
		grunt.task.run ['selenium-launch']
