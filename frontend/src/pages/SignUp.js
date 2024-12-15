import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './SignUp.css';
import { setCurrentUserId } from '../utils/userUtils';

const SignUp = () => {
    const [formData, setFormData] = useState({
        email: '',
        password: '',
        name: '',
        contact_details: '',
    });
    const [error, setError] = useState('');
    const navigate = useNavigate();

    // Handle form field changes
    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData({ ...formData, [name]: value });
    };

    const handleSignUp = async (e) => {
        e.preventDefault();
        console.log('Form Data:', formData); // Log the form data to ensure the password is present

        try {
            const response = await axios.post(`${process.env.REACT_APP_API_URL}/users`, formData);
            if (response.status === 201) {
                alert('Sign-Up Successful!');
                navigate('/login'); // Redirect to login
            }
        } catch (error) {
            console.error('Sign-Up Failed:', error);
            setError(error.response?.data?.message || 'Sign-Up failed.');
        }
    };

    return (
        <div className="signup-container">
            <h1>Create an Account</h1>
            <form className="signup-form" onSubmit={handleSignUp}>
                <input
                    type="text"
                    name="name"
                    placeholder="Full Name"
                    value={formData.name}
                    onChange={handleChange}
                    required
                />
                <input
                    type="email"
                    name="email"
                    placeholder="Email Address"
                    value={formData.email}
                    onChange={handleChange}
                    required
                />
                <input
                    type="password"
                    name="password"
                    placeholder="Password"
                    value={formData.password}
                    onChange={handleChange}
                    required
                />
                <input
                    type="text"
                    name="contact_details"
                    placeholder="Contact Details (Optional)"
                    value={formData.contact_details}
                    onChange={handleChange}
                />
                <button type="submit">Sign Up</button>
            </form>
            {error && <p className="error-message">{error}</p>}
            <p>
                Already have an account?{' '}
                <button type="button" onClick={() => navigate('/login')} className="login-button">
                    Log In
                </button>
            </p>
        </div>
    );
};

export default SignUp;
