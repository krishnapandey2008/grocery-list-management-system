from db import get_connection

def place_order():
    customer_id = int(input("Customer ID: "))
    product_id = int(input("Product ID: "))
    qty = int(input("Quantity: "))

    conn = get_connection()
    cur = conn.cursor()

    try:
        cur.callproc("place_order", (customer_id, product_id, qty))
        conn.commit()
        print("Order placed successfully!")

    except mysql.connector.Error as err:
        print("Error:", err.msg)

def view_orders():
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT order_id, customer_id, total_amount, status, order_date
        FROM orders
        ORDER BY order_id DESC
    """)

    print("\n--- Orders ---")
    for row in cur.fetchall():
        print(row)

def order_menu():
    while True:
        print("\n--- Order Menu ---")
        print("1. Place Order")
        print("2. View Orders")
        print("3. Back")

        ch = input("Enter choice: ")

        if ch == "1":
            place_order()
        elif ch == "2":
            view_orders()
        elif ch == "3":
            break
        else:
            print("Invalid!")
