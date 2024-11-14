module.exports = app => {
    const friends = require('../controllers/Friends.controller');

   // app.post('/friends', friends.create);                    // Yeni bir arkadaş ilişkisi oluştur
   // app.get('/friends', friends.findAll);                    // Tüm arkadaş ilişkilerini getir
   // app.get('/friends/user/:userId', friends.findByUserId);  // Bir kullanıcının arkadaşlarını getir
   // app.delete('/friends/:friendId', friends.delete);        // Arkadaşlık ilişkisini sil
};
