#!/usr/bin/env python3
from flask import Flask, session, url_for, redirect, request, jsonify, render_template
from markupsafe import escape
import json
from flask_cors import CORS


app = Flask(__name__)
CORS(app)
app.secret_key = "Banana"

@app.route('/')
def home():
    with open('products.json', 'r') as f:
        data = json.load(f)
    return jsonify(data)

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
    return jsonify(cart)
    

@app.route("/añadir_al_carrito/<int:index>")
def añadir_al_carrito(index):
    with open('products.json', 'r') as f:
        data = json.load(f)
    product = data[index]
    
    new_product = {
        "name": product["name"],
        "precio": product["precio"],
        "Cantidad": 1,
    }
    
    if "cart" not in session:
        session["cart"] = [{"acumulado": 0, "productos": 0}]
    
    product_found = False
    for item in session["cart"][1:]:
        if (
            item["name"] == new_product["name"]
        ):
            item["Cantidad"] += 1
            session["cart"][0]["acumulado"] += int(new_product.get("precio").replace('.', ""))
            session["cart"][0]["productos"] += 1
            product_found = True
            break
    
    if not product_found:
        session["cart"].append(new_product)
        session["cart"][0]["acumulado"] += int(new_product["precio"].replace('.', ""))
        session["cart"][0]["productos"] += 1
    
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
    name = request.args.get("name")
    if "cart" in session:
        for item in session["cart"][1:]:
            if (
                item["name"] == name
            ):
                if item.get("Cantidad") >= 2:
                    item["Cantidad"] -= 1
                else:
                    session["cart"].remove(item)
                session["cart"][0]["acumulado"] -= int(item.get("precio").replace('.', ""))
                session["cart"][0]["productos"] -= 1
                break
    session.modified = True
    return redirect(url_for('carrito'))

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)
