Imagine you want to track your personal finances. You need a system that allows you to:  

1. **Add Transactions:**

	- Each transaction should include:
	
	- `type`: "income" or "expense"
	- `amount`: Numeric value
	- `category`:  ("Food", "Rent", etc. for Expenses) 
				   ("Salary", "Investments",  etc. for Income)
	- `date`: YYYY-MM-DD format for transactions

2. **View Transactions:**

	- Retrieve all stored transactions.

3. **Generate Financial Summary:**

- Calculate and display:

	- Total income
	- Total expenses
	- Balance (income - expenses)

4. **Handle Missing Data Gracefully:**

	- Implement error handling if required fields are missing.

5. **Save Transactions Permanently:**
	- Store and retrieve transaction data using JSON files.