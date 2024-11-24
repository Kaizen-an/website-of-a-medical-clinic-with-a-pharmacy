document.addEventListener('DOMContentLoaded', function () {
    const searchField = document.getElementById('search');

    searchField.addEventListener('keyup', function () {
        const filter = searchField.value.toLowerCase();
        const rows = document.querySelectorAll('#pharmacyTable tbody tr');

        rows.forEach(row => {
            const columns = row.querySelectorAll('td');
            let found = false;

            columns.forEach(column => {
                if (column.textContent.toLowerCase().includes(filter)) {
                    found = true;
                }
            });

            if (found) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
});

// Функція для видалення транзакції
function deleteTransaction(transactionID) {
  const url = '/finances_delete'; // URL маршруту для обробки видалення транзакції

  const data = new FormData();
  data.append('transaction_id', transactionID);
  data.append('action', 'delete');

  fetch(url, {
    method: 'POST',
    body: data
  })
  .then(response => response.json())
  .then(data => {
    console.log(data.message); // Повідомлення з сервера
    M.toast({ html: `Видалено транзакцію №${transactionID}` });
    // Додаткові дії після видалення транзакції (якщо потрібно)
  })
  .catch(error => {
    console.error('Помилка:', error);
    // Обробка помилок
  });
}
