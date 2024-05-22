from django.test import RequestFactory, TestCase
from django.contrib.sessions.middleware import SessionMiddleware
from product.models import Product
from .carrito import Carrito

class CarritoTestCase(TestCase):
    def setUp(self):
        self.factory = RequestFactory()
        self.producto1 = Product.objects.create(name="Producto 1", price=10.0, stock=5)
        self.producto2 = Product.objects.create(name="Producto 2", price=20.0, stock=10)

    def iniciar_sesion(self):
        request = self.factory.get('/')
        middleware = SessionMiddleware(lambda request: None)  # Proporciona una función lambda simple
        middleware.process_request(request)
        request.session.save()
        return request

    def test_agregar_producto(self):
        request = self.iniciar_sesion()
        carrito = Carrito(request)
        carrito.agregar(self.producto1)
        
        self.assertEqual(len(carrito.carrito), 1)
        self.assertIn(str(self.producto1.id), carrito.carrito)
        self.assertEqual(carrito.carrito[str(self.producto1.id)]['quantity'], 1)

    def test_agregar_multiples_productos(self):
        request = self.iniciar_sesion()
        carrito = Carrito(request)
        carrito.agregar(self.producto1)
        carrito.agregar(self.producto2)

        self.assertEqual(len(carrito.carrito), 2)
        self.assertIn(str(self.producto1.id), carrito.carrito)
        self.assertIn(str(self.producto2.id), carrito.carrito)
        self.assertEqual(carrito.carrito[str(self.producto1.id)]['quantity'], 1)
        self.assertEqual(carrito.carrito[str(self.producto2.id)]['quantity'], 1)
