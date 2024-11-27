import * as UserDB from '../database/users.database';
import { GetUserResponse } from '../models/responses/users.model';

async function getUser(userId: string): Promise<GetUserResponse> {
    let result = await UserDB.getUser(userId);

    const response: GetUserResponse = {
        Id: result.Id,
        Email: result.Email,
        FirstName: result.FirstName,
        Surname: result.Surname,
    };
    
    return response;
}

export { getUser };