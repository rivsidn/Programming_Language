from selenium import webdriver
from selenium.webdriver.common.keys import Keys



driver = webdriver.Firefox()
driver.get("https://www.baidu.com")

element = driver.find_element_by_name("wd")
element.clear()
element.send_keys("test")
element.send_keys(Keys.RETURN)


driver.close()

