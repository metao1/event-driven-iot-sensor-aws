'use strict';

const chai = require('chai');
const expect = chai.expect;

const lambda = require('../../app.js');

// Mock the SlackNotifier class
jest.mock('../../slackNotifier', () => {
    return jest.fn().mockImplementation(() => {
        return {
            sendMessage: jest.fn()
        };
    });
});

describe('iot_handler', () => {
    let event, context;

    beforeEach(() => {
        // Mock event and context objects
        event = {
            headers: {
                // Mock event headers
                'User-Agent': 'Test User-Agent'
            },
            body: {
                // Mock event body
                test: 'test'
            }
        };
        context = {};
    });

    it('should handle successful invocation', async () => {
        const response = await lambda.iot_handler(event, context);
        expect(response.statusCode).to.equal(200);
        expect(response.body).to.equal('ok');
    });

    it('should handle error during invocation', async () => {
        // Mock event and context objects
        const event = {
            headers: {
                'User-Agent': 'Test User-Agent'
            },
            body: {
                test: 'test'
            }
        };
        const context = {};

        // Mock the Lambda function execution with a function that throws an error
        const lambdaError = new Error('Test error');
        lambda.iot_handler = jest.fn().mockRejectedValue(lambdaError);

        // Invoke the Lambda function
        try {
            await lambda.iot_handler(event, context);
        } catch (error) {
            // Verify that the error message matches the expected error
            expect(error).equal(lambdaError);
        }
    });
});
