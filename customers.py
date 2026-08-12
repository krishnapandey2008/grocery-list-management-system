from db import get_connection

def register_customer():
    name = input("Enter name: ")
    email = input("Enter email: ")
    password = input("Enter password: ")

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        INSERT INTO customers (name, email, password)
        VALUES (%s, %s, %s)
    """, (name, email, password))

    conn.commit()
    print("Customer registered successfully!\n")

def view_customers():
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("SELECT customer_id, name, email FROM customers")

    print("\n--- Customer List ---")
    for row in cur.fetchall():
        print(row)

def customer_menu():
    while True:
        print("\n--- Customer Menu ---")
        print("1. Register")
        print("2. View Customers")
        print("3. Back")

        ch = input("Enter choice: ")

        if ch == "1":
            register_customer()
        elif ch == "2":
            view_customers()
        elif ch == "3":
            break
        else:
            print("Invalid choice!")
