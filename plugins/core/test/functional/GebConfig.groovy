driver = {
	def driver = new org.openqa.selenium.firefox.FirefoxDriver()
	def width = 1366
	def height = 768
	driver.navigate().to('http://localhost')
	driver.manage().window().setSize(new org.openqa.selenium.Dimension(width, height))
	return driver
}