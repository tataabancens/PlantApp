const PgConnection = require("postgresql-easy");
const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { PutCommand, DynamoDBDocumentClient } = require("@aws-sdk/lib-dynamodb");

const pg = new PgConnection({
    host: process.env.DB_HOST,
    port: 5432,
    database: "postgres",
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    ssl: true,
});

const dynamoClient = new DynamoDBClient({});
const dynamo = DynamoDBDocumentClient.from(dynamoClient);

async function createPlantWatering(event) {
    let plantId = Number(event.pathParameters.plantId);
    let timestamp = new Date().toISOString();

    let body = event?.body;
    body = body ? JSON.parse(body) : body;
    let description = body?.description;

    const command = new PutCommand({
        TableName: "waterings",
        Item: { plantId: plantId, timestamp: timestamp, description: description }
    });

    const dynamoResponse = await dynamo.send(command);

    return {
        statusCode: 200
    };
}

module.exports = {
    createPlantWatering: createPlantWatering,
}
