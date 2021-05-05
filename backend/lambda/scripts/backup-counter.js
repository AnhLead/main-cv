var AWS = require('aws-sdk');
AWS.config.update({region: 'eu-west-2'});

exports.handler = async(event) => {
    console.log("Counter : 2");
}

var params = {
    ExpressionAttributeValues: {
      ':s': {N: '2'},
      ':e' : {N: '09'},
      ':topic' : {S: 'PHRASE'}
     },
   KeyConditionExpression: 'counter =: counter',
   ProjectionExpression: 'counter',
   FilterExpression: ' ',
   TableName: 'table name'
  };
  
  b.query(params, function(err, data) {
    if (err) {
      console.log("Error", err);
    } else {
  
       data.Items.forEach(function(element, index, array) {
       console.log( output here);
      });
    }
  });