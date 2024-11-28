import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './DailyMenu.css'; // Make sure to create or update this CSS file

const DailyMenu = () => {
    const [menuData, setMenuData] = useState([]);
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

    useEffect(() => {
        const fetchMenu = async () => {
            try {
                const response = await axios.get(`${process.env.REACT_APP_API_URL}/cafeteria_menu`);
                setMenuData(response.data);
            } catch (error) {
                console.error('Error fetching menu data:', error);
            }
        };
        fetchMenu();
    }, []);

    const groupedMenus = days.map(day => {
        return menuData.filter(menu => new Date(menu.date).toLocaleDateString('en-US', { weekday: 'long' }) === day);
    });

    return (
        <div className="daily-menu-container">
            <h1>Daily Menu</h1>
            <table className="daily-menu-table">
                <thead>
                    <tr>
                        {days.map(day => (
                            <th key={day}>{day}</th>
                        ))}
                    </tr>
                </thead>
                <tbody>
                    {groupedMenus[0].map((_, rowIndex) => (
                        <tr key={rowIndex}>
                            {groupedMenus.map((menus, colIndex) => (
                                <td key={colIndex} className={`menu-cell color-${(rowIndex + colIndex) % 5}`}>
                                    {menus[rowIndex] ? (
                                        <div className="menu-item">
                                            <div><strong>{new Date(menus[rowIndex].date).toLocaleDateString('en-GB')}</strong></div>
                                            {menus[rowIndex].menu_description.split(',').map((item, i) => (
                                                <div key={i}>{item.trim()}</div>
                                            ))}
                                        </div>
                                    ) : (
                                        <div className="menu-item"></div>
                                    )}
                                </td>
                            ))}
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default DailyMenu;
