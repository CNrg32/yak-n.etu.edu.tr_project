import React from 'react';
import { Link } from 'react-router-dom';
import './Navbar.css';
import logo from '../assets/logo.png';

const Navbar = () => {
    return (
        <nav className="navbar">
               <div className="logo-container">
        <img src={logo} alt="Logo" className="navbar-logo" />
        <h1 className="navbar-title">EduConnect</h1>
    </div>
       
            <ul className="nav-links">
                <li><Link to="/">Home</Link></li>
                <li><Link to="/daily-menu">Daily Menu</Link></li>
                <li><Link to="/empty-classrooms">Empty Classrooms</Link></li>
                {/* <li><Link to="/courses">Courses</Link></li> */}
                <li><Link to="/enrollments">Syllabus</Link></li>
                <li><Link to="/manage-friends">Manage Friends</Link></li>
                <li><Link to="/student-cards">Student Cards</Link></li>
                <li><Link to="/users">Users</Link></li>
            </ul>
        </nav>
    );
};

export default Navbar;
