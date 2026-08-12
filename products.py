from db import get_connection

def add_product():
    name = input("Product name: ")
    price = float(input("Price: "))
    qty = int(input("Quantity: "))

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        INSERT INTO products (name, price, total_quantity, available_quantity)
        VALUES (%s, %s, %s, %s)
    """, (name, price, qty, qty))

    conn.commit()
    print("Product added!")

def list_products():
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("SELECT * FROM product_with_category")

    print("\n--- Products ---")
    for row in cur.fetchall():
        print(row)

def product_menu():
    while True:
        print("\n--- Product Menu (Admin) ---")
        print("1. Add Product")
        print("2. View Products")
        print("3. Back")

        ch = input("Enter choice: ")

        if ch == "1":
            add_product()
        elif ch == "2":
            list_products()
        elif ch == "3":
            break
        else:
            print("Invalid!")
