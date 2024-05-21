""""cart models"""
from django.core.exceptions import ValidationError
from django.db import models
from product.models import Product

# Create your models here.
class ShoppingCart(models.Model):
    """Shopping cart class"""
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    product_price = models.DecimalField(max_digits=10, decimal_places=2)
    quantity = models.PositiveIntegerField()

    def clean(self):
        """if the user trys to add more product than available raise error"""
        if self.quantity > self.product.stock:
            raise ValidationError("Quantity exceeds available stock.")

    def __str__(self):
        return f"{self.product} - {self.quantity}"
