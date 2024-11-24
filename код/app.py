from flask import Flask, render_template, request, jsonify, redirect
import mysql.connector

app = Flask(__name__)

# Підключення до бази даних
mydb = mysql.connector.connect(
    host="localhost", user="root", password="admin", database="medical_clinic_database"
)
cursor = mydb.cursor()


# Головна сторінка зі списком лікарів
@app.route("/", methods=["GET", "POST"])
def doctors_list():
    with mydb.cursor() as cursor:
        cursor.execute("SELECT COUNT(*) FROM medicalrecords")
        total_medical_records = cursor.fetchone()[0]

        cursor.execute("SELECT COUNT(*) FROM patients")
        total_patients = cursor.fetchone()[0]

        cursor.execute("SELECT * FROM doctors")
        doctors = cursor.fetchall()

    return render_template(
        "dashboard.html",
        doctors=doctors,
        total_medical_records=total_medical_records,
        total_patients=total_patients,
    )


# Сторінка для додавання нового пацієнта
@app.route("/patients", methods=["GET", "POST"])
def patients_list():
    cursor.execute("SELECT * FROM patients")

    patients = cursor.fetchall()
    return render_template("patients.html", patients=patients)


@app.route("/add_patient", methods=["GET", "POST"])
def add_patient():
    if request.method == "POST":
        first_name = request.form["first_name"]
        last_name = request.form["last_name"]
        email = request.form["email"]

        with mydb.cursor() as cursor:
            # Вставка нового пацієнта в таблицю patients
            sql = (
                "INSERT INTO patients (FirstName, LastName, Email) VALUES (%s, %s, %s)"
            )
            cursor.execute(sql, (first_name, last_name, email))
            mydb.commit()

        return redirect("/patients")
    return render_template("patients.html")


@app.route("/get_patient_data/<int:patient_id>")
def get_patient_data(patient_id):
    # Виконання запиту до бази даних для отримання даних пацієнта за його ID
    cursor = mydb.cursor()
    cursor.execute("SELECT * FROM patients WHERE PatientID = %s", (patient_id,))
    patientdata = cursor.fetchone()
    cursor.close()

    # Перевірка, чи знайдено дані пацієнта за його ID
    if patientdata:
        # Якщо дані знайдено, створення словника з необхідними даними
        patient = {
            "id": patientdata[0],
            "first_name": patientdata[1],
            "last_name": patientdata[2],
            "email": patientdata[3],
            # Додайте інші дані пацієнта за необхідності
        }
        # Повернення даних у форматі JSON
        return jsonify(patient)
    else:
        # Якщо дані не знайдено, повернення порожнього словника
        return jsonify({})


@app.route("/update_patient/<int:patient_id>", methods=["POST"])
def update_patient(patient_id):
    if request.method == "POST":
        # Отримання даних з форми редагування пацієнта
        updated_data = request.json

        # Оновлення запису про пацієнта з використанням отриманих даних
        cursor = mydb.cursor()
        update_query = "UPDATE patients SET FirstName = %s, LastName = %s, Email = %s WHERE PatientID = %s"
        cursor.execute(
            update_query,
            (
                updated_data["first_name"],
                updated_data["last_name"],
                updated_data["email"],
                patient_id,
            ),
        )
        mydb.commit()
        cursor.close()

        # Повернення успішної відповіді (можна також повернути підтвердження успішного оновлення)
        return jsonify({"message": "Дані пацієнта оновлено успішно"})
    else:
        # Якщо метод не є POST, повернення помилки
        return jsonify({"error": "Метод не підтримується для даного маршруту"}), 405


@app.route("/records", methods=["GET", "POST"])
def records_tables_print():
    with mydb.cursor() as cursor:
        # Змінений запит SQL з JOIN для отримання інформації про лікаря та пацієнта
        cursor.execute(
            """
            SELECT ar.AppointmentID, ar.AppointmentDate,
            CONCAT(d.FirstName, ' ', d.LastName) AS DoctorName,
            CONCAT(p.FirstName, ' ', p.LastName) AS PatientName
            FROM appointmentregistration ar
            LEFT JOIN doctors d ON ar.DoctorID = d.DoctorID
            LEFT JOIN patients p ON ar.PatientID = p.PatientID
        """
        )
        appointmentregistrations = cursor.fetchall()

        cursor.execute("SELECT * FROM medicalrecords")
        medicalrecords = cursor.fetchall()
    return render_template(
        "records.html",
        appointmentregistrations=appointmentregistrations,
        medicalrecords=medicalrecords,
    )


@app.route("/pharmacy_table")
def display_pharmacy_table():
    cursor = mydb.cursor()
    cursor.execute("SELECT * FROM pharmacy")
    pharmacy_data = cursor.fetchall()
    return render_template("pharmacy.html", pharmacy_data=pharmacy_data)


@app.route("/finances", methods=["GET", "POST"])
def finances():
    # Отримати дані про транзакції з бази даних
    cursor.execute("SELECT * FROM finances")
    finances = cursor.fetchall()
    return render_template("finances.html", finances=finances)


