import * as AWS from 'aws-sdk';
import * as zlib from 'zlib';

export const handler = async (event: any = {}): Promise<any> => {
    
    // console.log(JSON.stringify(event));
    // console.log('Records: ' + event.Records.length);
    // console.log('----------------------------------  data  ----------------------------------');

    event.Records.forEach(function(record: any = {}) {
        // Kinesis data is base64 encoded so decode here
        // console.log('.');
        var payload = zlib.gunzipSync(Buffer.from(record.kinesis.data, 'base64')).toString('ascii');
        // console.log('Decoded and inflated payload:', payload);
    });

	console.log('done');
    // TODO implement
    const response = {
        statusCode: 200,
        body: JSON.stringify('Hello from Lambda!'),
    };
    return response;
};
