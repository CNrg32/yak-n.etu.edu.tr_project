import React from 'react';
import './Syllabus.css'; // Özel CSS dosyasını import edin

const Syllabus = () => {
    const schedule = [
        { time: '10.00', lesson: 'Lesson Name' },
        { time: '12.00', lesson: 'Lesson Name' },
        { time: '14.00', lesson: 'Lesson Name' },
        { time: '15.00', lesson: 'Lesson Name' },
        { time: '17.00', lesson: 'Lesson Name' }
    ];

    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

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
                            {days.map((day, colIndex) => (
                                <td key={colIndex} className={`lesson-cell color-${(rowIndex + colIndex) % 5}`}>
                                    <div className="lesson-name">{slot.lesson}</div>
                                </td>
                            ))}
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default Syllabus;
