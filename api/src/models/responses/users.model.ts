interface GetUserResponse {
    Id: string;
    FirstName: string;
    Surname?: string | null;
    Email: string;
}

export type { GetUserResponse };