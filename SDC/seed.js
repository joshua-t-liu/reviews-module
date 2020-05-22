const fs = require('fs');
const faker = require('faker');

//for mysql
//create 10M products
let j = 10;
while(j){
  let i = 10;
  let file = fs.createWriteStream(`./db/product/seed_product${j}.csv`);
  while(i) {
    file.write(faker.commerce.productName() + '\n');
    i--;
  }
  file.end();
  j--;
}

//create users
j = 10;
while(j){
  let i = 10;
  let file = fs.createWriteStream(`./db/user/seed_user${j}.csv`);
  while(i) {
    file.write(
      faker.internet.userName() + ',' +
      faker.internet.email() +
      '\n');
    i--;
  }
  file.end();
  j--;
}

//create reviews
let product_id = -1;
const ratings = ['poor', 'fair', 'average', 'good', 'great'];
const ratings_centered = ['too_small', 'small', 'perfect', 'big', 'too_big'];

j = 10;
while(j) {
  let i = 10;
  let file = fs.createWriteStream(`./db/review/seed_user${j}.csv`);

  while(i) {
    // 10% 0, 80% 1-500, 5%, 501-1k ,5% 1k-5k
    product_id ++;
    let k = Math.random;
    if (k < 0.1) {
      k = 0;
    } else if (k < 0.9) {
      k = faker.random.number({min:1, max:500});
    } else if (k < 0.95) {
      k = faker.random.number({min:501, max:1000});
    } else {
      k = faker.random.number({min:1001, max:5000});
    }

    while(k) {
      file.write(
        product_id + ',' +
        faker.random.number({min:0, max:9999999}) + ',' + //user_id
        faker.lorem.sentence() + ',' + // title 3-10 words
        faker.lorem.sentences() + ',' + // text 2-6 sentences
        (Math.random() > 0.5) + ',' + // recommends
        faker.random.arrayElement(ratings) + ',' + // rating_overall
        faker.random.arrayElement(ratings_centered) + ',' + // rating_size
        faker.random.arrayElement(ratings_centered) + ',' + // rating_width
        faker.random.arrayElement(ratings) + ',' + // rating_comfort
        faker.random.arrayElement(ratings) + ',' + // rating_quality
        faker.random.number({min:0, max:50}) + ',' + // is_helpful
        faker.random.number({min:0, max:50}) + ',' + // is_not_helpful
        faker.date.recent(90) + ',' + // date should be datetime, does it matter???
        '\n');
      k--;
    }

    i--;
  }
  file.end();
  j--;
}


