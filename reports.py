from db import get_connection

def product_sales_report():
    product_id = int(input("Enter Product ID: "))

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("SELECT total_sales(%s)", (product_id,))
    total = cur.fetchone()[0]

    print(f"\nTotal Sales for Product {product_id}: ₹{total}")

def low_stock_alerts():
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("SELECT * FROM low_stock_alerts ORDER BY alert_time DESC")

    print("\n--- Low Stock Alerts ---")
    for row in cur.fetchall():
        print(row)

def report_menu():
    while True:
        print("\n--- Reports Menu ---")
        print("1. Total Sales (Using Function)")
        print("2. Low Stock Alerts (Event Based)")
        print("3. Back")

        ch = input("Enter choice: ")

        if ch == "1":
            product_sales_report()
        elif ch == "2":
            low_stock_alerts()
        elif ch == "3":
            break
        else:
            print("Invalid!")
