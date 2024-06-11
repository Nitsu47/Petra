import scrapy
from petra_scraping_web.items import PetraScrapingWebItem


class PetraSpider(scrapy.Spider):
    name = 'petrastore'
    allowed_domains = ['petrastore.com.uy']
    start_urls = ['https://petrastore.com.uy/coleccion']

    def parse(self, response):
        products = response.xpath('//*[@id="catalogoProductos"]/div')
        for product in products:
            ml_item = PetraScrapingWebItem()
            name = product.xpath('.//div/div/a/text()').get()
            img_url = product.xpath('.//div/a/img/@src').get()
            precio = product.xpath('.//div/div/div[@class="precios"]/strong/span[@class="monto"]/text()').get()
            
            ml_item['name'] = name
            ml_item['img_url'] = response.urljoin(img_url)
            ml_item['precio'] = precio
            yield ml_item
    
        total_pages = response.xpath('//*[@id="catalogoProductos"]/@data-totabs').get()
        if total_pages:
            total_pages = int(total_pages)
            for page in range(2, total_pages + 1):
                next_page_url = f'https://petrastore.com.uy/coleccion?js=1&pag={page}'
                yield scrapy.Request(url=next_page_url, callback=self.parse_more)

    def parse_more(self, response):
        products = response.xpath('//*[@id="catalogoProductos"]/div')
        for product in products:
            ml_item = PetraScrapingWebItem()
            name = product.xpath('.//div/div/a/text()').get()
            img_url = product.xpath('.//div/a/img/@src').get()
            precio = product.xpath('.//div/div/div[@class="precios"]/strong/span[@class="monto"]/text()').get()
            
            ml_item['name'] = name
            ml_item['img_url'] = response.urljoin(img_url)
            ml_item['precio'] = precio
            yield ml_item
 