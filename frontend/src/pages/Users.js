// User.js
import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './Users.css';
import { getCurrentUserId,clearCurrentUserId } from '../utils/userUtils';

const User = () => {
    const [user, setUser] = useState(null);
    const navigate = useNavigate();

    useEffect(() => {
        const fetchUser = async () => {
            const userId = getCurrentUserId();
            try {
                const response = await axios.get(`${process.env.REACT_APP_API_URL}/users`);
                const currentUser = response.data.find(user => user.user_id === parseInt(userId) );
                setUser(currentUser);
            } catch (error) {
                console.error('Error fetching user data:', error);
            }
        };
        fetchUser();
    }, []);

    const handleLogout = () => {
        console.log('User logged out');
        clearCurrentUserId();
        navigate('/login');
    };

    if (!user) {
        return <div>Loading user information...</div>;
    }

    return (
        <div className="user-container">
            <h1>User Profile</h1>
            <div className="user-details">
                <p><strong>Name:</strong> {user.name}</p>
                <p><strong>Email:</strong> {user.email}</p>
                <p><strong>Contact Details:</strong> {user.contact_details || 'N/A'}</p>
            </div>
            <button className="logout-button" onClick={handleLogout}>Logout</button>
        </div>
    );
};

export default User;
