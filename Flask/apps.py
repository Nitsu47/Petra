#!/usr/bin/env python3
from flask import Flask, session, url_for, redirect, request, jsonify, render_template
from markupsafe import escape
import json


app = Flask(__name__)
app.secret_key = "Banana"

@app.route('/')
def home():
    with open('products.json', 'r') as f:
        data = json.load(f)
    return render_template('home.html', products=data)

@app.route("/carrito")
def carrito():
    if "cart" not in session:
        session["cart"] = [
            {
                "acumulado": 0,
                "productos": 0,
            },
            ]
    cart = session["cart"]
    return render_template('carrito.html', products=cart, resumen=cart[0])

@app.route("/añadir_al_carrito/<int:index>")
def añadir_al_carrito(index):
    with open('products.json', 'r') as f:
        data = json.load(f)
    product = data[index - 1]
    
    new_product = {
        "Nombre_Producto": product["Nombre_Producto"],
        "Color": product.get("Color"),
        "Talle": product.get("Talle"),
        "PRRECIO_IVA_INC": product["PRRECIO_IVA_INC"],
        "Cantidad": 1,
        "Stock": product["Stock"],
    }
    
    if "cart" not in session:
        session["cart"] = [{"acumulado": 0, "productos": 0}]
    
    product_found = False
    for item in session["cart"][1:]:
        if (
            item["Nombre_Producto"] == new_product["Nombre_Producto"]
            and item["Color"] == new_product["Color"]
            and item["Talle"] == new_product["Talle"]
        ):
            item["Cantidad"] += 1
            session["cart"][0]["acumulado"] += new_product.get("PRRECIO_IVA_INC")
            session["cart"][0]["productos"] += 1
            product_found = True
            break
    
    if not product_found:
        session["cart"].append(new_product)
        session["cart"][0]["acumulado"] += new_product["PRRECIO_IVA_INC"]
        session["cart"][0]["productos"] += 1
    
    session.modified = True
    return redirect(url_for('home'))

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
                if item.get("Cantidad") >= 2:
                    item["Cantidad"] -= 1
                else:
                    session["cart"].remove(item)
                session["cart"][0]["acumulado"] -= item.get("PRRECIO_IVA_INC")
                session["cart"][0]["productos"] -= 1
                break
    session.modified = True
    return redirect(url_for('carrito'))

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)