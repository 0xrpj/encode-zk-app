const QRCode = require('qrcode');
const fs = require('fs');

// Function to read JSON files
const readJsonFile = (filePath) => {
    return new Promise((resolve, reject) => {
        fs.readFile(filePath, 'utf8', (err, data) => {
            if (err) {
                reject(err);
            } else {
                resolve(JSON.parse(data));
            }
        });
    });
};

Promise.all([
    readJsonFile('../output/proof.json'),
    readJsonFile('../output/public.json'),
    readJsonFile('../output/verification_key.json')
]).then(([proof, publicData, verificationKey]) => {
    const combinedJson = {
        proof,
        public: publicData,
        verification_key: verificationKey
    };

    const jsonString = JSON.stringify(combinedJson);

    QRCode.toFile('../../verifier/qr/health_check_qr.png', jsonString, function (err) {
        if (err) throw err;
        console.log('QR code generated and saved as health_check_qr.png');
    });
}).catch(err => {
    console.error('Error reading JSON files:', err);
});