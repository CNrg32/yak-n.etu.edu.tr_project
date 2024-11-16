import React from 'react';
import { Link } from 'react-router-dom';
import './Navbar.css'; // CSS dosyasını oluşturun ve stil ekleyin

const Navbar = () => {
    return (
        <nav className="navbar">
            <h1>EduConnect</h1>
            <ul className="nav-links">
                <li><Link to="/">Home</Link></li>
                <li><Link to="/courses">Courses</Link></li>
                <li><Link to="/enrollments">Enrollments</Link></li>
                <li><Link to="/manage-friends">Manage Friends</Link></li>
                <li><Link to="/student-cards">Student Cards</Link></li>
                <li><Link to="/users">Users</Link></li>
            </ul>
        </nav>
    );
};

export default Navbar;
