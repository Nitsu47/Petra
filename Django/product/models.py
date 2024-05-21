"""product models"""
from django.db import models
from django.utils.text import slugify

# Create your models here.
class Product(models.Model):
    """Product class"""
    name = models.CharField(max_length=45)
    category = models.CharField(max_length=45)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    material = models.CharField(max_length=45)
    size = models.CharField(max_length=45)
    stock = models.PositiveIntegerField()
    slug = models.SlugField()

    def __str__(self):
        return f"{self.name} - {self.category} - {self.size}"
