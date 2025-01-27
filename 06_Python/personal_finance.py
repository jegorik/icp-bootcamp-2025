import json
import os
from datetime import datetime


class Transaction:
    """Represents a financial transaction."""

    def __init__(self, transaction_type, amount, category, date):
        """
        Initializes a new transaction.

        Args:
            transaction_type (str): The type of transaction ('income' or 'expense').
            amount (float): The amount of the transaction.
            category (str): The category of the transaction (e.g., 'Food', 'Rent').
            date (str): The date of the transaction in YYYY-MM-DD format.
        """
        self.transaction_type = transaction_type
        self.amount = amount
        self.category = category
        self.date = date

    def to_dict(self):
        """Converts the transaction to a dictionary for JSON serialization."""
        return {
            'type': self.transaction_type,
            'amount': self.amount,
            'category': self.category,
            'date': self.date
        }


class FinanceTracker:
    """Manages personal finance transactions and summaries."""

    TRANSACTION_FILE = 'transactions.json'  # File to store transactions

    def __init__(self):
        """Initializes the FinanceTracker and loads existing transactions."""
        self.transactions = self.load_transactions()
        self.available_commands = {
            'add': self.add_transaction,
            'view': self.view_transactions,
            'summary': self.generate_summary,
            'exit': self.exit_program
        }

    def load_transactions(self):
        """Loads transactions from the JSON file.

        Returns:
            list: A list of Transaction objects loaded from the file.
        """
        if os.path.exists(self.TRANSACTION_FILE):
            with open(self.TRANSACTION_FILE, 'r') as file:
                data = json.load(file)
                # Create Transaction objects from the loaded data
                return [Transaction(transaction_type=item['type'], amount=item['amount'],
                                    category=item['category'], date=item['date']) for item in data]
        return []

    def save_transactions(self):
        """Saves the current transactions to the JSON file."""
        with open(self.TRANSACTION_FILE, 'w') as file:
            json.dump([transaction.to_dict() for transaction in self.transactions], file)

    def add_transaction(self):
        """Prompts the user to add a new transaction."""
        transaction_type = self.get_transaction_type()
        amount = self.get_amount()
        category = input("Enter category: ").strip()
        date = self.get_date()

        # Create a new Transaction object and save it
        transaction = Transaction(transaction_type, amount, category, date)
        self.transactions.append(transaction)
        self.save_transactions()
        print("Transaction added successfully.")

    def get_transaction_type(self):
        """Prompts the user for the transaction type and validates input."""
        while True:
            transaction_type = input("Enter transaction type (income/expense): ").strip().lower()
            if transaction_type in ['income', 'expense']:
                return transaction_type
            print("Invalid transaction type. Please enter 'income' or 'expense'.")

    def get_amount(self):
        """Prompts the user for the amount and validates input."""
        while True:
            amount = input("Enter amount: ")
            if amount.replace('.', '', 1).isdigit():  # Check if amount is a valid number
                return float(amount)
            print("Invalid amount. Please enter a numeric value.")

    def get_date(self):
        """Prompts the user for the date and validates input."""
        while True:
            date = input("Enter date (YYYY-MM-DD): ").strip()
            try:
                datetime.strptime(date, '%Y-%m-%d')  # Validate date format
                return date
            except ValueError:
                print("Invalid date format. Please enter the date in YYYY-MM-DD format.")

    def view_transactions(self):
        """Displays all stored transactions to the user."""
        if not self.transactions:
            print("No transactions found.")
            return
        for transaction in self.transactions:
            print(transaction.to_dict())

    def generate_summary(self):
        """Generates and displays a financial summary including total income, expenses, and balance."""
        total_income = sum(t.amount for t in self.transactions if t.transaction_type == 'income')
        total_expenses = sum(t.amount for t in self.transactions if t.transaction_type == 'expense')
        balance = total_income - total_expenses

        print(f"Total Income: {total_income}")
        print(f"Total Expenses: {total_expenses}")
        print(f"Balance: {balance}")

    def display_commands(self):
        """Displays the available commands to the user."""
        prompt = 'Available actions: ' + ' '.join(
            f'{key.capitalize()}' for key in self.available_commands.keys()) + '\n'
        return prompt

    def main_menu(self):
        """Displays the main menu and handles user input for actions."""
        while True:
            print("\nPersonal Finance Tracker")
            print(self.display_commands())
            choice = input("Choose an action: ").strip().lower()

            action = self.available_commands.get(choice)
            if action:
                action()  # Call the corresponding method
            else:
                print("Invalid choice. Please try again.")

    def exit_program(self):
        """Exits the program gracefully."""
        print("Exiting the program.")
        exit(0)  # Exit the program gracefully


if __name__ == "__main__":
    tracker = FinanceTracker()
    tracker.main_menu()
