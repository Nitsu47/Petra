import scrapy
from petra_scraping_web.items import PetraScrapingWebItem
from scrapy.spiders import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor


class PetraSpider(CrawlSpider):
    name = 'petrastore'
    allowed_domains = ['petrastore.com.uy']
    start_urls = ['https://petrastore.com.uy/coleccion']
    rules = (
        Rule(
            LinkExtractor(
                allow=(),
                restrict_xpaths=('//*[@id="catalogoProductos"]/div/div/a')
            ),
            callback='parse_item'
        ),
    )

    def parse_item(self, response):
        item = PetraScrapingWebItem()
        item["id"] = response.xpath('//div[@class="cod"]/text()').get()
        item["name"] = response.xpath('//h1/text()').get()
        item["precio"] = response.xpath('//*[@id="fichaProducto"]/div/div/div/strong/span[2]/text()').get()
        
        item["img_url_1"] = response.urljoin(response.xpath('//*[@id="imagenes"]/div[2]/div[1]/div/div[1]/div/img/@src').get())
        item["img_url_2"] = response.urljoin(response.xpath('//*[@id="imagenes"]/div[2]/div[1]/div/div[2]/div/img/@src').get())
        item["img_url_3"] = response.urljoin(response.xpath('//*[@id="imagenes"]/div[2]/div[1]/div/div[3]/div/img/@src').get())
        item["img_url_4"] = response.urljoin(response.xpath('//*[@id="imagenes"]/div[2]/div[1]/div/div[4]/div/img/@src').get())
        item["img_url_5"] = response.urljoin(response.xpath('//*[@id="imagenes"]/div[2]/div[1]/div/div[5]/div/img/@src').get())
        
        yield item
