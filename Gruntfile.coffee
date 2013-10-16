module.exports = (grunt)->
	grunt.registerTask 'drive', 'Drive webdriverjs on SELENIUM_LAUNCHER_PORT.', ->
		done = this.async()
		grunt.log.write 'Driving\n'
		webdriver = require("selenium-webdriver")
		driver = new webdriver.Builder()
			.usingServer("http://localhost:#{process.env.SELENIUM_LAUNCHER_PORT}/wd/hub")
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
