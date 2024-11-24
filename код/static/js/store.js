document.addEventListener('DOMContentLoaded', function () {
  const searchField = document.getElementById('search');
  const filterForm = document.getElementById('filter-form');
  const modal = document.getElementById('product-modal');
  const addToCartButton = document.getElementById('add-to-cart');

  // Ініціалізація модального вікна Materialize
  M.Modal.init(modal);

  // Обробник події для пошуку
  searchField.addEventListener('input', fetchProducts);

  // Обробник події для фільтрів
  filterForm.addEventListener('change', fetchProducts);

  function fetchProducts() {
    const searchValue = searchField.value.toLowerCase();
    const selectedCategories = Array.from(
      filterForm.querySelectorAll('input[name="category"]:checked')
    ).map(input => input.value);

    // Формуємо URL з параметрами
    const searchParams = new URLSearchParams({
      query: searchValue,
      categories: selectedCategories.join(',')
    });

    fetch(`/store_search?${searchParams.toString()}`)
      .then(response => response.json())
      .then(data => {
        const container = document.getElementById('products-container');
        container.innerHTML = ''; // Очищення контейнера

        if (data.products.length === 0) {
          container.innerHTML = '<p class="no-results">Товари не знайдено</p>';
          return;
        }

        data.products.forEach(product => {
          container.innerHTML += `
            <div class="product-card" onclick="openProductModal('${product.id}')">
              <img src="${product.photo}" alt="${product.MedicineName}" class="product-photo" />
              <h5>${product.MedicineName}</h5>
              <p>${product.description}</p>
              <p><strong>Ціна:</strong> ${product.price} грн</p>
            </div>`;
        });
      })
      .catch(error => {
        console.error('Помилка при отриманні даних:', error);
        const container = document.getElementById('products-container');
        container.innerHTML = '<p class="error">Помилка при завантаженні товарів</p>';
      });
  }

  // Додавання товару в корзину
  addToCartButton.addEventListener('click', function () {
    const productId = document.getElementById('modal-id').textContent;
    const productName = document.getElementById('modal-title').textContent;
    const productPhoto = document.getElementById('modal-photo').src;
    const productPrice = parseFloat(document.getElementById('modal-price').textContent.replace(' грн', ''));

    let cart = JSON.parse(localStorage.getItem('cart')) || [];

    // Перевірка, чи товар вже в корзині
    const existingProduct = cart.find(item => item.name === productName);
    if (existingProduct) {
      existingProduct.quantity += 1; // Збільшення кількості
    } else {
      // Додавання нового товару
      cart.push({
      id: productId, // Збереження ID товару
      name: productName,
      photo: productPhoto,
      price: productPrice,
      quantity: 1
    });
    }

    localStorage.setItem('cart', JSON.stringify(cart));
    M.toast({ html: 'Товар додано в кошик!', displayLength: 3000 });

  });
});
function openProductModal(productId) {
  console.log('Opening product modal for ID:', productId);

  if (!productId) {
    console.error('Product ID is undefined or invalid');
    return;
  }

  fetch(`/product_details?product_id=${productId}`)
    .then(response => response.json())
    .then(data => {
      if (data.error) {
        console.error('Error from API:', data.error);
        return;
      }

      // Оновлення даних модального вікна
      if (!data.MedicineID) {
        console.error('MedicineID is missing in API response');
        return;
      }

      document.getElementById('modal-id').textContent = data.MedicineID;
      document.getElementById('modal-title').textContent = data.MedicineName || 'Невідома назва';
      document.getElementById('modal-photo').src = data.photo || '';
      document.getElementById('modal-description').textContent = data.description || 'Опис відсутній';
      document.getElementById('modal-ingredients').textContent = data.ingredients || 'Інгредієнти невідомі';
      document.getElementById('modal-price').textContent = data.price ? `${data.price} грн` : 'Ціна невідома';

      // Відкриття модального вікна
      const modalElem = document.getElementById('product-modal');
      const modalInstance = M.Modal.getInstance(modalElem);

      if (!modalInstance) {
        const newInstance = M.Modal.init(modalElem);
        newInstance.open();
      } else {
        modalInstance.open();
      }
    })
    .catch(error => {
      console.error('Error while loading product details:', error);
    });
}
