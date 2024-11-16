import React, { useEffect, useState } from 'react';
import axios from 'axios';

const StudentCards = () => {
    const [cards, setCards] = useState([]);

    useEffect(() => {
        const fetchCards = async () => {
            try {
                const response = await axios.get(`${process.env.REACT_APP_API_URL}/student_cards`);
                setCards(response.data);
            } catch (error) {
                console.error('Error fetching student cards:', error);
            }
        };
        fetchCards();
    }, []);

    return (
        <div>
            <h1>Student Cards</h1>
            <table>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Balance</th>
                    </tr>
                </thead>
                <tbody>
                    {cards.map(card => (
                        <tr key={card.card_id}>
                            <td>{card.user_id}</td>
                            <td>{card.balance}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default StudentCards;
