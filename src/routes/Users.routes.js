module.exports = app => {
    const users = require('../controllers/Users.controller');

   // app.post('/users', users.create);            // Yeni bir kullanıcı oluştur
   // app.get('/users', users.findAll);             // Tüm kullanıcıları getir
   // app.get('/users/:userId', users.findOne);     // ID ile tek bir kullanıcı getir
   // app.put('/users/:userId', users.update);      // ID ile kullanıcı güncelle
   // app.delete('/users/:userId', users.delete);   // ID ile kullanıcı sil
};
