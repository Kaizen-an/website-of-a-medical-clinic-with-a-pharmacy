document.addEventListener('DOMContentLoaded', function () {
  let cart = JSON.parse(localStorage.getItem('cart')) || [];

  const cartContainer = document.getElementById('cart-container');
  const totalPriceElement = document.getElementById('total-price');

  function updateCartDisplay() {
    cartContainer.innerHTML = '';
    let total = 0;

    if (cart.length === 0) {
      cartContainer.innerHTML = '<p>Кошик порожній</p>';
      totalPriceElement.textContent = '0 грн';
      return;
    }

    cart.forEach((item, index) => {
      total += item.price * item.quantity;
      cartContainer.innerHTML += `
        <div class="cart-item">
          <img src="${item.photo}" alt="${item.name}">
          <div class="cart-item-details">
            <h5>${item.name}</h5>
            <p>Ціна: ${item.price} грн</p>
            <p>Загальна вартість: ${item.price * item.quantity} грн</p>
          </div>
          <div class="cart-item-controls">
            <input type="number" min="1" value="${item.quantity}" data-index="${index}" class="quantity-input">
            <button class="btn remove-btn" data-index="${index}">Видалити</button>
          </div>
        </div>
      `;
    });

    totalPriceElement.textContent = `${total} грн`;
  }

  function updateQuantity(index, newQuantity) {
    if (newQuantity < 1) return;
    cart[index].quantity = newQuantity;
    localStorage.setItem('cart', JSON.stringify(cart));
    updateCartDisplay();
  }

  function removeItem(index) {
    cart.splice(index, 1);
    localStorage.setItem('cart', JSON.stringify(cart));
    updateCartDisplay();
  }

  cartContainer.addEventListener('input', (e) => {
    if (e.target.classList.contains('quantity-input')) {
      const index = e.target.getAttribute('data-index');
      const newQuantity = parseInt(e.target.value);
      updateQuantity(index, newQuantity);
    }
  });

  cartContainer.addEventListener('click', (e) => {
    if (e.target.classList.contains('remove-btn')) {
      const index = e.target.getAttribute('data-index');
      removeItem(index);
    }
  });

  document.getElementById('checkout-button').addEventListener('click', () => {
    if (cart.length === 0) {
      alert('Кошик порожній. Додайте товари перед оформленням.');
      return;
    }
    console.log(cart); 

    // Синхронізація з сервером для оформлення замовлення (можна додати додатковий код)
    // alert('');
    M.toast({ html: 'Замовлення оформлено!', displayLength: 3000 });
  
    updateCartDisplay();
  });

  updateCartDisplay();
});
