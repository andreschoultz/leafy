import { createPool } from 'mysql2/promise';

import * as ENV_VAR from '../helpers/env';

export const pool = createPool({
    host: ENV_VAR.MYSQL.HOST,
    user: ENV_VAR.MYSQL.USER,
    password: ENV_VAR.MYSQL.PASSWORD,
    database: ENV_VAR.MYSQL.DATABASE,
    waitForConnections: true,
    connectionLimit: 10,
    maxIdle: 20,
    idleTimeout: 60000,
    queueLimit: 2,
    enableKeepAlive: false,
    keepAliveInitialDelay: 0,
});