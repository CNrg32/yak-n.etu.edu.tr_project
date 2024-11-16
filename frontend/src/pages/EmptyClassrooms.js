import React, { useState } from 'react';
import './EmptyClassrooms.css'; // Özel CSS dosyasını import edin

const EmptyClassrooms = () => {
    // Saat dilimleri için seçenekler
    const timeSlots = ['10:00', '12:00', '14:00', '16:00', '18:00'];

    // Her saat dilimi için sahte sınıf verileri ve isimleri (true: seçilebilir, false: seçilemez)
    const classroomsData = {
        '10:00': [
            [{ status: false, name: 'Class A1' }, { status: true, name: 'Class B1' }, { status: false, name: 'Class C1' }, { status: true, name: 'Class D1' }, { status: false, name: 'Class E1' }],
            [{ status: true, name: 'Class A2' }, { status: false, name: 'Class B2' }, { status: true, name: 'Class C2' }, { status: false, name: 'Class D2' }, { status: true, name: 'Class E2' }],
            [{ status: false, name: 'Class A3' }, { status: true, name: 'Class B3' }, { status: false, name: 'Class C3' }, { status: true, name: 'Class D3' }, { status: false, name: 'Class E3' }],
            [{ status: true, name: 'Class A4' }, { status: false, name: 'Class B4' }, { status: true, name: 'Class C4' }, { status: false, name: 'Class D4' }, { status: true, name: 'Class E4' }],
            [{ status: false, name: 'Class A5' }, { status: true, name: 'Class B5' }, { status: false, name: 'Class C5' }, { status: true, name: 'Class D5' }, { status: false, name: 'Class E5' }],
            [{ status: true, name: 'Class A6' }, { status: false, name: 'Class B6' }, { status: true, name: 'Class C6' }, { status: true, name: 'Class D6' }, { status: false, name: 'Class E6' }]
        ],
        '12:00': [
            [{ status: true, name: 'Class F1' }, { status: false, name: 'Class G1' }, { status: true, name: 'Class H1' }, { status: false, name: 'Class I1' }, { status: true, name: 'Class J1' }],
            [{ status: false, name: 'Class F2' }, { status: true, name: 'Class G2' }, { status: false, name: 'Class H2' }, { status: true, name: 'Class I2' }, { status: false, name: 'Class J2' }],
            [{ status: true, name: 'Class F3' }, { status: true, name: 'Class G3' }, { status: false, name: 'Class H3' }, { status: true, name: 'Class I3' }, { status: false, name: 'Class J3' }],
            [{ status: false, name: 'Class F4' }, { status: false, name: 'Class G4' }, { status: true, name: 'Class H4' }, { status: true, name: 'Class I4' }, { status: true, name: 'Class J4' }],
            [{ status: true, name: 'Class F5' }, { status: false, name: 'Class G5' }, { status: true, name: 'Class H5' }, { status: false, name: 'Class I5' }, { status: true, name: 'Class J5' }],
            [{ status: true, name: 'Class F6' }, { status: true, name: 'Class G6' }, { status: false, name: 'Class H6' }, { status: true, name: 'Class I6' }, { status: false, name: 'Class J6' }]
        ],
        '14:00': [
            [{ status: false, name: 'Class K1' }, { status: true, name: 'Class L1' }, { status: true, name: 'Class M1' }, { status: false, name: 'Class N1' }, { status: true, name: 'Class O1' }],
            [{ status: true, name: 'Class K2' }, { status: false, name: 'Class L2' }, { status: true, name: 'Class M2' }, { status: true, name: 'Class N2' }, { status: false, name: 'Class O2' }],
            [{ status: false, name: 'Class K3' }, { status: true, name: 'Class L3' }, { status: false, name: 'Class M3' }, { status: true, name: 'Class N3' }, { status: true, name: 'Class O3' }],
            [{ status: true, name: 'Class K4' }, { status: true, name: 'Class L4' }, { status: true, name: 'Class M4' }, { status: false, name: 'Class N4' }, { status: false, name: 'Class O4' }],
            [{ status: false, name: 'Class K5' }, { status: true, name: 'Class L5' }, { status: true, name: 'Class M5' }, { status: false, name: 'Class N5' }, { status: true, name: 'Class O5' }],
            [{ status: true, name: 'Class K6' }, { status: false, name: 'Class L6' }, { status: true, name: 'Class M6' }, { status: true, name: 'Class N6' }, { status: false, name: 'Class O6' }]
        ],
        '16:00': [
            [{ status: true, name: 'Class P1' }, { status: false, name: 'Class Q1' }, { status: true, name: 'Class R1' }, { status: false, name: 'Class S1' }, { status: true, name: 'Class T1' }],
            [{ status: true, name: 'Class P2' }, { status: true, name: 'Class Q2' }, { status: false, name: 'Class R2' }, { status: true, name: 'Class S2' }, { status: false, name: 'Class T2' }],
            [{ status: false, name: 'Class P3' }, { status: true, name: 'Class Q3' }, { status: true, name: 'Class R3' }, { status: false, name: 'Class S3' }, { status: true, name: 'Class T3' }],
            [{ status: true, name: 'Class P4' }, { status: false, name: 'Class Q4' }, { status: true, name: 'Class R4' }, { status: true, name: 'Class S4' }, { status: false, name: 'Class T4' }],
            [{ status: false, name: 'Class P5' }, { status: true, name: 'Class Q5' }, { status: false, name: 'Class R5' }, { status: true, name: 'Class S5' }, { status: true, name: 'Class T5' }],
            [{ status: true, name: 'Class P6' }, { status: false, name: 'Class Q6' }, { status: true, name: 'Class R6' }, { status: false, name: 'Class S6' }, { status: true, name: 'Class T6' }]
        ],
        '18:00': [
            [{ status: false, name: 'Class U1' }, { status: true, name: 'Class V1' }, { status: true, name: 'Class W1' }, { status: false, name: 'Class X1' }, { status: true, name: 'Class Y1' }],
            [{ status: true, name: 'Class U2' }, { status: false, name: 'Class V2' }, { status: true, name: 'Class W2' }, { status: true, name: 'Class X2' }, { status: false, name: 'Class Y2' }],
            [{ status: true, name: 'Class U3' }, { status: true, name: 'Class V3' }, { status: false, name: 'Class W3' }, { status: true, name: 'Class X3' }, { status: false, name: 'Class Y3' }],
            [{ status: false, name: 'Class U4' }, { status: false, name: 'Class V4' }, { status: true, name: 'Class W4' }, { status: false, name: 'Class X4' }, { status: true, name: 'Class Y4' }],
            [{ status: true, name: 'Class U5' }, { status: false, name: 'Class V5' }, { status: true, name: 'Class W5' }, { status: true, name: 'Class X5' }, { status: false, name: 'Class Y5' }],
            [{ status: true, name: 'Class U6' }, { status: true, name: 'Class V6' }, { status: false, name: 'Class W6' }, { status: true, name: 'Class X6' }, { status: true, name: 'Class Y6' }]
        ]
    };

    // Varsayılan saat dilimi
    const [selectedTimeSlot, setSelectedTimeSlot] = useState('10:00');

    // Seçilen saat dilimine göre verileri al
    const classroomStatus = classroomsData[selectedTimeSlot];

    return (
        <div className="empty-classrooms-container">
            <div className="header">
                <h1>Empty Classrooms</h1>
                <div className="time-slot-selector">
                    {timeSlots.map((slot) => (
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
                {classroomStatus.map((row, rowIndex) => (
                    <div key={rowIndex} className="classroom-row">
                        {row.map((classroom, colIndex) => (
                            <div
                                key={colIndex}
                                className={`classroom-box ${classroom.status ? 'selectable' : 'not-selectable'}`}
                            >
                                <div className="classroom-name">{classroom.name}</div>
                                {classroom.status ? 'selectable' : 'cannot be selected'}
                            </div>
                        ))}
                    </div>
                ))}
            </div>
        </div>
    );
};

export default EmptyClassrooms;
