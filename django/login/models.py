"""models file"""
from django.db import models

# Create your models here.
class UserData(models.Model):
    """user class"""
    name = models.CharField(max_length=45)
    password = models.CharField(max_length=45)
    email = models.CharField(max_length=256)

    def __str__(self) -> str:
        return self.name


class Product(models.Model):
    """product class"""
    type = models.CharField(max_length=45)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    material = models.CharField(max_length=45)
    size = models.CharField(max_length=45)
    stock = models.PositiveIntegerField()

    def __str__(self):
        return f"{self.type} - {self.material} - {self.size}"


class ShoppingCart(models.Model):
    """shopping cart class"""
    user = models.ForeignKey(UserData, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    product_price = models.DecimalField(max_digits=10, decimal_places=2)
    quantity = models.PositiveIntegerField()

    def __str__(self):
        return f"{self.user.name} - {self.product.type} - {self.quantity}"


class Stock(models.Model):
    """"stock class"""
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    updated_at = models.DateTimeField(auto_now=True)
    stock_quantity = models.PositiveIntegerField()

    def __str__(self):
        return f"Stock for {self.product.type} - Quantity: {self.stock_quantity}"