@app.route("/finances_delete", methods=["POST"])
def delete_finance():
    transaction_id = request.form.get("transaction_id")
    action = request.form.get("action")

    if action == "delete":
        delete_query = "DELETE FROM finances WHERE TransactionID = %s"
        cursor.execute(delete_query, (transaction_id,))
        mydb.commit()
        message = f"Видалено транзакцію №{transaction_id}"
        return jsonify({"message": message})


@app.route("/store", methods=["GET"])
def store():
    # Отримання категорій з бази даних
    cursor.execute("SELECT id, name FROM categories")
    categories = cursor.fetchall()

    # Отримання всіх товарів для початкового завантаження сторінки
    cursor.execute(
        "SELECT MedicineID, photo, MedicineName, description, price FROM pharmacy"
    )
    products = cursor.fetchall()

    return render_template("store.html", categories=categories, products=products)


@app.route("/product_details", methods=["GET"])
def product_details():
    product_id = request.args.get("product_id")
    cursor.execute(
        "SELECT MedicineID, MedicineName, photo, description, ingredients, price FROM pharmacy WHERE MedicineID = %s",
        (product_id,),
    )
    product = cursor.fetchone()
    if product:
        return jsonify(
            {
                "MedicineID": product[0],
                "MedicineName": product[1],
                "photo": product[2],
                "description": product[3],
                "ingredients": product[4],
                "price": product[5],
            }
        )
    return jsonify({"error": "Препарат не знайдено"}), 404


@app.route("/store_search", methods=["GET"])
def store_search():
    query = request.args.get("query", "").lower()
    categories = request.args.get("categories", "").split(",")

    # Базовий SQL запит
    sql = """
        SELECT photo, MedicineName, description, price 
        FROM pharmacy 
        WHERE (LOWER(MedicineName) LIKE %s OR LOWER(ingredients) LIKE %s)
    """
    params = [f"%{query}%", f"%{query}%"]

    # Додаємо умову для категорій, тільки якщо вони вибрані
    if categories and categories[0]:  # Перевіряємо, що список не пустий
        category_placeholders = ",".join(["%s"] * len(categories))
        sql += f" AND category_id IN ({category_placeholders})"
        params.extend(categories)

    cursor.execute(sql, params)
    products = cursor.fetchall()

    return jsonify(
        {
            "products": [
                {
                    "photo": product[0],
                    "MedicineName": product[1],
                    "description": product[2],
                    "price": product[3],
                }
                for product in products
            ]
        }
    )


@app.route("/cart", methods=["GET"])
def cart():
    return render_template("cart.html")


@app.route("/process_order", methods=["POST"])
def process_order():
    data = request.json
    customer_name = data.get("name", "").strip()
    customer_surname = data.get("surname", "").strip()
    phone = data.get("phone", "").strip()
    email = data.get("email", "").strip()
    cart = data.get("cart", [])
    total_amount = data.get("totalAmount", 0)

    # Перевірка полів клієнта
    if not customer_name or not customer_surname or not phone or not email:
        return jsonify({"success": False, "error": "Неповні дані клієнта"})

    if not isinstance(cart, list):
        return jsonify({"success": False, "error": "Невірний формат кошика"})

    cursor = mydb.cursor()

    try:
        # Вставляємо замовлення
        insert_order = """
        INSERT INTO orders (customer_name, customer_surname, phone, email, total_amount)
        VALUES (%s, %s, %s, %s, %s)
        """
        cursor.execute(
            insert_order, (customer_name, customer_surname, phone, email, total_amount)
        )
        order_id = cursor.lastrowid

        # Перевіряємо товари у кошику
        for item in cart:
            try:
                medicine_id = int(item.get("id", 0))  # Перетворення ID у число
                quantity = int(
                    item.get("quantity", 0)
                )  # Перетворення кількості у число

                if medicine_id <= 0:
                    raise ValueError(f"Некоректний ID товару: {medicine_id}")

                if quantity <= 0:
                    raise ValueError(f"Некоректна кількість товару: {quantity}")

                # Вставляємо товар до таблиці order_items
                insert_item = """
                INSERT INTO order_items (order_id, medicine_id, quantity)
                VALUES (%s, %s, %s)
                """
                cursor.execute(insert_item, (order_id, medicine_id, quantity))
            except ValueError as e:
                return jsonify({"success": False, "error": str(e)})

        mydb.commit()
        return jsonify({"success": True})
    except Exception as e:
        mydb.rollback()
        print("Помилка:", e)
        return jsonify({"success": False, "error": str(e)})
    finally:
        cursor.close()


@app.route("/checkout", methods=["GET"])
def checkout():
    return render_template("checkout.html")


@app.route("/thank_you", methods=["GET"])
def thank_you():
    return render_template("thank_you.html")


# Запуск додатку
if __name__ == "__main__":
    app.run(debug=True)
