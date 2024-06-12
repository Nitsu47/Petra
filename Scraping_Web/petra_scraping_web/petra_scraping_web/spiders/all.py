import scrapy
from petra_scraping_web.items import PetraScrapingWebItem
from scrapy.spiders import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor

class PetraSpider(CrawlSpider):
    name = 'petrastore'
    allowed_domains = ['petrastore.com.uy']
    start_urls = [f'https://petrastore.com.uy/coleccion?js=1&pag={page}' for page in range(1, 27)]
    custom_settings = {
        'DOWNLOAD_DELAY': 2,  # Agregar un retraso de 2 segundos entre las solicitudes
    }
    rules = (
        Rule(
            LinkExtractor(
                allow=(),
                restrict_xpaths=('//div[@id="catalogoProductos"]/div/div/a')
            ),
            callback='parse_item',
            follow=True
        ),
    )

    def parse_item(self, response):
        item = PetraScrapingWebItem()
        item["id"] = response.xpath('//div[@class="cod"]/text()').get()
        item["name"] = response.xpath('//h1/text()').get()
        item["precio"] = response.xpath('//div[@id="fichaProducto"]/div/div/div/strong/span[2]/text()').get()

        img_urls = response.xpath('//img/@data-src-g').getall()
        img_urls = [response.urljoin(url) for url in img_urls]

        item["img_url_1"] = img_urls[0] if len(img_urls) > 0 else None
        item["img_url_2"] = img_urls[1] if len(img_urls) > 1 else None
        item["img_url_3"] = img_urls[2] if len(img_urls) > 2 else None
        item["img_url_4"] = img_urls[3] if len(img_urls) > 3 else None
        item["img_url_5"] = img_urls[4] if len(img_urls) > 4 else None

        yield item
