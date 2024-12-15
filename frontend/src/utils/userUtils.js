// userUtils.js

const USER_ID_KEY = 'current_user_id';

// Get the current user ID
export const getCurrentUserId = () => {
    return localStorage.getItem(USER_ID_KEY) || null;
};

// Set the current user ID
export const setCurrentUserId = (userId) => {
    if (!userId) {
        console.error('Invalid user ID. Cannot set user ID.');
        return;
    }
    localStorage.setItem(USER_ID_KEY, userId);
};

// Clear the current user ID
export const clearCurrentUserId = () => {
    localStorage.removeItem(USER_ID_KEY);
};
