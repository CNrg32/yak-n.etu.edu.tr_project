import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom'; // Import useNavigate
import axios from 'axios';
import { PieChart, Pie, Cell, Tooltip, Legend } from 'recharts';
import './StudentCards.css';

const COLORS = ['#FF6384', '#36A2EB'];

const StudentCards = () => {
    const [balance, setBalance] = useState(0);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    const navigate = useNavigate(); 

    useEffect(() => {
        const fetchStudentCard = async () => {
            try {
                const response = await axios.get(`${process.env.REACT_APP_API_URL}/student_cards`);
                const userCard = response.data.find(card => card.user_id === 1);
                if (userCard) {
                    setBalance(parseFloat(userCard.balance));
                } else {
                    setError('User with ID 1 not found.');
                }
            } catch (err) {
                setError('Error fetching student card data.');
            } finally {
                setLoading(false);
            }
        };

        fetchStudentCard();
    }, []);

    if (loading) return <div>Loading...</div>;
    if (error) return <div>{error}</div>;

    const data = [
        { name: 'Used', value: parseFloat((balance * 0.3).toFixed(2)) },
        { name: 'Remaining', value: parseFloat((balance * 0.7).toFixed(2)) },
    ];

    return (
        <div className="student-cards-container">
            <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                <h2>Total Balance</h2>
                <div style={{ position: 'relative', width: '550px', height: '450px' }}>
                    <PieChart width={550} height={450}>
                        <Pie
                            data={data}
                            dataKey="value"
                            nameKey="name"
                            cx="50%"
                            cy="50%"
                            innerRadius={120}
                            outerRadius={200}
                            fill="#8884d8"
                            label={({ name, value }) => `${name}: ${value.toFixed(2)}₺`}
                        >
                            {data.map((entry, index) => (
                                <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                            ))}
                        </Pie>
                        <Tooltip formatter={(value) => `${value.toFixed(2)}₺`} />
                        <Legend />
                    </PieChart>
                    <div
                        style={{
                            position: 'absolute',
                            top: '50%',
                            left: '50%',
                            transform: 'translate(-50%, -50%)',
                            fontSize: '30px',
                            fontWeight: 'bold',
                            color: '#333',
                        }}
                    >
                        {balance.toFixed(2)}₺
                    </div>
                </div>
                <div style={{ marginTop: '30px', display: 'flex', gap: '15px' }}>
                    <button
                        className="btn btn-primary"
                        style={{
                            padding: '15px 30px',
                            fontSize: '18px',
                            fontWeight: 'bold',
                            borderRadius: '8px',
                        }}
                        onClick={() => navigate('/student-cards/validate-payment-method')} // Navigate on click
                    >
                        Add Money
                    </button>
                   
                </div>
            </div>
        </div>
    );
};

export default StudentCards;
