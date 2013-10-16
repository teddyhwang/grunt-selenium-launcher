# grunt-selenium-launcher

A Grunt task to launch a selenium server.

## Usage

Load the task:

```javascript
grunt.loadNpmTasks('grunt-selenium-launcher');
```

Call the task:

```javascript
grunt.registerTask 'e2e-tests', [ 'selenium-launch', 'cucumberjs' ]
```

Use the settings exported to the environment to connect to the correct instance:

```javascript
var driver = new require("selenium-webdriver").Builder()
	.usingServer(process.env.SELENIUM_HUB)
	.withCapabilities(webdriver.Capabilities.firefox())
	.build()
```

## API

### Grunt Task

**selenium-launch**
Attempt to launch a selenium instance, binding to `process.env.SELENIUM_LAUNCHER_PORT`. If that port is unavailable, the launcher will iterate ports until it finds one available, and then resets `process.env.SELENIUM_LAUNCHER_PORT` to that. The task completes when the server is running and bound. The server is automatically killed when the grunt process exits - no need to take extreme steps to ensure the process isn't left a zombie.

### Environment Variables

**process.env.SELENIUM_LAUNCHER_PORT**
If set when running grunt, defines the preferred port to run Selenium on. After the task has run, has the value of the port selenium bound on.

**process.env.SELENIUM_HUB**
After the task has run, has the string URI for webdriver hub connection. Use this string when connecting clients to selenium.
