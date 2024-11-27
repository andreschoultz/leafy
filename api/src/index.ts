import * as dotenv from 'dotenv';
import express, { Request, Response } from 'express';

import authenticationRoutes from './controllers/authentication.controller';

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());
app.use('/authenticate', authenticationRoutes);

app.get('/', (req: Request, res: Response) => {
    res.send('Hello, TypeScript Express!');
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
