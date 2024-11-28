import React, { useEffect, useState } from "react";

const ManageFriends = () => {
    const [friends, setFriends] = useState([]);
    const userId = 1; // Replace with logged-in user's ID

    useEffect(() => {
        // Fetch friends from the API
        fetch(`http://localhost:3001/friends/${userId}`)
            .then(response => response.json())
            .then(data => {
                console.log("Fetched friends data:", data); // Debug log
                setFriends(data);
            })
            .catch(error => console.error("Error fetching friends:", error));
    }, []);

    return (
        <div>
            <h1 style={{ textAlign: "center", marginBottom: "20px" }}>Manage Friends</h1>
            <table>
                <thead>
                    <tr>
                        <th>Friend Name</th>
                        <th>Email</th>
                        <th>Balance</th>
                    </tr>
                </thead>
                <tbody>
                    {friends.length > 0 ? (
                        friends.map(friend => (
                            <tr key={friend.friendId}>
                                <td>{friend.friendName}</td>
                                <td>{friend.friendEmail}</td>
                                <td>{friend.friendBalance} ₺</td>
                            </tr>
                        ))
                    ) : (
                        <tr>
                            <td colSpan="3" style={{ textAlign: "center" }}>No friends found.</td>
                        </tr>
                    )}
                </tbody>
            </table>
        </div>
    );
};

export default ManageFriends;
