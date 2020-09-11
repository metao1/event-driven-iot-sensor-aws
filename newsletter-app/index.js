const https = require("https");
exports.getHttp = async (url, query) => {
    return new Promise((resolve, reject) => {
        const URL = (url + query).trim();
        console.log(URL);
        const request = https.get(URL, response => {
            response.setEncoding('utf8');

            let returnData = '';
            if (response.statusCode < 200 || response.statusCode >= 300) {
                return reject(new Error(`${response.statusCode}: ${response.req.getHeader('host')} ${response.req.path}`));
            }

            response.on('data', chunk => {
                returnData += chunk;
            });

            response.on('end', () => {
                resolve(returnData);
            });

            response.on('error', error => {
                reject(error);
            });
        });
        request.end();
    });
}
