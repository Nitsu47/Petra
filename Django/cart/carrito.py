class Carrito:
    def __init__(self, request):
        self.request = request
        self.session = request.session
        if "carrito" not in self.session:
            self.session["carrito"] = {}
        carrito = self.session["carrito"]
        if not carrito:
            self.session["carrito"] = {}
            self.carrito = self.session["carrito"]
        else:
            self.carrito = carrito
    
    def agregar(self, product):
        id = str(product.id)
        if id not in self.carrito.keys():
            self.carrito[id] = {
                "product_id": product.id,
                "product": product.name,
                "quantity": 1,
                "acumulado": product.price
            }
        else:
            self.carrito[id]["quantity"] += 1
            self.carrito[id]["acumulado"] += product.price
        self.save()
    
    def save(self):
        self.session["carrito"] = self.carrito
        self.session.modified = True
    
    def delete(self, product):
        id = str(product.id)
        if id in self.carrito:
            del self.carrito[id]
            self.save()
    
    def restar(self, product):
        id = str(product.id)
        if id in self.carrito.keys():
            self.carrito[id]["quantity"] -= 1
            self.carrito[id]["acumulado"] -= product.price
        if self.carrito[id]["quantity"] <= 0:
            del self.carrito[id]
        self.save()
    
    def clear(self):
        self.session["carrito"] = {}
        self.session.modified = True
        

