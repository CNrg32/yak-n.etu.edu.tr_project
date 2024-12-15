module.exports = app => {
    const cafeteriaMenu = require('../controllers/Cafeteria_Menu.controller');

    app.post('/cafeteria_menu', cafeteriaMenu.create);           // Yeni bir yemek menüsü oluştur
    app.get('/cafeteria_menu', cafeteriaMenu.findAll);           // Tüm yemek menülerini getir
    app.get('/cafeteria_menu/:menuId', cafeteriaMenu.findOne);   // ID ile tek bir yemek menüsü getir
    app.put('/cafeteria_menu/:menuId', cafeteriaMenu.update);    // ID ile yemek menüsünü güncelle
    app.delete('/cafeteria_menu/:menuId', cafeteriaMenu.delete); // ID ile yemek menüsünü sil
};
