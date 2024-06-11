# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class PetraScrapingWebItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    name = scrapy.Field()
    img_url_1 = scrapy.Field()
    img_url_2 = scrapy.Field()
    img_url_3 = scrapy.Field()
    img_url_4 = scrapy.Field()
    img_url_5 = scrapy.Field()
    precio = scrapy.Field()
    id = scrapy.Field()
    avilables_sizes = scrapy.Field()
    pass
