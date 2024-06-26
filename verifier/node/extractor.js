const fs = require('fs');
const Jimp = require('jimp');
const jsQR = require('jsqr');

// Load the QR code image and decode it
Jimp.read('../qr/health_check_qr.png')
    .then(image => {
        const { data, width, height } = image.bitmap;
        const code = jsQR(new Uint8ClampedArray(data), width, height);

        if (code) {
            const extractedJson = JSON.parse(code.data);
            const { proof, public, verification_key } = extractedJson;
            fs.writeFileSync('../verification_key.json', JSON.stringify(verification_key, null, 2), 'utf-8');
            fs.writeFileSync('../proof.json', JSON.stringify(proof, null, 2), 'utf-8');
            fs.writeFileSync('../public.json', JSON.stringify(public, null, 2), 'utf-8');
        } else {
            console.error('Could not read QR code');
        }
    })
    .catch(err => {
        console.error('Error loading QR code image:', err);
    });

