import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './ManageFriends.css';
import { getCurrentUserId } from '../utils/userUtils';

const ManageFriends = () => {
    const [friends, setFriends] = useState([]);
    const [showForm, setShowForm] = useState(false);
    const [newFriendEmail, setNewFriendEmail] = useState('');
    const [errorMessage, setErrorMessage] = useState('');

    // Fetch friends from the backend on component load
    useEffect(() => {
        const fetchFriends = async () => {
            try {
                 // Replace with the logged-in user's ID
                const response = await axios.get(`${process.env.REACT_APP_API_URL}/friends/${getCurrentUserId() }`);
                setFriends(
                    response.data.map((friend) => ({
                        name: friend.friendName,
                        email: friend.friendEmail,
                        balance: friend.friendBalance !== null ? `${friend.friendBalance} ₺` : '0 ₺',
                    }))
                );
            } catch (error) {
                console.error('Error fetching friends:', error);
            }
        };

        fetchFriends();
    }, []);

    // Handle input change
    const handleInputChange = (e) => {
        setNewFriendEmail(e.target.value);
        setErrorMessage('');
    };

    // Handle adding a new friend
    const handleAddFriend = async (e) => {
        e.preventDefault();

        // Check if the friend already exists
        if (friends.some((friend) => friend.email === newFriendEmail)) {
            setErrorMessage('This user is already your friend.');
            return;
        }

        try {
            const response = await axios.get(`${process.env.REACT_APP_API_URL}/users/with-balance`);
            const validUser = response.data.find((user) => user.email === newFriendEmail);

            if (validUser) {
                const userId = 1; // Replace with the logged-in user's ID
                await axios.post(`${process.env.REACT_APP_API_URL}/friends`, {
                    user_id: userId,
                    friend_user_id: validUser.user_id,
                });

                setFriends([
                    ...friends,
                    {
                        name: validUser.name,
                        email: validUser.email,
                        balance: validUser.balance !== null ? `${validUser.balance} ₺` : '0 ₺',
                    },
                ]);
                setShowForm(false);
                setNewFriendEmail('');
            } else {
                setErrorMessage('User with this email does not exist.');
            }
        } catch (error) {
            console.error('Error adding friend:', error);
            setErrorMessage('An error occurred while adding the friend.');
        }
    };

    return (
        <div className="manage-friends-container">
            <h1>Manage Friends</h1>
            <table className="friends-table">
                <thead>
                    <tr>
                        <th>Friend Name</th>
                        <th>Email</th>
                        <th>Balance</th>
                    </tr>
                </thead>
                <tbody>
                    {friends.map((friend, index) => (
                        <tr key={index}>
                            <td>{friend.name}</td>
                            <td>{friend.email}</td>
                            <td>{friend.balance}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
            <button className="add-friend-button" onClick={() => setShowForm(true)}>
                Add Friend
            </button>

            {showForm && (
                <div className="add-friend-form-container">
                    <form className="add-friend-form" onSubmit={handleAddFriend}>
                        <label>
                            Friend's Email:
                            <input
                                type="email"
                                value={newFriendEmail}
                                onChange={handleInputChange}
                                required
                            />
                        </label>
                        {errorMessage && <p className="error-message">{errorMessage}</p>}
                        <div className="form-buttons">
                            <button type="submit">Add</button>
                            <button type="button" onClick={() => setShowForm(false)}>
                                Cancel
                            </button>
                        </div>
                    </form>
                </div>
            )}
        </div>
    );
};

export default ManageFriends;
