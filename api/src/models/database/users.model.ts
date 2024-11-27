import { RowDataPacket } from 'mysql2';

interface User extends RowDataPacket {
    Id: string;
    FirstName: string;
    Surname?: string | null;
    Email: string;
    PasswordHash: string;
    PasswordSalt: string;
}

export type { User };