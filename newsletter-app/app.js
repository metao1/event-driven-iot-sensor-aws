const moment = require('moment-timezone');
const request = require('./index.js');

let response;
const TOKEN = process.env.TOKEN;
const CHAT_ID = process.env.CHAT_ID;

exports.newsletter = async (event, context, callback) => {
    try {
        if (event.queryStringParameters && event.queryStringParameters.email) {
            const doc = {
                "email": event.queryStringParameters.email,
                "date": moment().tz('Europe/Berlin').format(),
                userAgent: event.headers,
                "ip": event.requestContext.identity.sourceIp
            }
            const query = "?text=" + JSON.stringify(doc) + "&chat_id=" + CHAT_ID;
            const URL = 'https://api.telegram.org/bot' + TOKEN + '/sendMessage';
            const anything = await request.getHttp(URL, query);
            console.log(JSON.stringify(anything));
            response = {
                'statusCode': 200,
                'headers': {"Content-Type": "application/json"},
                'body': 'ok'
            }
        } else {
            response = {
                'statusCode': 405,
                'headers': {"Content-Type": "application/json"},
                'body': JSON.stringify({"error": "method not allowed."})
            }
        }
    } catch (err) {
        console.error('error-> ' + err);
        response = {
            'statusCode': 503,
            'headers': {"Content-Type": "application/json"},
            'body': JSON.stringify({"error": err})
        }
    }
    callback(null, response);
};
