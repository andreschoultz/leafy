import { compare, hash } from 'bcrypt';

function hashPassword(password: string): Promise<string> {
    return new Promise((resolve, reject) => {
        hash(password, 10, function (err, hash) {
            if (err) {
                reject(new Error('Error hashing password'));
            }

            resolve(hash);
        });
    });
}

async function validatePasswordAgainstHash(password: string, hash: string): Promise<boolean> {
    return new Promise((resolve, reject) => {
        compare(password, hash, function (err, result) {
            if (err) {
                reject(new Error('Error validating password'));
            }

            resolve(result);
        });
    });
}

export { hashPassword, validatePasswordAgainstHash };
