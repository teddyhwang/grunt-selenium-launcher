module.exports = (grunt)->
	grunt.registerTask 'drive', 'Drive webdriverjs on SELENIUM_LAUNCHER_PORT.', ->
		done = this.async()
		grunt.log.write 'Driving\n'
		webdriver = require("selenium-webdriver")
		driver = new webdriver.Builder()
			.usingServer(process.env.SELENIUM_HUB)
			.withCapabilities(webdriver.Capabilities.firefox())
			.build()
		grunt.log.write 'Have a driver\n'
		driver.get "http://www.google.com"
		driver.findElement(webdriver.By.name("q")).sendKeys "webdriver"
		driver.findElement(webdriver.By.name("btnG")).click()
		driver.getTitle().then (title) ->
			title is "webdriver - Google Search"
		.then (isTitle)->
			if not isTitle then grunt.log.error 'Incorrect title'
			grunt.log.write 'Shutting down\n'
			driver.quit().then done

	grunt.loadTasks './tasks'

	grunt.registerTask 'default', ['seleniumLaunch', 'drive', 'seleniumClose']

	grunt.registerTask 'testExit', 'Launch a selenium server, end the process, and let the user check if it was closed.', ->
		grunt.log.warn 'Starting a selenium server, then exiting.\nCheck with `ps -a` that no java selenium processes are still running.\n'
		grunt.task.run ['seleniumLaunch']

