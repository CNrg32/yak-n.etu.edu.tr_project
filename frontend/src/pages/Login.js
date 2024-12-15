import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './Login.css'; // Optional CSS for styling
import { setCurrentUserId } from '../utils/userUtils';
import axios from 'axios';

const Login = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [isButtonDisabled, setIsButtonDisabled] = useState(true);
    const [errorMessage, setErrorMessage] = useState('');

    const navigate = useNavigate(); // Initialize the navigate function

    const handleEmailChange = (e) => {
        setEmail(e.target.value);
        checkFormValidity(e.target.value, password);
    };

    const handlePasswordChange = (e) => {
        setPassword(e.target.value);
        checkFormValidity(email, e.target.value);
    };

    const checkFormValidity = (email, password) => {
        if (email.trim() && password.trim()) {
            setIsButtonDisabled(false);
        } else {
            setIsButtonDisabled(true);
        }
    };

    const handleLogin = async (e) => {
        e.preventDefault();

        try {
            const response = await axios.post(`${process.env.REACT_APP_API_URL}/users/login`, {
                email: email.trim(),
                password: password.trim(),
            });
            console.log("Login Response:", response.data); // Debugging

            const { userId } = response.data;
            setCurrentUserId(userId);
            navigate('/');
        } catch (error) {
            console.error("Login Error:", error);

            if (error.response) {
                console.error("Response Data:", error.response.data); // Backend error message
                setErrorMessage(error.response.data.message || 'An unexpected error occurred.');
            } else {
                setErrorMessage('An unexpected error occurred. Please try again.');
            }
        }
    };






    const handleSignUpRedirect = () => {
        navigate('/signup'); // Redirect to the sign-up page
    };

    return (
        <div className="login-container">
            <h1>Welcome Back</h1>
            <form className="login-form" onSubmit={handleLogin}>
                <input
                    type="email"
                    placeholder="Email Address"
                    value={email}
                    onChange={handleEmailChange}
                    required
                />
                <input
                    type="password"
                    placeholder="Password"
                    value={password}
                    onChange={handlePasswordChange}
                    required
                />
                {errorMessage && <p className="error-message">{errorMessage}</p>}
                <button type="submit" disabled={isButtonDisabled}>
                    Login
                </button>
            </form>
            <p>
                Don’t have an account?{' '}
                <button type="button" onClick={handleSignUpRedirect} className="signup-button">
                    Sign Up
                </button>
            </p>
        </div>
    );
};

export default Login;
