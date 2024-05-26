#!/usr/bin/env python3
from flask import Flask, session, url_for, redirect, request
from markupsafe import escape
import json


app = Flask(__name__)
app.secret_key = "Banana"

product = {
   "Nombre_Producto": "Top Volare",
   "Color": "Negro lurex",
   "Talle": "Talle Unico",
   "PRRECIO_IVA_INC": 3990,
   "Stock_Deposito": 2,
   "Stock": 2
  }

@app.route("/")
def carrito():
    if "cart" not in session:
        session["cart"] = [
            {
                "acumulado": 0,
                "productos": 0,
            },
            ]
    cart = session["cart"]
    return f"Cart: {cart}"

@app.route("/añadir_al_carrito")
def añadir_al_carrito():
    new_product = {"Nombre_Producto": product["Nombre_Producto"],
                   "Color": product.get("Color"),
                   "Talle": product.get("Talle"),
                   "PRRECIO_IVA_INC": product["PRRECIO_IVA_INC"],
                   "Cantidad": 1,
                   "Stock": product["Stock"],
                   }
    if "cart" not in session:
        session["cart"] = [
            {
                "acumulado": 0,
                "productos": 0,
            },
            ]
    product_found = False
    for item in session["cart"][1:]:
        if (
            item["Nombre_Producto"] == new_product["Nombre_Producto"]
            and item["Color"] == new_product["Color"]
            and item["Talle"] == new_product["Talle"]
        ):
            item["Cantidad"] += 1
            product_found = True
            break
    if not product_found:
        session["cart"].append(new_product)
    session.modified = True
    return redirect(url_for('carrito'))

@app.route("/vaciar_carrito")
def vaciar_carrito():
    if "cart" in session:
        session["cart"] = [
            {
                "acumulado": 0,
                "productos": 0,
            },
            ]
    session.modified = True
    return redirect(url_for('carrito'))

@app.route("/eliminar_producto", methods=['GET'])
def eliminar_producto():
    Nombre_Producto = request.args.get("Nombre_Producto")
    Color = request.args.get("Color")
    Talle = request.args.get("Talle")
    if "cart" in session:
        for item in session["cart"][1:]:
            if (
                item["Nombre_Producto"] == Nombre_Producto
                and item["Color"] == Color
                and item["Talle"] == Talle
            ):
                if item.get("Cantidad", 0) < 2:
                    session["cart"].remove(item)
                elif item.get("Cantidad", 0) >= 2:
                    item["Cantidad"] -= 1
                break
    session.modified = True
    return redirect(url_for('carrito'))

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)