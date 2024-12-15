import React, { useEffect, useState } from 'react';
import axios from 'axios';
import './EmptyClassrooms.css'; // Özel CSS dosyasını import edin
import { setCurrentUserId } from '../utils/userUtils';

const EmptyClassrooms = () => {
    const [classrooms, setClassrooms] = useState([]);
    const [selectedTimeSlot, setSelectedTimeSlot] = useState('08:00');
    const timeSlots = ['08:00', '10:00', '12:00', '14:00', '16:00'];

    useEffect(() => {
        const fetchClassrooms = async () => {
            try {
                const response = await axios.get(`${process.env.REACT_APP_API_URL}/classrooms`);
                setClassrooms(response.data);
            } catch (error) {
                console.error('Error fetching classrooms:', error);
            }
        };
        fetchClassrooms();
    }, []);

    // Seçili saat dilimine göre sınıfları filtreleyin
    const filteredClassrooms = classrooms.filter(classroom => classroom.hours === selectedTimeSlot);

    // 6x5 grid yapısına göre sınıfları parçalara ayırın
    const gridClassrooms = [];
    for (let i = 0; i < filteredClassrooms.length; i += 5) {
        gridClassrooms.push(filteredClassrooms.slice(i, i + 5));
    }

    return (
        <div className="empty-classrooms-container">
            <div className="header">
                <h1>Empty Classrooms</h1>
                <div className="time-slot-selector">
                    {timeSlots.map(slot => (
                        <button
                            key={slot}
                            className={`time-slot-button ${slot === selectedTimeSlot ? 'active' : ''}`}
                            onClick={() => setSelectedTimeSlot(slot)}
                        >
                            {slot}
                        </button>
                    ))}
                </div>
            </div>
            <div className="classrooms-grid">
                {gridClassrooms.map((row, rowIndex) => (
                    <div key={rowIndex} className="classroom-row">
                        {row.map(classroom => (
                            <div
                                key={classroom.classroom_id}
                                className={`classroom-box ${classroom.is_empty ? 'selectable' : 'not-selectable'}`}
                            >
                                <div className="classroom-name">{classroom.room_name}</div>
                                {classroom.is_empty ? 'selectable' : 'cannot be selected'}
                            </div>
                        ))}
                    </div>
                ))}
            </div>
        </div>
    );
};

export default EmptyClassrooms;
