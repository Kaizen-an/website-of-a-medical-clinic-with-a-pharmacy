document.addEventListener('DOMContentLoaded', function () {
  const cart = JSON.parse(localStorage.getItem('cart')) || [];
  const orderSummary = document.getElementById('order-summary');
  const totalAmountElement = document.getElementById('total-amount');

  function updateOrderSummary() {
    orderSummary.innerHTML = '';
    let totalAmount = 0;

    if (cart.length === 0) {
      orderSummary.innerHTML = '<p>Ваш кошик порожній. <a href="/store">Перейти в магазин</a></p>';
      totalAmountElement.textContent = '0 грн';
      return;
    }

    cart.forEach((item) => {
      if (!item.id || isNaN(parseInt(item.id))) {
        console.error('Некоректний ID товару:', item);
        return;
      }

      const itemTotal = item.price * item.quantity;
      totalAmount += itemTotal;

      orderSummary.innerHTML += `
        <div class="order-item">
          <p><strong>${item.name}</strong> (x${item.quantity})</p>
          <p>Ціна за одиницю: ${item.price} грн</p>
          <p>Загальна вартість: ${itemTotal} грн</p>
        </div>`;
    });

    totalAmountElement.textContent = `${totalAmount} грн`;
  }

  updateOrderSummary();

  document.getElementById('checkout-form').addEventListener('submit', function (e) {
    e.preventDefault();

    const customerData = {
      name: document.getElementById('customer-name').value.trim(),
      surname: document.getElementById('customer-surname').value.trim(),
      phone: document.getElementById('phone').value.trim(),
      email: document.getElementById('email').value.trim(),
      cart: cart.filter(item => item.id && !isNaN(parseInt(item.id))), // Фільтруємо некоректні товари
      totalAmount: parseFloat(totalAmountElement.textContent.replace(' грн', '')),
    };

    if (!customerData.name || !customerData.surname || !customerData.phone || !customerData.email) {
      alert('Будь ласка, заповніть усі поля форми!');
      return;
    }

    fetch('/process_order', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(customerData),
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.success) {
          alert('Замовлення успішно оформлено!');
          localStorage.removeItem('cart');
          window.location.href = '/thank_you';
        } else {
          alert('Сталася помилка під час оформлення замовлення');
        }
      })
      .catch((error) => {
        console.error('Помилка під час відправки замовлення:', error);
        alert('Помилка під час відправки замовлення');
      });
  });
});
