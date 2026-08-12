from customers import customer_menu
from products import product_menu
from orders import order_menu
from reports import report_menu

def main():
    while True:
        print("\n====== Grocery Shopping CLI ======")
        print("1. Customer Menu")
        print("2. Product Menu (Admin)")
        print("3. Order Menu")
        print("4. Reports (Admin)")
        print("5. Exit")

        choice = input("Enter choice: ")

        if choice == "1":
            customer_menu()
        elif choice == "2":
            product_menu()
        elif choice == "3":
            order_menu()
        elif choice == "4":
            report_menu()
        elif choice == "5":
            print("Exiting...")
            break
        else:
            print("Invalid choice!")

if __name__ == "__main__":
    main()
