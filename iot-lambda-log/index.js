const AWS = require('aws-sdk');
const cloudwatchlogs = new AWS.CloudWatchLogs();

exports.handler = async (event) => {
    try {
        console.log('Received event:', JSON.stringify(event));

        // Custom logging logic
        if (event.hasOwnProperty('status') && event.status === 'offline') {
            console.log('Connection attempt failed:', event);
                }
                // Other IoT actions
                // Add your logic here to handle other IoT events
                // Log events to CloudWatch Logs
        await logEventToCloudWatchLogs(JSON.stringify(event));

        return {
            statusCode: 200,
            body: JSON.stringify('Event processed successfully')
                };
        } catch (error) {
        console.error('Error processing event:', error);
        return {
            statusCode: 500,
            body: JSON.stringify('Error processing event')
                };
        }
};

async function logEventToCloudWatchLogs(logEvent) {
    const params = {
        logGroupName: 'iot_logs',
        logStreamName: 'iot_logs_stream',
        logEvents: [
                        {
                message: logEvent,
                timestamp: new Date().getTime()
                        }
                ]
        };

    await cloudwatchlogs.putLogEvents(params).promise();
}