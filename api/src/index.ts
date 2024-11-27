import * as dotenv from 'dotenv';
import express, { Request, Response } from 'express';

import authenticationRoutes from './controllers/authentication.controller';
import userRoutes from './controllers/user.controller';

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());
app.use('/authenticate', authenticationRoutes);
app.use('/user', userRoutes);

app.get('/', (req: Request, res: Response) => {
    res.send('Hello, TypeScript Express!');
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
