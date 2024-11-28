import React, { useEffect, useState } from 'react';
import axios from 'axios';

const Users = () => {
    const [users, setUsers] = useState([]);
    console.log(users);
    const [selectedUser, setSelectedUser] = useState(null);
    const [newUserData, setNewUserData] = useState({
        email: '',
        name: '',
        contact_details: ''
    });

//     // Tüm kullanıcıları çekme
//     useEffect(() => {
//         const fetchUsers = async () => {
//             try {
//                 const response = await axios.get(`${process.env.REACT_APP_API_URL}/users`);
//                 setUsers(response.data);
//             } catch (error) {
//                 console.error('Error fetching users:', error);
//             }
//         };
//         fetchUsers();
//         console.log(users)
//     }, []);

//     // Kullanıcı güncelleme
//     const handleUpdateUser = async (userId) => {
//         try {
//             const response = await axios.put(`${process.env.REACT_APP_API_URL}/users/${userId}`, selectedUser);
//             console.log('User updated:', response.data);
//             // Listeyi güncelle
//             setUsers(users.map(user => (user.user_id === userId ? response.data : user)));
//         } catch (error) {
//             console.error(`Error updating user with ID ${userId}:`, error);
//         }
//     };

//     // Kullanıcı silme
//     const handleDeleteUser = async (userId) => {
//         try {
//             await axios.delete(`${process.env.REACT_APP_API_URL}/users/${userId}`);
//             console.log(`User with ID ${userId} deleted`);
//             // Silinen kullanıcıyı listeden çıkar
//             setUsers(users.filter(user => user.user_id !== userId));
//         } catch (error) {
//             console.error(`Error deleting user with ID ${userId}:`, error);
//         }
//     };

//     return (
//         <div>
//             <h1>Users</h1>
//             <table>
//                 <thead>
//                     <tr>
//                         <th>Email</th>
//                         <th>Name</th>
//                         <th>Contact Details</th>
//                         <th>Actions</th>
//                     </tr>
//                 </thead>
//                 <tbody>
//                     {users.map(user => (
//                         <tr key={user.user_id}>
//                             <td>{user.email}</td>
//                             <td>{user.name}</td>
//                             <td>{user.contact_details}</td>
//                             <td>
//                                 <button onClick={() => setSelectedUser(user)}>Edit</button>
//                                 <button onClick={() => handleDeleteUser(user.user_id)}>Delete</button>
//                             </td>
//                         </tr>
//                     ))}
//                 </tbody>
//             </table>

//             {selectedUser && (
//                 <div>
//                     <h2>Edit User</h2>
//                     <input
//                         type="text"
//                         value={selectedUser.email}
//                         onChange={(e) => setSelectedUser({ ...selectedUser, email: e.target.value })}
//                         placeholder="Email"
//                     />
//                     <input
//                         type="text"
//                         value={selectedUser.name}
//                         onChange={(e) => setSelectedUser({ ...selectedUser, name: e.target.value })}
//                         placeholder="Name"
//                     />
//                     <input
//                         type="text"
//                         value={selectedUser.contact_details}
//                         onChange={(e) => setSelectedUser({ ...selectedUser, contact_details: e.target.value })}
//                         placeholder="Contact Details"
//                     />
//                     <button onClick={() => handleUpdateUser(selectedUser.user_id)}>Update</button>
//                 </div>
//             )}

//             <h2>Add New User</h2>
//             <input
//                 type="text"
//                 value={newUserData.email}
//                 onChange={(e) => setNewUserData({ ...newUserData, email: e.target.value })}
//                 placeholder="Email"
//             />
//             <input
//                 type="text"
//                 value={newUserData.name}
//                 onChange={(e) => setNewUserData({ ...newUserData, name: e.target.value })}
//                 placeholder="Name"
//             />
//             <input
//                 type="text"
//                 value={newUserData.contact_details}
//                 onChange={(e) => setNewUserData({ ...newUserData, contact_details: e.target.value })}
//                 placeholder="Contact Details"
//             />
//             <button onClick={async () => {
//                 try {
//                     const response = await axios.post(`${process.env.REACT_APP_API_URL}/users`, newUserData);
//                     setUsers([...users, response.data]);
//                     setNewUserData({ email: '', name: '', contact_details: '' });
//                 } catch (error) {
//                     console.error('Error adding new user:', error);
//                 }
//             }}>Add User</button>
//         </div>
//     );
 };

export default Users;
