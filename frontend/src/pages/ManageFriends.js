import React, { useEffect, useState } from 'react';
import axios from 'axios';

const ManageFriends = () => {
    const [friends, setFriends] = useState([]);

    useEffect(() => {
        const fetchFriends = async () => {
            try {
                const response = await axios.get(`${process.env.REACT_APP_API_URL}/friends`);
                setFriends(response.data);
            } catch (error) {
                console.error('Error fetching friends:', error);
            }
        };
        fetchFriends();
    }, []);

    return (
        <div>
            <h1>Manage Friends</h1>
            <table>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Friend User ID</th>
                    </tr>
                </thead>
                <tbody>
                    {friends.map(friend => (
                        <tr key={friend.friend_id}>
                            <td>{friend.user_id}</td>
                            <td>{friend.friend_user_id}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default ManageFriends;
