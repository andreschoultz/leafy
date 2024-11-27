import * as dotenv from 'dotenv';

dotenv.config();


const MISSING_ENV_VAR = 'MISSING_ENV_VAR';

const MYSQL = {
    HOST: process.env.MYSQL_HOST ?? MISSING_ENV_VAR,
    USER: process.env.MYSQL_USER ?? MISSING_ENV_VAR,
    PASSWORD: process.env.MYSQL_PASSWORD ?? MISSING_ENV_VAR,
    DATABASE: process.env.MYSQL_DATABASE ?? MISSING_ENV_VAR,
};

const JWT = {
    TOKEN: process.env.JWT_TOKEN_KEY ?? MISSING_ENV_VAR,
};


export { JWT, MYSQL };