const moment = require('moment-timezone');
const SlackNotifier = require('./slackNotifier');

const WEBHOOK_URL = process.env.WEBHOOK_ID;
const headers = {
    "Access-Control-Allow-Headers": "application/json",
    "Access-Control-Allow-Origin": "*", // TODO: change this to specified domain
    "Access-Control-Allow-Methods": "GET"
}

const notifier = new SlackNotifier(WEBHOOK_URL);

exports.iot_handler = async (event, context) => {
    let statusCode = 200;
    let responseBody = 'ok';
    
    try {
        const doc = {            
            "date": moment().tz('Europe/Berlin').format(),
            "userAgent": event.headers,
            "message": JSON.stringify(event.body)
        }    
        
        // Send a message to Slack
        await notifier.sendMessage(JSON.stringify(doc));
        console.log('Message sent successfully');
    } catch (error) {
        console.error('Failed to send message:', error);
        statusCode = 503;
        responseBody = JSON.stringify({"error": error});
    }
    
    return {
        statusCode,
        headers,
        body: responseBody
    };
};
