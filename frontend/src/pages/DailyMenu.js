import React from 'react';
import './DailyMenu.css'; // Özel CSS dosyasını import edin

const DailyMenu = () => {
    // Sahte menü verileri
    const menuItems = [
        ['Soup, Pasta, Cheesecake', 'Soup, Pasta, Cheesecake', 'Soup, Pasta, Cheesecake', 'Soup, Pasta, Cheesecake', 'Soup, Pasta, Cheesecake', 'Soup, Pasta, Cheesecake', 'Soup, Pasta, Cheesecake'],
        ['Salad, Pizza, Brownie', 'Salad, Pizza, Brownie', 'Salad, Pizza, Brownie', 'Salad, Pizza, Brownie', 'Salad, Pizza, Brownie', 'Salad, Pizza, Brownie', 'Salad, Pizza, Brownie'],
        ['Sandwich, Steak, Ice Cream', 'Sandwich, Steak, Ice Cream', 'Sandwich, Steak, Ice Cream', 'Sandwich, Steak, Ice Cream', 'Sandwich, Steak, Ice Cream', 'Sandwich, Steak, Ice Cream', 'Sandwich, Steak, Ice Cream'],
        ['Chicken, Rice, Pudding', 'Chicken, Rice, Pudding', 'Chicken, Rice, Pudding', 'Chicken, Rice, Pudding', 'Chicken, Rice, Pudding', 'Chicken, Rice, Pudding', 'Chicken, Rice, Pudding'],
        ['Fish, Noodles, Cake', 'Fish, Noodles, Cake', 'Fish, Noodles, Cake', 'Fish, Noodles, Cake', 'Fish, Noodles, Cake', 'Fish, Noodles, Cake', 'Fish, Noodles, Cake']
    ];

    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

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
                    {menuItems.map((row, rowIndex) => (
                        <tr key={rowIndex}>
                            {row.map((item, colIndex) => (
                                <td key={colIndex} className={`menu-cell color-${(rowIndex + colIndex) % 5}`}>
                                    <div className="menu-item">{item}</div>
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
