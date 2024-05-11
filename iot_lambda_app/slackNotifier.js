const axios = require('axios');

class SlackNotifier {
    constructor(webhookUrl) {
        this.webhookUrl = webhookUrl;
    }

    async sendMessage(message) {
        try {
            const response = await axios.post(this.webhookUrl, { text: message });
            return response.data;
        } catch (error) {          
            throw error;
        }
    }
}

module.exports = SlackNotifier;