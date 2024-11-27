interface RegisterUserRequest {
    Email: string;
    Password: string;
    FirstName: string;
    Surname?: string | null;
}

export type { RegisterUserRequest };