import React, { useState, useEffect } from 'react';
import './Syllabus.css'; // Import custom CSS for styling
import axios from 'axios';
import { getCurrentUserId } from '../utils/userUtils';

const Syllabus = () => {
    const [schedule, setSchedule] = useState([]); // Dynamic schedule state
    const [days] = useState(['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchSchedule = async () => {
            const userId = getCurrentUserId();

            if (!userId) {
                setError('No user ID found. Redirecting to login...');
                setTimeout(() => window.location.href = '/login', 2000);
                return;
            }

            try {
                const response = await axios.get(`${process.env.REACT_APP_API_URL}/syllabus/${userId}`);
                setSchedule(response.data);
            } catch (err) {
                console.error('Error fetching syllabus data:', err);
                setError('Error fetching syllabus data. Please try again.');
            } finally {
                setLoading(false);
            }
        };

        fetchSchedule();
    }, []);

    if (loading) {
        return <div>Loading syllabus...</div>;
    }

    if (error) {
        return <div className="error">{error}</div>;
    }

    return (
        <div className="syllabus-container">
            <div className="syllabus-header">
                <h1>Manage Syllabus</h1>
                <div className="button-group">
                    <button className="action-button remove-lesson">
                        <i className="fas fa-trash-alt"></i> Remove Lesson
                    </button>
                    <button className="action-button add-lesson">
                        <i className="fas fa-plus"></i> Add Lesson
                    </button>
                </div>
            </div>
            <table className="syllabus-table">
                <thead>
                    <tr>
                        <th>Time</th>
                        {days.map(day => (
                            <th key={day}>{day}</th>
                        ))}
                    </tr>
                </thead>
                <tbody>
                    {schedule.map((slot, rowIndex) => (
                        <tr key={rowIndex}>
                            <td className="time-cell">{slot.time}</td>
                            {days.map((day, colIndex) => {
                                const lesson = slot[day.toLowerCase()] || 'No Lesson';
                                return (
                                    <td key={colIndex} className={`lesson-cell color-${(rowIndex + colIndex) % 5}`}>
                                        <div className="lesson-name">{lesson}</div>
                                    </td>
                                );
                            })}
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default Syllabus;
