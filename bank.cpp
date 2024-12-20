#include <iostream>
#include <string>

using namespace std;

class BankAccount {
protected:
    int accountNumber;
    string ownerName;
    double balance;

public:
    BankAccount(int accNum, string owner, double initialBalance)
        : accountNumber(accNum), ownerName(owner), balance(initialBalance) {}

    void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            cout << "На счет " << accountNumber << " зачислено: " << amount << endl;
        } else {
            cout << "Сумма для пополнения должна быть положительной!" << endl;
        }
    }

    void withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            cout << "Со счета " << accountNumber << " снято: " << amount << endl;
        } else {
            cout << "Недостаточно средств или некорректная сумма!" << endl;
        }
    }

    void display() const {
        cout << "Счет №: " << accountNumber << ", Владелец: " << ownerName
             << ", Баланс: " << balance << endl;
    }
};

class SavingsAccount : public BankAccount {
private:
    double interestRate;

public:
    SavingsAccount(int accNum, string owner, double initialBalance, double rate)
        : BankAccount(accNum, owner, initialBalance), interestRate(rate) {}

    void addInterest() {
        double interest = balance * (interestRate / 100);
        balance += interest;
        cout << "Начислены проценты (" << interestRate << "%): " << interest << endl;
    }
};

int main() {
    BankAccount account1(1001, "Bob", 5000);
    account1.display();
    account1.deposit(1500);
    account1.withdraw(2000);
    account1.display();

    SavingsAccount account2(2001, "Bob", 10000, 5);
    account2.display();
    account2.addInterest();
    account2.display();

}
